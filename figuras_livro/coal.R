# Time to coalescent event

# Probability of coalescent of 2 lineages in generation t
# N diploid individuals, sample of n=2

pr.coal2.t <- function(N,t) {
x <- 1/(2*N) * (1 - 1/(2*N))^(t-1)
return(x)
}
 
t <- seq(1:100)

result <- pr.coal2.t(10,t)

plot(result ~ t, ylab = "Tempo de coalescência")
result