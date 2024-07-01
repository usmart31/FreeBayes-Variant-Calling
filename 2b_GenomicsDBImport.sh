#!/bin/bash
#SBATCH --job-name=Combine_gvcfs
#SBATCH --output=Combine_gvcfs.out
#SBATCH --error=Combine_gvcfs.err
#SBATCH --partition=himem
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=28-00:00:00
#SBATCH --mail-type=end
#SBATCH --mail-user=jjt122@txstate.edu


gatk --java-options "-Xmx4g -Xms4g" \
       GenomicsDBImport \
       --genomicsdb-workspace-path my_database \
       --batch-size 50 \
       -L chr1:1000-10000 \
       --sample-name-map cohort.sample_map \
       --tmp-dir=/path/to/large/tmp \
       --reader-threads 5