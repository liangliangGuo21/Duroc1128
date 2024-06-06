library(blupADC)
data_path="D:/4.Rpractice/blupADC/yichuanxiangguan"
setwd("D:/4.Rpractice/blupADC/yichuanxiangguan")


run_DMU(
  phe_col_names=c('ID', 'ID_Pe', 'Farm_Year_Season', 'Strain',
                  'Scale_Day_age', 'Scale_Day_age2', 'Scale_Month_age', 'Scale_Month_age2', 'Scale_INT', 'Scale_INT2', 'SV', 'SC', 'SM', 'AB'), 
  target_trait_name=list(c('SV'),c('SC')),                     
  fixed_effect_name=list(c('Farm_Year_Season', 'Strain'),
                         c('Farm_Year_Season', 'Strain')),
  random_effect_name=list(c("ID"),c("ID")),
  covariate_effect_name=list(c('Scale_Day_age', 'Scale_Day_age2','Scale_INT', 'Scale_INT2'),
                          c('Scale_Day_age', 'Scale_Day_age2','Scale_INT', 'Scale_INT2')),
  genetic_effect_name="ID",               
  included_permanent_effect=list(c(TRUE),c(TRUE)),  
  phe_path=data_path,
  phe_name="phen_ID12.txt", 
  integer_n=4,                                
  analysis_model="GBLUP_A",  
  dmu_module="dmuai",
  relationship_path=data_path,
  relationship_name="1128qc2nijuzhen3col.txt", 
  DMU_software_path="C:/Users/g2/Documents/R/win-library/4.1/blupADC/extdata/bin_windows",
  output_result_path="D:/4.Rpractice/blupADC/yichuanxiangguan"   
) 

