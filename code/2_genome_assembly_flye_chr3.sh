#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 16
#SBATCH --mem=64G
#SBATCH -t 06:00:00
#SBATCH -J flye_chr3
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

module load Flye

cd /home/mili1951/Genome-analysis/analyses/02_genome_assembly/flye_chr3

flye --nano-raw /home/mili1951/Genome-analysis/data/raw_data/chr3_clean_nanopore.fq.gz \
     --out-dir flye_out \
     --threads 2
