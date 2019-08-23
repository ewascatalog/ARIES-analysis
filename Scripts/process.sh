#!/bin/bash
#PBS -l nodes=1:ppn=10,walltime=72:00:00

# Modules
module load languages/R-3.5.1-ATLAS-gcc-6.1
module load apps/tabix-0.2.6

# Process
cd /newhome/js16174/projects/ewas_catalog/program_files/aries/fom1/
R CMD BATCH process.R process.Rout
echo "Processing complete"

# Combine
cd /newhome/js16174/projects/ewas_catalog/data/aries/fom1/ewas/results/
for i in {1..22}
do
  tail -q -n +2 chr${i}_*.txt > data.txt
  head -n 1 chr${i}_dataset_1.txt > headers.txt
  cat headers.txt data.txt > chromosome${i}.txt
  rm headers.txt data.txt chr${i}_*
done
echo "Combine complete"

# VCF
cd /newhome/js16174/projects/ewas_catalog/program_files/aries/fom1/
R CMD BATCH vcf.R vcf.Rout

cd /newhome/js16174/projects/ewas_catalog/data/aries/fom1/ewas/results/
tail -q -n +3 chromosome{1..22}.vcf > data.vcf
head -n 2 chromosome1.vcf > headers.vcf
cat headers.vcf data.vcf > aries_ewas_fom1.vcf
rm headers.vcf data.vcf chromosome*

echo "VCF complete"

# Tabix
bgzip aries_ewas_fom1.vcf
tabix -p vcf aries_ewas_fom1.vcf.gz
echo "Tabix complete"