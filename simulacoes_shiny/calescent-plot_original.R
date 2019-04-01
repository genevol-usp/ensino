## plot a coalescent genealogy
## written by Liam J. Revell 2018

coalescent.plot<-function(n=10,ngen=20,colors=NULL,...){
  if(hasArg(sleep)) sleep<-list(...)$sleep
  else sleep<-0.2
  if(hasArg(lwd)) lwd<-list(...)$lwd
  else lwd<-2
  if(hasArg(mar)) mar<-list(...)$mar
  else mar<-c(2.1,4.1,2.1,1.1)
  if(is.null(colors)){ 
    colors<-rainbow(n=n)
    if(hasArg(col.order)) col.order<-list(...)$col.order
    else col.order<-"sequential"
    if(col.order=="alternating"){
      if(n%%2==1) 
        ii<-as.vector(rbind(1:((n+1)/2),1:((n+1)/2)+(n+1)/2))
      else
        ii<-as.vector(rbind(1:(n/2),n/2+1:(n/2)))
      colors<-colors[ii]
    }
  }
  popn<-matrix(NA,ngen+1,n)
  parent<-matrix(NA,ngen,n)
  popn[1,]<-1:n
  for(i in 1:ngen){
    parent[i,]<-sort(sample(1:n,replace=TRUE))
    popn[i+1,]<-popn[i,parent[i,]]
  }
  plot.new()
  par(mar=mar)
  plot.window(xlim=c(0.5,n+0.5),ylim=c(ngen,0))
  axis(2)
  title(ylab="time (generations)")
  cx.pt<-2*25/max(n,ngen)
  points(1:n,rep(0,n),bg=colors,pch=21,cex=cx.pt)
  for(i in 1:ngen){
    dev.hold()
    for(j in 1:n){
      lines(c(parent[i,j],j),c(i-1,i),lwd=lwd,
            col=colors[popn[i+1,j]])
    }
    points(1:n,rep(i-1,n),col="grey",bg=colors[popn[i,]],pch=21,
           cex=cx.pt)
    points(1:n,rep(i,n),col="grey",bg=colors[popn[i+1,]],pch=21,
           cex=cx.pt)
    dev.flush()
    Sys.sleep(sleep)
  }
}


		coalescent.plot(n=20,ngen=30,col.order="alternating")

