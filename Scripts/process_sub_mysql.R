###################################################################
## Process EWAS                                                  ##
##                                                               ##
## James Staley                                                  ##
## University of Bristol                                         ##
## Email: james.staley@bristol.ac.uk                             ##
###################################################################

###################################################################
##### Set-up #####
###################################################################

##### Clear #####
rm(list=ls())

##### Options #####
options(stringsAsFactors = F)

##### Set working directory #####
setwd("/newhome/js16174/projects/ewas_catalog/data/aries/fom1/ewas/results/")

##### Libraries ####
suppressMessages(library(data.table))

###################################################################
##### Methylation data #####
###################################################################

data <- fread("aries_ewas_fom1_sub.txt", header=T, sep="\t", data.table=F, colClasses="character")
studies <- data[,c("Author", "Consortium", "PMID", "Date", "Trait", "EFO", "Analysis", "Source", "Outcome", "Exposure", "Covariates", "Outcome_Units", "Exposure_Units", "Methylation_Array", "Tissue", "Further_Details", "N", "N_Cohorts", "Categories", "Age", "N_Males", "N_Females", "N_EUR", "N_EAS", "N_SAS", "N_AFR", "N_AMR", "N_OTH", "StudyID")]
studies <- studies[!duplicated(studies),]
write.table(studies, "aries_ewas_fom1_sub_studies.txt", row.names=F, quote=F, sep="\t")
results <- data[,c("CpG", "Location", "Chr", "Pos", "Gene", "Type", "Beta", "SE", "P", "Details", "StudyID")]
write.table(results, "aries_ewas_fom1_sub_results.txt", row.names=F, quote=F, sep="\t")

q("no")