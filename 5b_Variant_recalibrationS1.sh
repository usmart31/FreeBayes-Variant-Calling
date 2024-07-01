#!/bin/bash
#SBATCH --job-name=Var_calib
#SBATCH --output=Var_calib.out
#SBATCH --error=Var_calib.err
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


gatk --java-options "-Xmx3g -Xms3g" VariantRecalibrator \
    -V cod204.lg05.1.hf.DP3.GQ20.allele.vcf.gz \
    --trust-all-polymorphic \
    -tranche 100.0 -tranche 99.95 -tranche 99.9 -tranche 99.8 -tranche 99.6 -tranche 99.5 -tranche 99.4 -tranche 99.3 -tranche 99.0 -tranche 98.0 -tranche 97.0 -tranche 90.0 \
    -an QD -an MQRankSum -an ReadPosRankSum -an FS -an MQ -an SOR -an DP \
    -mode SNP \
    --max-gaussians 6 \
    --resource:own,known=false,training=true,truth=true,prior=10.0 high_quality_variants.vcf \
    -O cohort_snps.recal \
    --tranches-file cohort_snps.tranches
    --rscript-file output.plots.R

echo "dunzo"