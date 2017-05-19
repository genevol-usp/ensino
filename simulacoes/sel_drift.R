## set parameters

setwd("/Users/diogo/Dropbox/ensino/popgen_teaching/")

# Call function for the deterministic selection model
source("popgen_functions.R")

#N <- c(10, 100, 1000, 5000)

N <- 100
s
#N <- 50000 # number of chromossomes in sample (i.e. twice the number of diploid individuals)
#N <- 5000 # number of chromossomes in sample (i.e. twice the number of diploid individuals)
#N <- 500 # number of chromossomes in sample (i.e. twice the number of diploid individuals)
#N <- 10 # number of chromossomes in sample (i.e. twice the number of diploid individuals)

# generations
ngen <- 500

# selection coefficient
s <- 0.1
#s <- 0.001
#s <- 0.02
#s <- 0.1
#s <- 0.0

# dominance coefficient # h=0 dominant for fitness
h <- 0.5
#h <- 1 
#h <- 0

# initial allele frequency
f <- 0.1    # alelo vantajoso inicialmente presente em 10%
#f <- 0.002    # alelo vantajoso inicialmente presente em 0.2%
#f <- 10/N   # alelo vantajoso inicialmente presente em 10 cópias
#f <- 1/N    # alelo vantajoso inicialmente presente em cópia única
#f <- (N-1)/N # alelo vantajoso inicialmente presente em N-1 cópias, e deletéria em cópia única


# para simular o destino de uma mutação deletéria, supomos que todos
# menos um dos alelos são os vantajosos. Vamos explorar o efeito do
# tamanho populacional sobre a prob. de eliminação da da mutação
# deletéria.


# number of replicates
reps <- 1000

# number of fixations
#####

# Open plot device
#pdf("sel_drift_tese.pdf")
par(mfrow=c(2,2))
#plot(0, xlim=c(0, ngen), ylim=c(0, 1), type="n",
#     xlab="generation", ylab="frequency", 
#     main=paste("s =", s, "h =", h, "N =", N[n], ""))

### Looping over various N values

for(n in 1:length(N)) {
fix <- 0

    # testing including this step within loop
    plot(0, xlim=c(0, ngen), ylim=c(0, 1), type="n",
     xlab="generation", ylab="frequency", 
     #main=paste("s =", s, "h =", h, "N =", N[n], ""))
     main=paste("N =", N[n]))


## do the calculations reps times
for(i in 1:reps) { 
  
  # allele freq vector
  p <- numeric(ngen) 

  # initial frequency of allele "0"
  p[1] <- f
  # create the initial population vector
  pop <- rep(x=0:1, times=round(c(f, 1-f)*N[n]))  

  # for each subsequent generation
  for(j in 2:length(p)) { 
    pop <- sample(pop, replace=TRUE)  # one round of drift
    af  <- mean(pop == 0)            # take the frequency of allele "0" 
    p[j] <- delta.p(af, s, h)       # selectoin on the allele 
    pop <- rep(x=0:1, times=round(c(p[j], 1-p[j])*N[n]))  # make population based on new allele freq
  } 
    if(p[ngen] > 0){fix <- fix+1} # count fixations
 

  # plot the values for population i
  lines(p, type="l", col="black", lty=1) 
} 

# deterministic curve 
pd <- numeric(ngen) 
pd[1] <- f

for(i in 2:length(pd)) { 
   pd[i] <- delta.p(pd[i-1],  s , h) 
} 

# plot
lines(pd, lwd=3, col="red")


legend(x=200, y=0.3, legend=c("simulated", "deterministic"), lty=c(2,1), lwd=c(1,3), col=c("grey60","black"), bty="n")
text(200,0.4, paste("fix=",fix/reps))

}
#dev.off()
