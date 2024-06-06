library("ivreg")

library("data.table")

for (i in 1:18) {
  file_name <- paste0("genus", i, ".profile")
  
  data <- fread(file_name)
  
  var_name <- paste0("data", i)
  
  assign(var_name, data)
}





scores_list <- list()

for (i in 1:18) {
  file_name <- paste0("genus", i, ".profile")
  
  data <- fread(file_name)
  
  score_data <- data[, .(FID, SCORE)]
  
  setnames(score_data, "SCORE", paste0(i, "SCORE"))
  
  scores_list[[i]] <- score_data
}

final_data <- Reduce(function(x, y) merge(x, y, by = "FID"), scores_list)

fwrite(final_data, "final_data.txt", sep = "\t")



dataMR<- fread("final_data.txt", sep = "\t")



m1 <- ivreg(SV ~ Rela1 + Farm + Age + PC1 + PC2 + PC3 | SCORE1 + Farm + Age + PC1 + PC2 + PC3, data = dataMR)

summary(m1)


library(ivreg)

final_phenotypes <- c("SV", "SC", "SM", "AB")
intermediate_phenotypes <- paste0( "Rela",1:18)
scores <- paste0("SCORE",1:18)
covariates <- "Farm + Age + PC1 + PC2 + PC3"

results <- list()

for (final_pheno in final_phenotypes) {
  for (i in 1:18) {
    intermediate_pheno <- intermediate_phenotypes[i]
    score <- scores[i]
    
    formula <- as.formula(paste(final_pheno, "~", intermediate_pheno, "+", covariates, "|", score, "+", covariates))
    
    model <- ivreg(formula, data = dataMR)
    
    results[[paste(final_pheno, intermediate_pheno, sep = "_")]] <- summary(model)
  }
}

print(results)


output_file <- "ivreg_results.txt"

file_conn <- file(output_file, open = "w")

for (name in names(results)) {
  writeLines(paste("Model:", name), file_conn)
  
  summary_text <- capture.output(results[[name]])
  writeLines(summary_text, file_conn)
  
  writeLines("\n", file_conn)
}

close(file_conn)

cat("Results have been saved to", output_file, "\n")


