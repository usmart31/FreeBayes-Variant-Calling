#!/bin/bash
#SBATCH --job-name=hard_filter
#SBATCH --output=hard_filter.out
#SBATCH --error=hard_filter.err
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
#conda activate gatk4


gatk SelectVariants \
    -V genotyped.vcf.gz \
    -select-type SNP \
    --restrict-alleles-to BIALLELIC \
    -O snps.vcf.gz