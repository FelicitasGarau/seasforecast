### this script is to remain in the setup folder ###
### installes packages for master's thesis ###

listofpackages <- c("abind","geomapdata","GEOmap","easyNCDF","viridisLite","viridis","Metrics","openair","colorspace","fanplot","verification","knitr","miniUI","maps","mapdata","maptools","leaflet","sp","ggplot2","dplyr","tidyr","plyr","gridExtra","psych","data.table","plotrix","ncdf4","chron","RColorBrewer","easyVerification","reshape2","ggpubr","pROC","raster","SpecsVerification","magicfor","lubridate","SimDesign")
#new.packages <- listofpackages[!(listofpackages %in% installed.packages()[,"Package"])]
#invisible(if(length(new.packages)) install.packages(new.packages))

invisible(lapply(listofpackages, library, character.only = TRUE))
rm(listofpackages)
#rm(new.packages)
