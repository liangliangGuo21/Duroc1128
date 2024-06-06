library(vegan)
GRM <- read.table('Gnew.txt', header= TRUE)
MRM <- read.table('M.txt', header= TRUE)

G_M_S<- mantel(GRM, MRM, method = "spearman", permutations = 9999, na.rm = TRUE)
G_M_P<- mantel(GRM, MRM, method = "pearson", permutations = 9999, na.rm = TRUE)





