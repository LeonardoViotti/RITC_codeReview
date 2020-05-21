#------------------------------------------------------------------------------#

#			Rwanda Feeder Roads  
#           GPS tracking data cleaning
#           MASTER

#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
#### Folder Structure

# Set up the folder where the data is
BCARS = "YOUR/DATA/PATH/HERE"
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


