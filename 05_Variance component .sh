#MOD1
/data4/llguo/software/hiblup/bin/hiblup \
  --single-trait \
  --pheno data.txt \
  --pheno-pos 5 \
  --dcovar 2,3 \
  --qcovar 4 \
  --xrm G \
  --threads 32 \
  --out my_SV 


#MOD2
/data4/llguo/software/hiblup/bin/hiblup \
  --single-trait \
  --pheno data.txt \
  --pheno-pos 5 \
  --dcovar 2,3 \
  --qcovar 4 \
  --xrm M \
  --threads 32 \
  --out my_SV 


#MOD3
/data4/llguo/software/hiblup/bin/hiblup \
  --single-trait \
  --pheno data.txt \
  --pheno-pos 5 \
  --dcovar 2,3 \
  --qcovar 4 \
  --xrm G,M \
  --threads 32 \
  --out my_SV 


#MOD4
/data4/llguo/software/hiblup/bin/hiblup \
  --single-trait \
  --pheno data.txt \
  --pheno-pos 5 \
  --dcovar 2,3 \
  --qcovar 4 \
  --xrm G,M,G:M \
  --threads 32 \
  --out my_SV 
