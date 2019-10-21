source("setup_V4.R")
library(ncdf4)
library(SpecsVerification)

for (x in c("EU","GR","FR","ME")){
  # refc
  dirrefc      <- paste0("dirver",x,"refc")
  dirrefc      <- get(dirrefc)
  dir6         <- paste0(dirrefc,"step6")
  setwd(dir6)
  year <- as.character(c(1993:2016))
  lt    <- sprintf("%02d", c(3,4,5,6))
  mem   <- sprintf("%06d", c(0:24))
  ens  <- array(dim = c(length(year),length(mem)))
  dimnames(ens)[[1]] <- year
  dimnames(ens)[[2]] <- mem
  for (i in lt){
    print(paste0("here i start new with lt ",i))
    for (j in year){
      for (k in mem){
        file <- paste0(x,"_ab6_ens_refc_",j,"_",i,"_",k,"_JJA.nc")       
        print(file)
        nc <- nc_open(file)
        t2m <- ncvar_get(nc,"var167")
        ens[j,k] <- mean(t2m)
      }
    }
    assign(paste0("ensmem_",i),ens)
  }

  # era5
  direra      <- paste0("dirver",x,"era")
  direra      <- get(direra)
  dir3         <- paste0(direra,"/step3")
  setwd(dir3)
  year     <- as.character(c(1993:2016))
  obs      <- array(dim = length(year))
  row.names(obs) <- year
  for (l in year){
    file   <- paste0(x,"_ab6_ERA5_",l,"_JJA.nc")
    print(file)
    nc     <- nc_open(file)
    t2m    <- ncvar_get(nc,"var167")
    obs[l] <- mean(t2m)
  }

  #for (lt in sprintf("%02d", c(3,4,5,6))){
  #  ens    <- paste0("ensmem_",lt)
  #  ens    <- get(ens)
  #  rh     <- Rankhist(ens,obs)
  #  dirout <- paste0("dirver",x,"ima")
  #  dirverima <- get(dirout)
  #  filename <- paste0(dirout,"rankhist_prob",lt,".png")
  #  png(file=filename,width=5,height=5,units="in",res=600)
  #  PlotRankhist(rh, mode="prob.paper")
  #  dev.off()
  #}

  #for (lt in sprintf("%02d", c(3,4,5,6))){
  #  ens    <- paste0("ensmem_",lt)
  #  ens    <- get(ens)
  #  rh     <- Rankhist(ens,obs)
  #  dirout <- paste0("dirver",x,"ima")
  #  dirverima <- get(dirout)
  #  filename <- paste0(dirout,"rankhist_raw_",lt,".png")
  #  png(file=filename,width=5,height=5,units="in",res=600)
  #  PlotRankhist(rh)
  #  dev.off()
  #}
  filename <- paste0("rhisto_",x,".RData")
  getwd()
  save.image(file=filename)
}

                          
