### Felicitas Paixao ###
#
### preprocessing ecmwf seas5 re-forecast data ###

# setting pwd
source("setup_V4.R")

for (x in c("EU","GR","FR","ME")){
# setting variables for bash scripts
timemerge_era     <- paste0("./timemerge_erasc")
fc_JJA            <- paste0("./JJA_refcsc_V4")
era_grb2nc        <- paste0("./grb2nc_erasc")
fc_grb2nc         <- paste0("./grb2nc_refcsc")
split             <- paste0("./split_refcsc")
split_nc          <- paste0("./split_nc_refcsc")
minus1            <- paste0("./minus1timestep_bothsc_V4")
rename6           <- paste0("./renaming_06_bothsc_V4")
splitmon_refc     <- paste0("./splitmon_refc_bothsc")
splitmon_era      <- paste0("./splitmon_era_bothsc")
regrid_ensmem_era <- paste0("./regrid_ensmem_erasc_",x)
regrid_ensmem_refc<- paste0("./regridmem_",x,"_refcsc")
rename_mem        <- paste0("./rename_ensmem_refcsc_V4")
ab6               <- paste0("./ab6_ensmem_refcsc")

# step1
#dirrefc      <- paste0("dirver",x,"refc")
#dirverXrefc <- get(dirrefc) 
#setwd(dirverXrefc)
#print("split_refcsc")
#system(split)
#print("./split_nc_refcsc")
#system(split_nc)

# step2
#print("./grb2nc_refcsc")
#system(fc_grb2nc)

# step3
#refcstep3 <- paste0(dirverXrefc,"step3/")
#print("./JJA_refcsc_V4")
#system(fc_JJA)

# step4
#dirout          <- paste0("dirver",x,"bothrefc")
#dirverXbothrefc <- get(dirout)
#print("ensemble mean function in r -> dirverEUbothrefc")
#setwd(refcstep3)
#refcstep4 <- paste0(dirverXrefc,"step4/")
#years <- as.character(c(1993:2016))
#for (i in years){
#  for (j in sprintf("%02d", c(3,4,5,6))){
#    print(paste0(i," ",j))
#    x <- list.files(refcstep4,pattern="^ens")
#    val <- paste0(i,"_",j,".")
#    y <- grep(val,x, value=TRUE)
#    print(y)
#    if ( !file.exists(paste0(refcstep4,"ensmean_",i,"_",j,"_.nc"))){
#      print(paste0("getting ensmean_",i,"_",j,"_.nc with "))
#      print(paste0("calculating ensemble mean of ",y))
#      system(paste0("cdo ensmean ",y," ",dirverXbothrefc,"ensmean_",i,"_",j,"_.nc"))
#    }
#    rm(y,val)
#  }
}
rm(x)

### Preprocessing ERA5 ###

# step1
#direra     <- paste0("dirver",x,"era")
#dirverXera <- get(direra)
#setwd(dirverXera)
#print("timemerge_era")
#system(timemerge_era)

# step2
#print("era_grb2nc")
#system(era_grb2nc)

### process from 6hrl data on ###

#for (i in c("EU","GR","FR","ME")){
#    dir <- paste0("dirver",i,"both")
#    dir <- get(dir)
#    setwd(dir)
#    print(getwd())
#    print("minus1")
#    system(minus1)
#    print("rename6")
#    system(rename6)
#    print(paste0("regridrefc ",i))
#    system(paste0("./regrid_",i,"_refc"))
#    print("concatrefc")
#    system(paste0("./concat_refc_",i))
#    print("splitrefc")
#    system(splitmon_refc)
#    print("regridera")
#    system(paste0("./regrid_",i,"_era"))
#    print("concatera")
#    system(paste0("./concat_era_",i))
#    print("splitera")
#    system(splitmon_era)
#    dirseas  <- paste0("dirver",i,"bothseason")
#    dirseas  <- get(dirseas)
#    refc_dir <- paste0("dirver",i,"bothrefc")
#    setwd(get(refc_dir))
#    print(getwd())
#    system(paste0("cp all_years* ",dirseas))
#    era_dir <- paste0("dirver",i,"bothera")
#    setwd(get(era_dir))
#    print(getwd())
#    system(paste0("cp all_years* ",dirseas))
#}

for (i in c("EU","GR","FR","ME")){ 
    diriera <- paste0("dirver",i,"era")
    diriera <- get(diriera)
    setwd(diriera)
    print("regrid_ensmem_era")
    system(regrid_ensmem_era)
    dirirefc <- paste0("dirver",i,"refc")
    dirirefc <- get(dirirefc)
    setwd(dirirefc)
    print(getwd())
    print("ab6 enmem")
    system(ab6)
    print("rename refc")
    system(rename_mem)
    print("regrid_mem_refc")
    system(regrid_ensmem_refc)
}
