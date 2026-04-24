#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J quast_chr3
#SBATCH --output=/home/mili1951/Genome-analysis/analyses/logs/%x.%j.out

module load QUAST

OUTDIR=/home/mili1951/Genome-analysis/analyses/03_evaluation/quast_chr3
ASSEMBLY1=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/flye_chr3/assembly.fasta
ASSEMBLY2=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/pilon_chr3/pilon_chr3.fasta

mkdir -p "$OUTDIR"

quast.py \
  "$ASSEMBLY1" \
  "$ASSEMBLY2" \
  -o "$OUTDIR"
