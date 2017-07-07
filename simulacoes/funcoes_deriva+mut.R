## Funções de genética de populações

# Progressão de H ao longo do tempo sob deriva e mutação

# Cálculo da mudança de H entre duas gerações

delta.h <- function(H,N,u){H * (1 - (1/(2*N))) + ((1-H)*(2*u))}

trajectory.h <- function(H0,N,u,t)
    {
    h <- numeric()
    h[1] <- H0
    for(i in 1:t)
        {
        h[i+1] <- delta.h(h[i],N,u)
        }
    return(h)
    }

# Probability of coalescent of 2 lineages in generation t
# N diploid individuals, sample of n=2
pr.coal2.t <- function(N,t) {
  x <- 1/(2*N) * (1 - 1/(2*N))^(t-1)
  return(x)
}

# Prob. ibd
pr.ibd <- function(N,t) {
  x <- 1 - ( 1- (1/(2*N)))^t  
  return(x)
}
