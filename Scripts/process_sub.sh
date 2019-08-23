#!/bin/bash
#PBS -l nodes=1:ppn=10,walltime=72:00:00

# Modules
module load languages/R-3.5.1-ATLAS-gcc-6.1
module load apps/tabix-0.2.6

# Process
cd /newhome/js16174/projects/ewas_catalog/program_files/aries/fom1/
R CMD BATCH process_sub.R process_sub.Rout
echo "Processing complete"

# Dataset
cd /newhome/js16174/projects/ewas_catalog/data/aries/fom1/ewas/results/
tail -q -n +3 dataset_{1..369}_sub.txt > data_sub.txt
head -n 2 dataset_1_sub.txt > headers_sub.txt
cat headers_sub.txt data_sub.txt > aries_ewas_fom1_sub.txt
rm headers_sub.txt data_sub.txt dataset_*_sub.txt

# Process
cd /newhome/js16174/projects/ewas_catalog/program_files/aries/fom1/
R CMD BATCH process_sub_mysql.R process_sub_mysql.Rout

# Gzip 
cd /newhome/js16174/projects/ewas_catalog/data/aries/fom1/ewas/results/
gzip aries_ewas_fom1_sub*
echo "Dataset complete"

# Create data for MySQL