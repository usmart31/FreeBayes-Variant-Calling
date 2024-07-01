#!/bin/bash
#SBATCH --job-name=combine_gvcfs
#SBATCH -t 27-24:00
#SBATCH --partition=himem
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu
#SBATCH --output=combine_gvcfs.out
#SBATCH --error=combine_gvcfs.err


# Set the reference genome file path
REFERENCE="/mmfs1/home/jjt122/Mito_BD/JEL423_mtDNA.fasta"


gatk --java-options "-Xmx4G" CombineGVCFs -R $REFERENCE --variant gvcfs.list -O cohort.g.vcf.gz 