setwd(pwd)
for (m in c("06","07","08")){
  dir <- paste0("dir",m)
  setwd(get(dir))
  for (lt in c(3,4,5,6)){
    refc_n <- paste0("all_years_refc_0",lt,"_",m,".nc")
    era_n  <- paste0("all_years_era5_",m,".nc")
    refc     <- nc_open(refc_n)
    lat <- rev(ncvar_get(refc, "lat"))
    lon <- ncvar_get(refc, "lon")
    refc_t2m <- ncvar_get(refc,"var167")
    era      <- nc_open(era_n)
    era_t2m  <- ncvar_get(era,"var167")
    rmse_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
    mae_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
    bias_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
    for (j in 1:nrow(refc_t2m)) {
      for (k in 1:ncol(refc_t2m)) {
        rmse_ar[[j,k]] <- RMSE_own(refc_t2m[j,k,],era_t2m[j,k,])
        # rmse_ar[[j,k]] <- mean(refc_t2m[j,k,]-era_t2m[j,k,])
        assign(paste0("rmse_",lt,"_",m),rmse_ar)
        mae_ar[[j,k]] <-mean( abs(refc_t2m[j,k,] - era_t2m[j,k,]))
        # mae_ar[[j,k]] <-mean( abs(refc_t2m[j,k,] - era_t2m[j,k,]))
        assign(paste0("mae_",lt,"_",m),mae_ar)
        bias_ar[[j,k]] <- mean(refc_t2m[j,k,]-era_t2m[j,k,])
        assign(paste0("bias_",lt,"_",m),bias_ar)
      }
    }
  }
  rm(era_t2m,refc_t2m,refc_n,lt,m,k,j,era_n,rmse_ar,mae_ar,bias_ar,refc,era)
}

# seasonal metrics
setwd(dirseas)
for (lt in c(3,4,5,6)){
  refc_n   <- paste0("all_years_refc_0",lt,".nc")
  era_n    <- paste0("all_years_era5.nc")
  refc     <- nc_open(refc_n)
  lon <- ncvar_get(refc, "lon")
  lat <- rev(ncvar_get(refc, "lat"))
  refc_t2m <- ncvar_get(refc,"var167")
  era      <- nc_open(era_n)
  era_t2m  <- ncvar_get(era,"var167")
  rmse_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
  mae_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
  bias_ar <- array(dim = c(nrow(refc_t2m),ncol(refc_t2m)))
  for (j in 1:nrow(refc_t2m)) {
    for (k in 1:ncol(refc_t2m)) {
      rmse_ar[[j,k]] <- RMSE_own(refc_t2m[j,k,],era_t2m[j,k,])
      assign(paste0("rmse_",lt,"_season"),rmse_ar)
      mae_ar[[j,k]] <-mean( abs(refc_t2m[j,k,] - era_t2m[j,k,]),na.rm=TRUE) 
      assign(paste0("mae_",lt,"_season"),mae_ar)
      bias_ar[[j,k]] <- mean(refc_t2m[j,k,]-era_t2m[j,k,],na.rm=TRUE)
      assign(paste0("bias_",lt,"_season"),bias_ar)
    }
  }
  rm(rmse_ar,mae_ar,bias_ar,era,refc,era_n,refc_n,j,k,lt)
}
