#!/bin/bash
#SBATCH --job-name=Apply_VSQD
#SBATCH --output=Apply_VSQD.out
#SBATCH --error=Apply_VSQD.err
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

REFERENCE="/mmfs1/home/jjt122/Mito_BD/JEL423_mtDNA.fasta"

gatk --java-options "-Xmx4g" ApplyVQSR \
   -R "$REFERENCE" \
   -V cod204.lg05.1.hf.DP3.GQ20.allele.vcf.gz \
   -O Final_vars.vcf.gz \
   --truth-sensitivity-filter-level 99.0 \
   --tranches-file cohort_snps.tranches \
   --recal-file cohort_snps.recal \
   -mode SNP