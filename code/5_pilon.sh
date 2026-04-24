#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 20:00:00
#SBATCH -J pilon_chr3
#SBATCH --output=/home/mili1951/Genome-analysis/analyses/logs/%x.%j.out
#SBATCH --mail-type=ALL

module load Pilon

ASSEMBLY=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/flye_chr3_rerun/assembly.fasta
BAM=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/bwa_pilon/illumina_vs_flye.sorted.bam
OUTDIR=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/pilon_chr3

mkdir -p "$OUTDIR"
cd "$OUTDIR"

pilon \
  --genome "$ASSEMBLY" \
  --bam "$BAM" \
  --output pilon_chr3 \
  --threads 2
