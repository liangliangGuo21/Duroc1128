library(rMVP)

pheno <- read.table("phe1.txt", header = TRUE)       
geno  <- attach.big.matrix("demo.geno.desc")         
map   <- read.table("demo.geno.map", header = TRUE)  


yourdata <-read.table("Cov.txt",sep="\t",header = T)
Covariates_PC <- bigmemory::as.matrix(attach.big.matrix("demo.pc.desc"))
Covariates <- model.matrix(~as.factor(farm)+as.numeric(age), data=yourdata)
Covariates <- cbind(Covariates, Covariates_PC)


for(i in 122:ncol(pheno)){
  imMVP <- MVP(
    phe=pheno[, c(1, i)],
    geno=geno,
    map=map,
    #K=Kinship,
    #CV.GLM=Covariates,
    CV.MLM=Covariates,
    #CV.FarmCPU=Covariates,
    nPC.GLM=0,
    nPC.MLM=0,
    nPC.FarmCPU=0,
    ncpus=20,
    vc.method="BRENT",
    maxLoop=10,
    method.bin="static",
    #permutation.threshold=TRUE,
    #permutation.rep=100,
    threshold=0.05,
    method="MLM",
    priority="speed"
  )
  gc()
}

