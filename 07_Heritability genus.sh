#!/usr/bin/bash
#PBS -l nodes=1:ppn=1
#PBS -l mem=2g
#PBS -N h2
#PBS -q cu

cd $PBS_O_WORKDIR

gcta64 --grm-bin mydataID_rm025  --pheno mygenus.phen    --reml --qcovar pca5.txt  --out m1 --thread-num 10
gcta64 --grm-bin mydataID_rm025  --pheno mygenus.phen  --mpheno 2 --reml --qcovar pca5.txt  --out m2 --thread-num 10 
...
...
...
gcta64 --grm-bin mydataID_rm025  --pheno mygenus.phen  --mpheno 181 --reml --qcovar pca5.txt  --out m181 --thread-num 10 
