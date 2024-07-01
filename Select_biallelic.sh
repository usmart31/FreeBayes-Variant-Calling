#!/bin/bash
#SBATCH --job-name=select_bi
#SBATCH --output=select_bi.out
#SBATCH --error=select_bi.err
#SBATCH --partition=himem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=28-00:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu

gatk SelectVariants \
    -V snps_filtered.vcf.gz \
    --restrict-alleles-to BIALLELIC \
    -O output_biallelic.vcf.gz
