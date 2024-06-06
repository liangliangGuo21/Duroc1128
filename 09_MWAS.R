# Two-part model analysis
require(stats) 
twoPart_parametric = 	function(rarefyOTU=NULL, 	trait=NULL, fixed_effect = my_fixed_effect,	covariates=NULL, log2.transform=F) { 
  if (is.null(rarefyOTU) | is.null(trait) ) { 
    cat ("rarefyOTU\n") 
    cat("trait\n") 
    cat("covariates\n") 
   	stop() 
  }
  k 	= 	length(rarefyOTU) 
  k0 	= 	which(rarefyOTU == 0 ) 
  k1 	= 	which(rarefyOTU > 0 ) 
  p1 	= 	c(0, 0, 0, 1) 
  p2 	= 	c(0, 0, 0, 1) 
  if (length(k0)>= 20 & length(k1)>=20) {  	 	c1 	= 	rep(0, length=length(rarefyOTU)) 
  c1[k1] 	= 	1 
  if (is.null(covariates)) { 
    model1 	= 	lm(trait~my_fixed_effect+c1) 
  } else { 
    model1 	= 	lm(trait~covariates+my_fixed_effect+c1) 
  } 
  if(is.element("c1", rownames(summary(model1)$coefficients))) { 
    p1  = summary(model1)$coefficients["c1",] 
  } 
} 
if (length(k1)>= 20) {
  if (log2.transform) { 
        c2 	= 	log2(rarefyOTU[k1])  	 	
        } else c2 = 	rarefyOTU[k1]  	 	
        if (is.null(covariates)) { 
            model2 	= 	lm(trait[k1]~my_fixed_effect+c2) 
    } else { 
            model2 	= 	lm(trait[k1]~covariates[k1,]+my_fixed_effect[k1,]+c2) 
    } 
    if(is.element("c2", rownames(summary(model2)$coefficients))) {
      p2  = summary(model2)$coefficients["c2",] 
    } 
} 
  p1.z = 	abs(qnorm(p1[4]/2))  	
  p2.z = 	abs(qnorm(p2[4]/2))  	
  if (!is.na(p1[3]) & p1[3]<0) p1.z = -1*p1.z  	
  if (!is.na(p2[3]) & p2[3]<0) p2.z = 	-1*p2.z 
  w.meta.z  	= 	(p1.z*k+p2.z*length(k1))/sqrt(k^2+length(k1)^2) 
  w.meta.p  	= 	(1-pnorm(abs(w.meta.z)))*2 
  uw.meta.z 	 	= 	(p1.z+p2.z)/sqrt(2) 
  uw.meta.p 	 	= 	(1-pnorm(abs(uw.meta.z)))*2 
  minP 	 	 	= 	 p.adjust(min(c(p1[4], p2[4], uw.meta.p)),"fdr") 
  z = c(p1.z, p2.z, uw.meta.z)  
  asso.z = z[which(abs(z)==max(abs(z)))] 
  
  result = data.frame(   absentN   = length(k0),   
                         presentN  = length(k1),   
                         meanPresentedCounts  = mean(rarefyOTU[k1]), 
                         p1.estimate 	 	= 	p1[1], 
                         p1.se 	 	 	= 	p1[2], 
                         p1.tvalue  	= 	p1[3], 
                         p1.pvalue 	= 	p1[4], 
                         p2.estimate 	 	= 	p2[1], 
                         p2.se 	 	 	= 	p2[2], 
                         p2.tvalue  	= 	p2[3], 
                         p2.pvalue 	= 	p2[4], 
                         p.combine 	 	=  sqrt(p1[4]*p2[4]), 
                         w.meta.z  	 	= 	w.meta.z, 
                         w.meta.p  	 	= 	w.meta.p, 
                         uw.meta.z 	 	 	= 	uw.meta.z, 
                         uw.meta.p 	 	 	= 	uw.meta.p, 
                         asso.z 	= 	asso.z, 
                         asso.P 	= 	minP) 
  
  return(result) 
} 


# -------------------------------------------------------------------------


ASV <- read.table("genustest.txt",header = T,row.names = 1,sep = "\t")
Trait <- read.table("traittest.txt",header = T,row.names = 1,sep = "\t")
Cov <- read.table("covtest.txt",header = T,row.names = 1,sep = "\t")
my_fixed_effect <- read.table("fixeffect.txt",header = T,row.names = 1,sep = "\t")

ASV<-as.matrix(ASV) 
Trait <-as.matrix(Trait)
Cov<-as.matrix(Cov)
my_fixed_effect <-as.matrix(my_fixed_effect)


TraitSV <-as.matrix(Trait[,1])
TraitSC <-as.matrix(Trait[,2])
TraitSM <-as.matrix(Trait[,3])
TraitAB <-as.matrix(Trait[,4])


v <- ncol(ASV)
v1 <- c(1:v)
 

res <- vector("list",10)

#SV
for ( i in v1) {
  
  res[[i]] <-twoPart_parametric(rarefyOTU=ASV[,i], 	trait=TraitSV, fixed_effect = my_fixed_effect,	covariates=Cov, log2.transform=T)
  
  }

res <- dplyr::bind_rows(res)

res

write.table(res,file = "resSV.txt",sep="\t")

#SC
res <- vector("list",10)
for ( i in v1) {
  
  res[[i]] <-twoPart_parametric(rarefyOTU=ASV[,i], 	trait=TraitSC, fixed_effect = my_fixed_effect,	covariates=Cov, log2.transform=T)
  
}

res <- dplyr::bind_rows(res)

res

write.table(res,file = "resSC.txt",sep="\t")


#SM
res <- vector("list",10)
for ( i in v1) {
  
  res[[i]] <-twoPart_parametric(rarefyOTU=ASV[,i], 	trait=TraitSM, fixed_effect = my_fixed_effect,	covariates=Cov, log2.transform=T)
  
}

res <- dplyr::bind_rows(res)

res

write.table(res,file = "resSM.txt",sep="\t")

#AB
res <- vector("list",10)
for ( i in v1) {
  
  res[[i]] <-twoPart_parametric(rarefyOTU=ASV[,i], 	trait=TraitAB, fixed_effect = my_fixed_effect,	covariates=Cov, log2.transform=T)
  
}

res <- dplyr::bind_rows(res)

res

write.table(res,file = "resAB.txt",sep="\t")





