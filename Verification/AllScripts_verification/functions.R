ACC_own = function(FC,OBS,CL){
  top <- mean((FC-CL)*(OBS-CL))
  bot <- sqrt(mean((FC-CL)^2)*mean((OBS-CL)^2))
  top/bot
}

RMSE_own = function(m, o){
  sqrt(mean((m - o)^2))
}

mirror.matrix = function(x){
    xx <- as.data.frame(x)
    xx <- rev(xx)
    xx <- as.matrix(xx)
    xx
}
