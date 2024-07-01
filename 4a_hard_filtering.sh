#!/bin/bash
#SBATCH --job-name=hard_filt
#SBATCH --output=hard_filt.out
#SBATCH --error=hard_filt.err
#SBATCH --partition=himem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=28-00:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu


# Source the conda.sh script to activate Anaconda/Miniconda environment
#source /gpfs/home/jjt122/miniconda3/etc/profile.d/conda.sh  # Replace with the correct path to conda.sh

# Activate conda env
#conda activate sambcfenv

#echo "Hard filtering"
#bcftools filter -e 'FS>40.0 || SOR>3 || MQ<40 || MQRankSum<-5.0 || MQRankSum>5.0 || QD<2.0 || ReadPosRankSum<-4.0 || INFO/DP>16000' -O z -o filtered_multisample.vcf.gz genotyped.vcf.gz

#echo "Filtering on minimum read depth (DP) and genotype quality (GQ)"
#bcftools filter -S . -e 'FMT/DP<3 | FMT/GQ<20' -O z -o cod204.lg05.1.hf.DP3.GQ20.vcf.gz filtered_multisample.vcf.gz 

echo "Removing multiallelic SNPs and indels, monomorphic SNPs, and SNPs in the close proximity of indels"
bcftools filter -e 'AC==0 || AC==AN' --SnpGap 10 genotyped.vcf.gz | bcftools view -m2 -M2 -v snps -O z -o cod204.lg05.1.hf.DP3.GQ20.allele.vcf.gz

#echo "Removing individuals with a high amount of missing data"
#bcftools stats -s - cod204.lg05.1.hf.DP3.GQ20.allele.vcf.gz | grep -E ^PSC | cut -f3,14 > cod204.lg05.1.hf.DP3.GQ20.allele.imiss

#echo "Removing variants with a high amount of missing genotypes and filter on minor allele frequency"
#bcftools filter -e 'F_MISSING > 0.2 || MAF <= 0.02' -O z -o cod204.lg05.1.hf.DP3.GQ20.allele.missi.miss20.maf0.02.vcf.gz cod204.lg05.1.hf.DP3.GQ20.allele.vcf.gz

echo "Donzer!"