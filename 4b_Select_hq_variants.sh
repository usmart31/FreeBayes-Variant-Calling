#!/bin/bash
#SBATCH --job-name=select_hq_vars
#SBATCH --output=select_hq_vars.out
#SBATCH --error=select_hq_vars.err
#SBATCH --partition=himem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=28-00:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu

# Set the reference genome file path
REFERENCE="/mmfs1/home/jjt122/Mito_BD/JEL423_mtDNA.fasta"

# Source the conda.sh script to activate Anaconda/Miniconda environment
source /mmfs1/home/jjt122/miniconda3/etc/profile.d/conda.sh  # Replace with the correct path to conda.sh

# Activate conda env
conda activate gatk4

# Input VCF file (initial variant calls)
INPUT_VCF="/mmfs1/home/jjt122/Results/Mito/gvcfs/snps.vcf.gz"

# Output VCF file for high-quality variants
OUTPUT_VCF="/mmfs1/home/jjt122/Results/Mito/gvcfs/high_quality_variants.vcf"

# Minimum QUAL score threshold (adjust as needed)
MIN_QUAL=30

# Run GATK SelectVariants to filter high-quality variants
gatk --java-options "-Xmx4g" SelectVariants \
    -R "$REFERENCE" \
    -V "$INPUT_VCF" \
    -O "$OUTPUT_VCF" \
    --select "QUAL >= $MIN_QUAL"

echo "High-quality variant filtering completed."