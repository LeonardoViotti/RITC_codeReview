#------------------------------------------------------------------------------#

#			Rwanda Feeder Roads
#           GPS tracking data cleaning
#           MASTER

#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
#### Folder Structure

import os

# Set up the folder where the data is
BCARS = "/home/jovyan/work"
BCARS_RAW = os.path.join(BCARS, "Raw/")
BCARS_HFC = os.path.join(BCARS, "HFCs/")
BCARS_roads = os.path.join(BCARS, "Roads/")

# Create folder structure if it is not there
if not os.path.exists(BCARS_RAW):
    os.makedirs(BCARS_RAW)
if not os.path.exists(BCARS_HFC):
    os.makedirs(BCARS_HFC)
if not os.path.exists(BCARS_roads):
    os.makedirs(BCARS_roads)

from pyspark.sql import SparkSession
spark = SparkSession.builder.master('local[*]') \
    .config("spark.driver.maxResultSize", "2g") \
    .config("spark.sql.shuffle.partitions", "16") \
    .config("spark.driver.memory", "8g") \
    .config("spark.sql.session.timeZone", "UTC") \
    .getOrCreate()
