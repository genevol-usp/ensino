# Time to coalescent event

# Probability of coalescent of 2 lineages in generation t
# N diploid individuals, sample of n=2

pr.coal2.t <- function(N,t) {
x <- 1/(2*N) * (1 - 1/(2*N))^(t-1)
return(x)
}


pr.ibd <- function(N,t) {
x <- 1 - ( 1- (1/(2*N)))^t  
return(x)
}

 
t <- seq(1,100)

pcoal <-pr.coal2.t(10,t)
ibd <- pr.ibd(10,t)


result <- as.data.frame(cbind(t,pcoal))
result$cumulative <- cumsum(result$pcoal)
result$ibd <- pr.ibd(10,t)


par(mfrow=c(2,2))
plot(result$pcoal ~ result$t, ylab = "Tempo de coalescência", type="l")
plot(result$cumulative ~ result$t, ylab = "Tempo de coalescência", type="l")

plot(result$ibd ~ result$t, ylab = "IBD", type="l", ylim=c(0,1))
points(pr.ibd(5, t) ~ result$t, ylab = "IBD", type="l")
points(pr.ibd(3, t) ~ result$t, ylab = "IBD", type="l")
points(pr.ibd(20,t) ~ result$t, ylab = "IBD", type="l")
points(pr.ibd(100,t) ~ result$t, ylab = "IBD", type="l")

library(ggplot2)

p1 <- ggplot(data = result, aes(y=pcoal, x=t))+geom_line()
p2 <- ggplot(data = result, aes(y=cumulative, x=t))+geom_line()
p3 <- ggplot(data = result, aes(y=ibd, x=t))+geom_line()


grid.arrange(p1,p2, p3, ncol=2, nrow=2)
