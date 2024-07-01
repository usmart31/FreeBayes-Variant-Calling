#!/bin/bash
#SBATCH --job-name=haplotype_caller
#SBATCH -t 27-24:00
#SBATCH --partition=himem
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu
#SBATCH --output=haplotype_caller_%A_%a.out
#SBATCH --error=haplotype_caller_%A_%a.err
#SBATCH --array=1-208   # Specify the total number of input files

# Source the conda.sh script to activate Anaconda/Miniconda environment
source /mmfs1/home/jjt122/miniconda3/etc/profile.d/conda.sh  # Replace with the correct path to conda.sh

# Activate conda env
conda activate gatk4

# Set the reference genome file path
REFERENCE="/mmfs1/home/jjt122/Mito_BD/JEL423_mtDNA.fasta"

# List of input files (assuming they are in the same directory)
INPUT_FILES=(/mmfs1/home/jjt122/Results/Mito/bams/*.bam)

# Specify the output folder
OUTPUT="temp-gvcf"

# Get the input file for the current array task
INPUT=${INPUT_FILES[$SLURM_ARRAY_TASK_ID-1]}
FILENAME=$(basename -- "$INPUT")
FILENAME_PART="${FILENAME%.*}"
OUT1=$OUTPUT/$FILENAME_PART.g.vcf.gz

# Ensure that the output directory exists
mkdir -p $OUTPUT

# Run HaplotypeCaller on the selected input file
gatk --java-options "-Xmx4G" HaplotypeCaller -R $REFERENCE -I $INPUT -ploidy 1 -O $OUT1 -ERC GVCF

