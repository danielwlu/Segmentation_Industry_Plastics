# Project Name: "Segmentation_Industry_Plastics"
rm(list = ls( )) # clean up the workspace

######################################################################

# THESE ARE THE PROJECT PARAMETERS NEEDED TO GENERATE THE REPORT

# When running the case on a local computer, modify this in case you saved the case in a different directory 
# (e.g. local_directory <- "C:/user/MyDocuments" )
# type in the Console below help(getwd) and help(setwd) for more information
local_directory <- getwd()

cat("\n *********\n WORKING DIRECTORY IS ", local_directory, "\n PLEASE CHANGE IT IF IT IS NOT CORRECT using setwd(..) - type help(setwd) for more information \n *********")

# Please ENTER the name of the file with the data used. The file should contain a matrix with one row per observation (e.g. person) and one column per attribute. THE NAME OF THIS MATRIX NEEDS TO BE ProjectData (otherwise you will need to replace the name of the ProjectData variable below with whatever your variable name is, which you can see in your Workspace window after you load your file)
datafile_name="Plastics"

# this loads the selected data: DO NOT EDIT THIS LINE
ProjectData <- read.csv(paste(paste(local_directory, "data", sep="/"), paste(datafile_name,"csv", sep="."), sep = "/"), sep=";", dec=",") # this contains only the matrix ProjectData
ProjectData=data.matrix(ProjectData) # make sure the data are numeric!!!! check your file!

# Please ENTER a name that describes the data for this project (which will appear on the titles of the plots)
data_name="Plastics Company"

#### Factor Analysis parameters

# Please ENTER the number of factors to eventually use for this report
numb_factors_used = 2

# Please ENTER the rotation eventually used (e.g. "none", "varimax", "quatimax", "promax", "oblimin", "simplimax", and "cluster" - see help(principal)). Defauls is "varimax"
rotation_used="varimax"

# Please ENTER the selection criterions for the factors to use. 
# Choices: "eigenvalue", "variance", "manual"
factor_selectionciterion = "variance"

# Please ENTER the desired minumum variance explained (in case "variance" is the factor selection criterion used). 
minimum_variance_explained = 65  # between 1 and 100

# Please ENTER the number of factors to use in case "manual" is the factor selection criterion used
manual_numb_factors_used = 2

# Please ENTER then original raw attributes to use (default is 1:ncol(ProjectData), namely all of them)
factor_attributes_used= (min(ncol(ProjectData),2)):(min(ncol(ProjectData),30))
#factor_attributes_used= which(sapply(colnames(ProjectData), function (s) str_detect(s,"Q1_")))
# Please ENTER the distance metric eventually used for the clustering in case of hierarchical clustering (e.g. "euclidean", "maximum", "manhattan", "canberra", "binary" or "minkowski" - see help(dist)). Defauls is "euclidean"
distance_used="euclidean"

#### Clustering parameters

# Please ENTER the number of clusters to eventually use for this report
numb_clusters_used = 5

# Please ENTER then original raw attributes to use for the segmentation (the "segmentation attributes")
segmentation_attributes_used= (min(ncol(ProjectData),2)):(min(ncol(ProjectData),27))

# Please ENTER then original raw attributes to use for the profiling of the segments (the "profiling attributes")
profile_attributes_used=(min(ncol(ProjectData),28)):(min(ncol(ProjectData),35))
profile_attributes_used1=2:30
profile_attributes_used2=48:52
profile_attributes_used3=31:47
# Please enter the minimum number below which you would like not to print - this makes the readability of the tables easier. Default values are either 10e6 (to print everything) or 0.5. Try both to see the difference.
MIN_VALUE=0.4

# Please enter the maximum number of observations to show in the report and slides 
# (DEFAULT is 50. If the number is large the report and slides may not be generated - very slow or will crash!!)
max_data_report = 50 # can also chance in server.R
###########################
# Would you like to also start a web application on YOUR LOCAL COMPUTER once the report and slides are generated?
# Select start_webapp <- 1 ONLY if you run the case on your local computer
# NOTE: Running the web application on your LOCAL computer will open a new browser tab
# Otherwise, when running on a server the application will be automatically available
# through the ShinyApps directory

# 1: start application on LOCAL computer, 0: do not start it
# SELECT 0 if you are running the application on a server 
# (DEFAULT is 0). 
start_local_webapp <- 0
# NOTE: You need to make sure the shiny library is installing (see below)

################################################
# Now run everything

ProjectDataFactor=ProjectData[,factor_attributes_used]
source(paste(local_directory,"R/library.R", sep="/"))
if (require(shiny) == FALSE) 
  install_libraries("shiny")
source(paste(local_directory,"R/heatmapOutput.R", sep = "/"))
source(paste(local_directory,"R/runcode.R", sep = "/"))

if (start_local_webapp){
  
  # first load the data files in the data directory so that the App see them
  Plastics <- read.csv(paste(local_directory, "data/Plastics.csv", sep = "/"), sep=";", dec=",") # this contains only the matrix ProjectData
  Plastics=data.matrix(Plastics) # this file needs to be converted to "numeric"....
  
  # now run the app
  runApp(paste(local_directory,"tools", sep="/"))  
}

