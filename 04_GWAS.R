library(rMVP)


MVP.Data(fileBed = "1128_qc3", out = "demo")
pheno <- read.table("ebv.txt", header = TRUE)       
geno  <- attach.big.matrix("demo.geno.desc")         
map   <- read.table("demo.geno.map", header = TRUE)  


for(i in 2:ncol(pheno)){
  imMVP <- MVP(
    phe=pheno[, c(1, i)],
    geno=geno,
    map=map,
    #K=Kinship,
    #CV.GLM=Covariates,
    #CV.MLM=Covariates,
    #CV.FarmCPU=Covariates,
    #nPC.GLM=5,
    nPC.MLM=3,
    nPC.FarmCPU=3,
    priority="speed",
    ncpus=10,
    vc.method="BRENT",
    maxLoop=10,
    method.bin="static",
    #permutation.threshold=TRUE,
    #permutation.rep=100,
    threshold=0.05,
    method=c("MLM", "FarmCPU")
  )
  gc()
}

