rm(list = ls())
library(lme4)
library(lmerTest)
dat<- read.table("phenotype.txt", header = T,sep = '\t')
str(dat)

dat$Farm_Year_Season = as.factor(dat$Farm_Year_Season)
dat$Strain = as.factor(dat$Strain)


str(dat)


mod1=lmer(SV ~ 1+ Farm_Year_Season + Strain+ 
            Scale_Day_age+Scale_Day_age2+ Scale_INT+Scale_INT2 +( 1 | ID ), data=dat)
summary(mod1)

sv_ebv <- ranef(mod1)

write.table(sv_ebv,file = "01sv_ebv.txt",sep = "\t")

print(VarCorr(mod1),comp=c("Variance","Std.Dev."))
print(VarCorr(mod2),comp=c("Variance","Std.Dev."))
print(VarCorr(mod3),comp=c("Variance","Std.Dev."))
print(VarCorr(mod4),comp=c("Variance","Std.Dev."))
# -------------------------------------------------------------------------


mod2=lmer(SC ~ 1+ Farm_Year_Season + Strain+ 
            Scale_Day_age+Scale_Day_age2+ Scale_INT+Scale_INT2 +( 1 | ID ), data=dat)
summary(mod2)

sc_ebv <- ranef(mod2)

write.table(sc_ebv,file = "02sc_ebv.txt",sep = "\t")

# -------------------------------------------------------------------------


mod3=lmer(SM ~ 1+ Farm_Year_Season + Strain+ 
            Scale_Day_age+Scale_Day_age2+ Scale_INT+Scale_INT2 +( 1 | ID ), data=dat)
summary(mod3)

sm_ebv <- ranef(mod3)

write.table(sm_ebv,file = "03sm_ebv.txt",sep = "\t")
# -------------------------------------------------------------------------


mod4=lmer(AB ~ 1+ Farm_Year_Season + Strain+ 
            Scale_Day_age+Scale_Day_age2+ Scale_INT+Scale_INT2 +( 1 | ID ), data=dat)
summary(mod4)

ab_ebv <- ranef(mod4)

write.table(ab_ebv,file = "04ab_ebv.txt",sep = "\t")

