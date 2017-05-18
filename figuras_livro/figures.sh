# Script para ilustrar a relação entre frequencias genotipcas e alelicas


# Definir diretorio com dados do 1000 Genomas
# definir arquivo a ser usado, phase 3

datadir=/raid/genevol/1kg/phase3/data/phase3_chr/
file=ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz

# montar lista de amostras YRI para analise. 
grep YRI  samples_all > yri_samples


# geracao de arquivo com hw e outro com frquencias
vcftools --gzvcf $datadir/$file --freq --max-alleles 2 --chr 21  --out chr21
vcftools --gzvcf $datadir/$file --chr 21 --max-alleles 2 --hardy  --out chr21
vcftools --gzvcf $datadir/$file --chr 21 --keep-only-indels --max-alleles 2 --hardy  --out chr21_indels




#  merge dos dois para alguns testes
join -1 2 -2 2 chr21.frq chr21.hwe > chr21.dat

# identificacao de problema causado por rsids duplicados
# problem is a bunch of lines have rsids which are identical
# awk '{print $2}' chr21.frq | uniq -c | awk '$1>=2{print $2}' > multiallelic # to see these repeated cases.o

# geracao do arquivo com entradas duplicadas para ser removido
vcftools --gzvcf $datadir/$file --freq --exclude-positions multiallelic --keep data/yri_samples --max-alleles 2 --chr 21  --out chr21_yri &

vcftools --gzvcf $datadir/$file --chr 21 --exclude-positions multiallelic  --keep data/yri_samples --max-alleles 2 --hardy  --out chr21_yri &

vcftools --gzvcf $datadir/$file --chr 21 --exclude-positions multiallelic  --keep data/yri_samples --max-alleles 2 --hardy --keep-only-indels --out chr21_yri_indels &

join -1 2 -2 2 chr21_yri.frq chr21_yri.hwe > chr21_yri.dat

#generates a clean file for processing in R
awk '{print $1, $5, $8}' chr21_yri.dat | sed -e 's/:/ /g' | sed -e 's/\// /g' > chr21_yri_sum.dat

# generating a clean file from th HW data


awk '{print $2, $3}' chr21_yri_indels.hwe | sed -e 's/\// /g' > chr21_yri_indels_sum.dat


# R script
setwd("/raid/genevol/users/diogo/scripts/")
dat <- read.table("chr21_yri_sum.dat", skip=1, col.names=c("rsid", "ref.allele", "ref.freq", "ref.ref", "ref.alt", "alt.alt"))
dat <- dat[dat$ref.freq < 0.95 & dat$ref.freq > 0.05,]
#the above filters out the rare and common variants, which obscure the patterns for the HW plot

# Estimating allele frequencies from the genotypes
total<-dat$ref.ref+dat$ref.alt+dat$alt.alt
freq <- (2*(dat$ref.ref)+dat$ref.alt) /   (2*total)
plot(freq, dat$ref.freq)

library(kimisc)
s.dat <- sample.rows(dat,5000)






# confirms that the frequency is exactly matching expectations from genotypes.


# for the heterozygotes
pdf("hw.pdf")
par(mfrow=c(3,3))
#plot(freq , dat$ref.alt/(dat$ref.ref+dat$ref.alt+dat$alt.alt))
smoothScatter(freq , dat$ref.alt/total, ylab="Frequência do genótipo", xlab="Frequência do alelo ref."); points(freq, 2*freq*(1-freq), pch=".")
smoothScatter(freq , dat$ref.ref/total, ylab="", xlab="Frequência do alelo ref.", main="Homozigotos ref/ref"); points(freq, freq^2)
smoothScatter(freq , dat$alt.alt/total, ylab="", xlab="Frequência do alelo ref.", main="Homozigotos alt/alt" ); points(freq, (1-freq)^2)
dev.off()


# for indels
awk '{print $2, $3}' chr21_yri_indels.hwe | sed -e 's/\// /g' > chr21_yri_indels_sum.dat
dat <- read.table("chr21_yri_indels_sum.dat", skip=1, col.names=c("rsid", "ref.ref", "ref.alt", "alt.alt")  )
total<-dat$ref.ref+dat$ref.alt+dat$alt.alt
freq <- (2*(dat$ref.ref)+dat$ref.alt) /   (2*total)
smoothScatter(freq , dat$ref.alt/total); points(freq, 2*freq*(1-freq), lty=1, lwd=1 )

library(kimisc)
sample.rows(dat,1000)

plot(freq , dat$ref.alt/total, ylab="Frequência do genótipo", xlab="Frequência do alelo ref.", ylim=c(0,1))
points(freq , dat$alt.alt/total, ylab="", xlab="Frequência do alelo ref.", main="Homozigotos alt/alt", col="blue")
points(freq , dat$ref.ref/total, ylab="", xlab="Frequência do alelo ref.", main="Homozigotos ref/ref", col="red")

# making the theoretical lines
x <- seq(0,1,0.01)
lines(x, x^2, lwd=3, col="gray")
lines(x, (1-x)^2, lwd=3, col="gray")
lines(x, 2*(1-x)*x, lwd=3, col="gray")


