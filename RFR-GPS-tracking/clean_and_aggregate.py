#------------------------------------------------------------------------------#

#			Rwanda Feeder Roads  
#           GPS tracking data cleaning

#------------------------------------------------------------------------------#

# Porpuse: 

# WARNING: This depends on _master.py to run!

#------------------------------------------------------------------------------#
#### Settings 

EXPORT = False
DATA_BRICKS = False

# conda activate largedata
# pyspark

# Import pyspark functions
from pyspark.sql import functions as F
from pyspark.sql import Window

# Import specific pyspark functions
from pyspark.sql.functions import to_date, to_timestamp, hour
from pyspark.sql.functions import col, countDistinct, bround, row_number, lit
from pyspark.sql.functions import concat, lag

# Import other libraries and functions
from calendar import monthrange
import datetime as dt
import pandas as pd

# Settings
dates = '2020_MARCH_01_13'
year = 2019
month = 9


# Set filepath conditional on Data Bricks switch
if DATA_BRICKS:
    PATH = 'dbfs:/mnt/SpeedGovernorsTrackingData/'
else:
    # Root local file paths
    ROADS_path = BCARS_roads
    PATH = BCARS_RAW


#------------------------------------------------------------------------------#
# Import globals

date_range_str =  str(year)  + '_' + str('{:02d}'.format(month))

# Positions data
file_name = 'positions_' + dates + '.csv'

# Contains vehicle type
devices_file_name = 'devices_' + str(year) + '.csv'

#------------------------------------------------------------------------------#
# Import data

# Set import function conditional on platform. If local, just import
# within file system, if on Data Bricks, import from Data Lakes
def import_data(filepath, data_bricks = DATA_BRICKS):
    if(data_bricks):
        data = spark\
            .read.format('csv')\
            .options(header='true', inferSchema='true')\
            .load(filepath)
    else:
        data = spark\
            .read.options(header= True, inferSchema= True)\
            .csv(filepath)
    return(data)

# Positions tables that contains vehicle location
braw = import_data(PATH + file_name)
# braw.show(5)

# Devices table that contains vehicle types
devices = import_data(PATH + devices_file_name)    

# Combined roads
roads = import_data(PATH + 'Roads/' + 'nat_dis_fr_combined.csv')  

# LVTP corridor
cor = import_data(PATH + 'Roads/' + 'LVTP_corridor.csv')  

# # Data Bricks/ Data lakes path
# braw = spark\
#     .read.format('csv')\
#     .options(header='true', inferSchema='true')\
#     .load('dbfs:/mnt/SpeedGovernorsTrackingData/' + file_name)


#------------------------------------------------------------------------------#
# Cleaning

# Remove unecessary variables
dropVars =  ["protocol", 
             "altitude",
             "address",
             "attributes",
             "accuracy",
             "network"]

braw = braw.drop(*dropVars)

# Convert dates
#braw.select('devicetime').show()
braw = braw.withColumn('date', to_date(col('devicetime')))
braw = braw.withColumn('time', to_timestamp(col('devicetime')))
braw = braw.withColumn('hour', hour(col('devicetime')))


# Remove out of range obs
min_date = dt.datetime(year, month, 1) 
max_date = dt.datetime(year, 
                       month, 
                       monthrange(year, month)[1]) 
braw = braw.filter((braw.date >= min_date) & (braw.date <= max_date))

# Convert speeds - For some reason speeds are in knots
braw =  braw.withColumn('speed', col('speed')* 1.852)


# Remove missings in coordiantes
braw = braw.filter(~((braw.latitude == 0 ) | (braw.longitude == 0)))
 
#------------------------------------------------------------------------------#
# Process and aggregate

# Round coordiantes
braw = braw.withColumn('y', bround(col('latitude'), 3) )
braw = braw.withColumn('x', bround(col('longitude'), 3) )

# Create unique bin id
braw = braw.withColumn('locid', concat(col('x'), col('y')) )


# Create bin order varaible, that is if a vehicle is in a square, 
# moves out of it, and comes back in the same day they are counted
# as different obs. Same goes for going and coming back in the same
# day.

#  lag position
# https://stackoverflow.com/questions/34295642/spark-add-new-column-to-dataframe-with-value-from-previous-row
w = Window().partitionBy('deviceid').orderBy(col("time"))
braw = braw.select("*", lag("locid").over(w).alias("locid_l"))

# Create locid and locid lag comparison to test if vehicle moved.
braw = braw.withColumn('moved', (col('locid') != col('locid_l'))\
    .cast('integer') )

# Cumsum of moving out of position boolean, i.e. the positon order
braw = braw.withColumn('loc_order', F.sum('moved').over(w))


# Create order variable 
# https://stackoverflow.com/questions/45513959/pyspark-get-row-number-for-each-row-in-a-group
# braw = braw\
#     .withColumn("row_num", 
#                 row_number()\
#                 .over(Window\
#                     .partitionBy("deviceid")\
#                     .orderBy("time")))

# Aggregate on rounded coordiantes, in practice creating a 100m grid.
bagg = braw\
    .groupBy(['deviceid', 'x', 'y', 'date', 'loc_order'])\
    .agg(F.countDistinct('id'),
         F.mean('speed'),
         F.min('speed'), 
         F.max('speed'),
         F.sum(F.when(F.col('speed') > 0, 1)), # obs with movement
         F.min('time'), 
         F.max('time') )\
    .orderBy(['deviceid', 'date', 'min(time)'])

    #.show()

# Rename columns
bagg = bagg\
    .withColumnRenamed('count(DISTINCT id)', 'n_obs')\
    .withColumnRenamed('avg(speed)', 'avg_speed')\
    .withColumnRenamed('min(speed)', 'min_speed')\
    .withColumnRenamed('max(speed)', 'max_speed')\
    .withColumnRenamed('sum(CASE WHEN (speed > 0) THEN 1 END)', 
                       'n_obs_speed')\
    .withColumnRenamed('min(time)', 'in_time')\
    .withColumnRenamed('max(time)', 'out_time')



#------------------------------------------------------------------------------#
#  Merge with device table
 
devices = devices.drop('phone') # Remove phone
 
bagg = bagg.join(devices, bagg.deviceid ==  devices.id)        


#------------------------------------------------------------------------------#
# Add Road Location

# Add all roads
bagg = bagg.join(roads, ['x', 'y'], how="leftouter")        

# Add dummy if on corridor
cor = cor.withColumn('lvtp', lit(1))\
    .select(['x', 'y', 'lvtp'])

bagg = bagg.join(cor, ['x', 'y'], how="leftouter")\
    .na.fill({'lvtp' : 0}) 
# >>> bagg.count()
# 6681138

#------------------------------------------------------------------------------#
# Export

save_name = 'cleanTEMP' + '.csv'

if DATA_BRICKS & EXPORT:
  bagg.coalesce(1)\
        .write.format('com.databricks.spark.csv')\
        .mode('overwrite')\
        .option('header', 'true')\
        .save(PATH + 'Outputs/' + 'test.csv' )
elif EXPORT:
    # Select just a couple of devices to save for now
    bagg_sample = bagg.filter(bagg.deviceid.isin([243, 1127, 148, 1342]))

    # bagg.write.csv(save_name)
    bagg_sample.toPandas().to_csv(save_name, index = False)

# bagg\
#     .coalesce(1)\
#     .write.option("header", "true")\
#     .csv(save_name)


#------------------------------------------------------------------------------#
# DRAFT CODE




# create pandas dataframe
# df = pd.DataFrame({'id':[1,1,1,2,2,2], 
#                    'speed':[1,12,0,3,3,3]})
    
# # convert to spark dataframe
# df = spark.createDataFrame(df)

# df.groupBy('id')\
#     .agg( F.sum(F.when(F.col('speed') > 0, 1))    ).show()
    
# bagg.select('deviceid').distinct().show()
# +--------+
# |deviceid|
# +--------+
# |     148|
# |     463|
# |     496|
# |     833|
# |    1088|
# |    1238|
# |    1342|
# |    1580|
# |    2366|
# |    2659|
# |    2866|
# |     243|
# |     623|
# |     858|
# |     897|
# |    1025|
# |    1084|
# |    1127|
# |    1395|
# |    1460|
# +--------+
