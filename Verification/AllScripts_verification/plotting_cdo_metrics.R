source("setup_V2.R")
source("setup_cdo.R")

metrics <- c("bias","rmse","mae")
for (i in dirs) {
  setwd(i)
  dir <- sub(paste0(pwd,"/"),"",i)
  for (j in metrics) {
    for (k in c("3","4","5","6")) {
      nc <- nc_open(paste0(j,"_lt_0",k,".nc"))
      var <- ncvar_get(nc, "var167")
      assign(paste0(j,"_",k,"_",dir),var)
      lat <- rev(ncvar_get(nc, "lat"))
      lon <- ncvar_get(nc, "lon")
      print(paste0(dir,"_",j," ",min(var)," ",max(var)))
    }
  }
}

metrics  <- ls(pattern = "bias|rmse|mae")

for (i in metrics) {
  if (grepl("bias", i)){
    print(paste0("bias! ",i))
    bk <- c(seq(min(c(bias_3_06,bias_3_07,bias_3_08,bias_3_season,bias_4_06,bias_4_07,bias_4_08,bias_4_season,bias_5_06,bias_5_07,bias_5_08,bias_5_season,bias_6_06,bias_6_07,bias_6_08,bias_6_season)),-2,length=1), seq(-2,0.5,0.5), max(c(bias_3_06,bias_3_07,bias_3_08,bias_3_season,bias_4_06,bias_4_07,bias_4_08,bias_4_season,bias_5_06,bias_5_07,bias_5_08,bias_5_season,bias_6_06,bias_6_07,bias_6_08,bias_6_season)))
    ticks <- c(seq(-2,0.5,0.5))
    mycol <- brewer.pal(length(bk)-1,"RdBu")
    mycol <- rev(mycol)
  } else if (grepl("rmse",i)){
    print(paste0("rmse! ",i))
    bk <- c(seq(min(c(rmse_3_06,rmse_3_07,rmse_3_08,rmse_3_season,rmse_4_06,rmse_4_07,rmse_4_08,rmse_4_season,rmse_5_06,rmse_5_07,rmse_5_08,rmse_5_season,rmse_6_06,rmse_6_07,rmse_6_08,rmse_6_season)),2.5,length=1), seq(2.5,5,0.5), max(c(rmse_3_06,rmse_3_07,rmse_3_08,rmse_3_season,rmse_4_06,rmse_4_07,rmse_4_08,rmse_4_season,rmse_5_06,rmse_5_07,rmse_5_08,rmse_5_season,rmse_6_06,rmse_6_07,rmse_6_08,rmse_6_season)))
    ticks <- c(seq(2.5,5,0.5))
    mycol <- brewer.pal(length(bk)-1,"Reds")
  } else {
    print(paste0("mae! ",i))
    bk <- c(seq(min(c(mae_3_06,mae_3_07,mae_3_08,mae_3_season,mae_4_06,mae_4_07,mae_4_08,mae_4_season,mae_5_06,mae_5_07,mae_5_08,mae_5_season,mae_6_06,mae_6_07,mae_6_08,mae_6_season)),1.5,length=1), seq(1.5,4,0.5), max(c(mae_3_06,mae_3_07,mae_3_08,mae_3_season,mae_4_06,mae_4_07,mae_4_08,mae_4_season,mae_5_06,mae_5_07,mae_5_08,mae_5_season,mae_6_06,mae_6_07,mae_6_08,mae_6_season)))
    ticks <- c(seq(1.5,4,0.5))
    mycol <- brewer.pal(length(bk)-1,"Reds")
  }
  z <- get(i)
  z <- mirror.matrix(z)
  filename <- paste0(dirverGRima,i, "_cdo_mean_of_orig.png")
  png(file=filename,width=6,height=5,units="in",res=600)
  par(mar=c(3, 3, 0.5, 0.5),cex.axis=0.7,cex.lab=0.5)
  image.plot(lon,lat,z,xlab = "", ylab = "",breaks = bk, col = mycol,axis.args=list(at=ticks,labels=names(ticks)))
  mtext(text = "Longitude", side = 1, line = 2)
  mtext(text = "Latitude", side = 2, line = 2)
  map("world",xlim = c(min(lon),max(lon)),ylim = c(min(lat),max(lat)),add = TRUE)
  grid(col="grey") 
  dev.off()
  rm(mycol,bk,ticks,z)
}

# control run for seasonal metrics = mean of the metrics of the individual months
for (lt in c(3,4,5,6)) {
  for (met in c("bias","rmse","mae")) {
    ar <- array(dim=c(nrow(rmse_3_06),ncol(rmse_3_06)))
    for (i in 1:nrow(rmse_3_06)) {
      for (j in 1:ncol(rmse_3_06)) {
        a <- paste0(met,"_",lt,"_06")
        a <- get(a)
        a_ <- a[i,j]
        b <- paste0(met,"_",lt,"_07")
        b <- get(b)
        b_ <- b[i,j]
        c <- paste0(met,"_",lt,"_08")
        c <- get(c)
        c_ <- c[i,j]
        all <- as.numeric(c(a_,b_,c_))
        ar[[i,j]]<- mean(all)
        assign(paste0("seas_",met,"_",lt),ar)
      }
    }
  }
  rm(ar,met,lt,a,a_,b,b_,c,c_,all)
}

### comparing lead times
## EU ##

s_bias <- ls(pattern = "bias_3_season|bias_4_season|bias_5_season|bias_6_season")
i_bias_06 <- ls(pattern = "bias_3_06|bias_4_06|bias_5_06|bias_6_06")
i_bias_07 <- ls(pattern = "bias_3_07|bias_4_07|bias_5_07|bias_6_07")
i_bias_08 <- ls(pattern = "bias_3_08|bias_4_08|bias_5_08|bias_6_08")
s_RmSe <- ls(pattern = "rmse_3_season|rmse_4_season|rmse_5_season|rmse_6_season")
i_RmSe_06 <- ls(pattern = "rmse_3_06|rmse_4_06|rmse_5_06|rmse_6_06")
i_RmSe_07 <- ls(pattern = "rmse_3_07|rmse_4_07|rmse_5_07|rmse_6_07")
i_RmSe_08 <- ls(pattern = "rmse_3_08|rmse_4_08|rmse_5_08|rmse_6_08")
s_Mae  <- ls(pattern = "mae_3_season|mae_4_season|mae_5_season|mae_6_season")
Mae_06 <- ls(pattern = "mae_3_06|mae_4_06|mae_5_06|mae_6_06")
Mae_07 <- ls(pattern = "mae_3_07|mae_4_07|mae_5_07|mae_6_07")
Mae_08 <- ls(pattern = "mae_3_08|mae_4_08|mae_5_08|mae_6_08")

indi_Maes <- ls(pattern = "Mae_")
for (i in indi_Maes) {
  list <- get(i)
  leadtime <- c()
  for (j in list) {
    met  <- substr(j,1,3)
    mon  <- substr(j,7,8)
    z    <- get(j)
    leadtime <- c(leadtime,mean(z))
    assign(paste0("mean_",mon,"_",met,"_lt"),leadtime)
  }
  rm(z,met,mon,j,list,leadtime)
}

indi_Bias <- ls(pattern = "i_bias_")
for (i in indi_Bias) {
  list <- get(i)
  leadtime <- c()
  for (j in list) {
    met  <- substr(j,1,4)
    mon  <- substr(j,8,9)
    z    <- get(j)
    leadtime <- c(leadtime,mean(z))
    assign(paste0("mean_",mon,"_",met,"_lt"),leadtime)
  }
  rm(z,met,mon,j,list,leadtime)
}

indi_RmSe <- ls(pattern = "i_RmSe_")
for (i in indi_RmSe) {
  list <- get(i)
  leadtime <- c()
  for (j in list) {
    met  <- substr(j,1,4)
    mon  <- substr(j,8,9)
    z    <- get(j)
    leadtime <- c(leadtime,mean(z))
    assign(paste0("mean_",mon,"_",met,"_lt"),leadtime)
  }
  rm(z,met,mon,j,list,leadtime)
}

leadtime <- c()
for (i in s_bias) {
  met  <- substr(i,1,4)
  z    <- get(i)
  leadtime <- c(leadtime,mean(z))
  assign(paste0("mean_seas_",met,"_lt"),leadtime)
}
rm(z,met,leadtime)

leadtime <- c()
for (i in s_Mae) {
  met  <- substr(i,1,3)
  z    <- get(i)
  leadtime <- c(leadtime,mean(z))
  assign(paste0("mean_seas_",met,"_lt"),leadtime)
}
rm(z,met,leadtime)

leadtime <- c()
for (i in s_RmSe) {
  met  <- substr(i,1,4)
  z    <- get(i)
  leadtime <- c(leadtime,mean(z))
  assign(paste0("mean_seas_",met,"_lt"),leadtime)
}
rm(z,met,leadtime)

mean_lt <- ls(pattern = "mean_seas_b|mean_seas_r|mean_seas_m")
filename <- paste0(dirverGRima,"GR_mean_lt_3.png")
png(file=filename,width=12,height=5,units="in",res=600)
par(mfrow=c(1, 3))
for (i in mean_lt) {
  met  <- substr(i,11,14)
  if (met == "bias"){
    print(paste0(i," yay!"))
    z <- get(i)
    y = c(3,2,1,0)
    plot(z,ylab=paste0(met),xlab="Lead time (in months)",type="b",xaxt="n",ylim=c(min(c(z,mean_06_bias_lt,mean_07_bias_lt,mean_08_bias_lt)),max(c(z,mean_06_bias_lt,mean_07_bias_lt,mean_08_bias_lt))))
    axis(1,at=c(1:4),label=y)
    lines(((mean_06_bias_lt+mean_07_bias_lt+mean_08_bias_lt)/3), lty=4, col="red")
    lines(mean_06_bias_lt, lty=2, type="b")
    lines(mean_07_bias_lt, lty =6, type="b")
    lines(mean_08_bias_lt, lty =3, type="b")
    abline(0,0,col = "blue")
    legend("bottomright", legend = c("Season","Mean of JJA metrics","June","July","August"),
           lty = c(1,4, 2, 6, 3), col = c("black","red","black","black","black"), cex = 0.8)
  } else if (met == "rmse"){
    print(i)
    z <- get(i)
    y = c(3,2,1,0)
    plot(z,ylab=paste0(met),xlab="Lead time (in months)",type="b",xaxt="n",ylim = c(min(c(z,mean_06_rmse_lt,mean_07_rmse_lt,mean_08_rmse_lt)),max(c(z,mean_06_rmse_lt,mean_07_rmse_lt,mean_08_rmse_lt))))
    axis(1,at=c(1:4),label=y)
    lines(mean_06_rmse_lt, lty=2, type="b")
    lines(mean_07_rmse_lt, lty =6, type="b")
    lines(mean_08_rmse_lt, lty =3, type="b")
    legend("bottomleft", legend = c("Season","June","July","August"),
           lty = c(1,4, 2, 6, 3), col = c("black","black","black","black"), cex = 0.8)
  } else {
    print(i)
    z <- get(i)
    y = c(3,2,1,0)
    plot(z,ylab=paste0(met),main = "Greater Region domain",xlab="Lead time (in months)",type="b",xaxt="n",ylim=c(min(z,mean_06_mae_lt,mean_07_mae_lt,mean_08_mae_lt),max(c(z,mean_06_mae_lt,mean_07_mae_lt,mean_08_mae_lt))))
    axis(1,at=c(1:4),label=y)
    lines(((mean_06_mae_lt+mean_07_mae_lt+mean_08_mae_lt)/3), lty=4, col="red")
    lines(mean_06_mae_lt, lty=2, type="b")
    lines(mean_07_mae_lt, lty =6, type="b")
    lines(mean_08_mae_lt, lty =3, type="b")
    legend("bottomleft", legend = c("Season","Mean of JJA metrics","June","July","August"),
           lty = c(1,4, 2, 6, 3), col = c("black","red","black","black","black"), cex = 0.8)
  }
}
dev.off()
rm(list = ls())

