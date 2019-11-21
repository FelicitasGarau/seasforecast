### data setup ###

# setting pwd
pwd <- normalizePath(dirname(sys.frame(1)$ofile))  # will print the working dir always as the folder this script is in

# run installes_packages.R first
# install packages from source
#source(paste0(pwd,"/installed_packages.R"))

# some useful functions
#source(paste0(pwd,"/functions.R"))

setwd(pwd)
# creating directories
for (x in c("EU","GR","FR","ME")) {
  dir.create("operational/")
  dirop                                              <- paste0(pwd, "/operational")
  dir.create(paste0("operational/",x))
  diropx                                             <- paste0(dirop,"/", x, "/")
  assign(paste0("dirop",x),diropx)
  dir.create("verification")
  dirver                                             <- paste0(pwd, "/verification")
  dir.create(paste0("verification/",x))
  dirverx                                            <- paste0(dirver, "/",x,"/")
  assign(paste0("dirver",x),dirverx)
  dir.create(paste0(diropx, "EOBS/"))
  diropxeobs                                         <- paste0(diropx, "EOBS/")
  assign(paste0("dirop",x,"eobs"),diropxeobs)
  dir.create(paste0(diropx, "forecast/"))
  diropxfc                                           <- paste0(diropx, "forecast/")
  dir.create(paste0(dirverx, "ERA5/"))
  dirverxera                                         <- paste0(dirverx, "ERA5/")
  assign(paste0("dirver",x,"era"),dirverxera)
  setwd(dirverxera)
  stepnames                                          <- c("step1", "step2", "step3")
  lapply(stepnames, dir.create)
  setwd(pwd)
  dir.create(paste0(dirverx, "reforecast/"))
  dirverxrefc                                        <- paste0(dirverx, "reforecast/")
  assign(paste0("dirver",x,"refc"),dirverxrefc)
  setwd(dirverxrefc)
  stepnames                                          <- c("step1", "step2", "step3", "step4", "step5", "step6")
  lapply(stepnames, dir.create)
  dir.create(paste0(dirverx, "both/"))
  dirverxboth                                        <- paste0(dirverx, "both/")
  assign(paste0("dirver",x,"both"),dirverxboth)
  dir.create(paste0(dirverxboth,"season/"))
  dirverxbothseason                                  <- paste0(dirverxboth,"season")
  assign(paste0("dirver",x,"bothseason"),dirverxbothseason)
  dir.create(paste0(dirverxboth,"06/"))
  dirverxboth06                                      <- paste0(dirverxboth,"06")
  assign(paste0("dirver",x,"both06"),dirverxboth06)
  dir.create(paste0(dirverxboth,"07/"))
  dirverxboth07                                      <- paste0(dirverxboth,"07")
  assign(paste0("dirver",x,"both07"),dirverxboth07)
  dir.create(paste0(dirverxboth,"08/"))
  dirverxboth08                                      <- paste0(dirverxboth,"08")
  assign(paste0("dirver",x,"both08"),dirverxboth08)
  dir.create(paste0(dirverxboth,"ERA_6hrl/"))
  dirverxbothera                                     <- paste0(dirverxboth,"ERA_6hrl")
  assign(paste0("dirver",x,"bothera"),dirverxbothera)
  dir.create(paste0(dirverxboth,"refc_6hrl/"))
  dirverxbothrefc                                    <- paste0(dirverxboth,"refc_6hrl")
  assign(paste0("dirver",x,"bothrefc"),dirverxbothrefc)
  setwd(pwd)
  dir.create(paste0(dirverx, "final/"))
  dirverxfin                                         <- paste0(dirverx, "final/")
  assign(paste0("dirver",x,"fin"),dirverxfin)
  dir.create(paste0(dirverxfin, "images/"))
  dirverxima                                         <- paste0(dirverxfin, "images/")
  assign(paste0("dirver",x,"ima"),dirverxima)
}

# aquireing permissions
setwd(pwd)
system("chmod u+x *_cdosc")
system("chmod u+x *erasc*")
system("chmod u+x *refcsc*")

# copying scripts to desired destinations
for (i in c("ME","EU","GR","FR")){
  for (j in c("06","07","08","season")) {
    dir  <- paste0("dirver",i,"both",j)
    diri <- get(dir)
    print(paste0("cp *_cdosc ",diri))
    system(paste0("cp *_cdosc ",diri))
  }
}

for (i in c("ME","EU","GR","FR")){
  for (j in c("era","refc")){
    dir  <- paste0("dirver",i,"both")
    diri <- get(dir)
    system(paste0("cp concat_",j,"_",i," ",diri))
    system(paste0("cp regrid_",i,"_",j," ",diri))
    system(paste0("cp *bothsc* ",diri)) 
  }
}

for (i in c("ME","FR","EU","GR")){
  for (j in c("era","refc")){
    dir  <- paste0("dirver",i,j)
    diri <- get(dir)
    print(paste0("cp *",j,"sc* ",diri))
    system(paste0("cp *",j,"sc* ",diri))
    #system(paste0("cp step0",j," ",diri))
  }
}
