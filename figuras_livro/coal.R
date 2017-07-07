# Time to coalescent event

library(gridExtra)
library(ggplot2)
library(reshape2)
source("/Users/diogo/Dropbox/ensino/genepop-ensino/simulacoes/funcoes_deriva+mut.R")


t <- seq(0,200)

r <- as.data.frame(t)
r$ibd.10 <- pr.ibd(10,t)
r$ibd.20 <- pr.ibd(20,t)
r$ibd.50 <- pr.ibd(50,t)
r$ibd.100 <- pr.ibd(100,t)
r$ibs.20 <- 1 - trajectory.h(1,20,0.001,max(t)) # included ibd in dataframe

r <- melt(r, id="t")

a <- ggplot(data=r, aes(x=t, y=value, color=variable)) +
  geom_line(size=1.2) +
  ylab("Probabilidade de IBD") + xlab("Gerações")+
  annotate("text", x = c(20, 55, 100,150), y = c(0.75,0.7,0.6,0.5), label = c("N=10", "N=20", "N=50", "N=100"))

b <- a %+% subset( r, !(variable %in% c("ibs.20")))

r2 <- subset( r, (variable %in% c("ibs.20", "ibd.20")))

c <- ggplot(data=r2, aes(x=t, y=value, color=variable)) +
  geom_line(size=1.2) +
  ylab("Probabilidade de IBD/IBS") + xlab("Gerações")

#grid.arrange(b,c, ncol=1, nrow=2)
print(a)