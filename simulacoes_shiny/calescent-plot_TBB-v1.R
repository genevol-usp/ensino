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

  if(hasArg(bottlen)){
    
    #nomeando
    bottlegen = list(...)$bottlegen
    bottlen = list(...)$bottlen
    
    #novacor
    colors <- c(colors, "grey")
    
    #verificando onde vai acontecer o gargalo
    if(hasArg(where)) where = list(...)$where
    else where = 1/2
    
    #definindo a geração do gargalo
    if ((ngen*where)%%1) mid = floor(ngen*where)
    else mid = ngen*where
    
    #novo numero total de gerações
    ngen = list(...)$bottlegen + ngen
    
    #iniciando
    popn<-matrix(NA,ngen+1,n)
    parent<-matrix(NA,ngen,n)
    popn[1,]<-1:n
    
    #gerações antes do gargalo
    for(i in 1:mid){
      parent[i,]<-sort(sample(1:n,replace=TRUE))
      popn[i+1,]<-popn[i,parent[i,]]
    }
    
    #primeira geração de gargalo
    i=i+1
    parent[i,]<-c(sort(sample(1:n, size = bottlen ,replace=TRUE)), seq(from = 0, to = 0, length.out = (n-bottlen)))
    popn[i+1,]<-c(popn[i,parent[i,]], seq(from = n+1, to = n+1, length.out = (n-bottlen)))
    
    #gerações seguintes de gargalo
    for(i in (mid+2):(mid+bottlegen)){
      parent[i,]<-c(sort(sample(1:bottlen, size = bottlen ,replace=TRUE)), seq(from = 0, to = 0, length.out = (n-bottlen)))
      popn[i+1,]<-c(popn[i,parent[i,]], seq(from = n+1, to = n+1, length.out = (n-bottlen)))
    }
    
    #primeira geração depois do gargalo
    i=i+1
    parent[i,]<-sort(sample(1:bottlen, size = n ,replace=TRUE))
    popn[i+1,]<-popn[i,parent[i,]]
    
    
    for(i in (mid+bottlegen+2):ngen){
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
      
      if(i >= (mid+1) & i <= (mid+bottlegen)){
        for(j in 1:bottlen){
          lines(c(parent[i,j],j),c(i-1,i),lwd=lwd,
                col=colors[popn[i+1,j]])
        }
      }
      else{
        for(j in 1:n){
          lines(c(parent[i,j],j),c(i-1,i),lwd=lwd,
                col=colors[popn[i+1,j]])
        } 
      }
      
      
      
      points(1:n,rep(i-1,n),col="grey",bg=colors[popn[i,]],pch=21,
             cex=cx.pt)
      points(1:n,rep(i,n),col="grey",bg=colors[popn[i+1,]],pch=21,
             cex=cx.pt)
      dev.flush()
      Sys.sleep(sleep)
    }
  }
  else {
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
  
}


#coalescent.plot(n=20,ngen=30,col.order="alternating")
#coalescent.plot(n=20,ngen=30,col.order="alternating", bottlegen = 20, bottlen = 10)
