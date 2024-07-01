#!/bin/bash
#SBATCH --job-name=genotype_gvcfs
#SBATCH -t 27-24:00
#SBATCH --partition=himem
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu
#SBATCH --output=genotype_gvcfs.out
#SBATCH --error=genotype_gvcfs.err


# Set the reference genome file path
REFERENCE="/mmfs1/home/jjt122/Mito_BD/JEL423_mtDNA.fasta"


gatk --java-options "-Xmx4g" GenotypeGVCFs -R $REFERENCE -ploidy 1 -V cohort.g.vcf.gz -O genotyped.vcf.gz
 