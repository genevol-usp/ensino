# Time to coalescent event

# Probability of coalescent of 2 lineages in generation t
# N diploid individuals, sample of n=2

pr.coal2.t <- function(N,t){

x <- ((1/(2*N))^(t-1)) * (1/(2*N))
return(x)
}
