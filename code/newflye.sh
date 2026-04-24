#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH --mem=64G
#SBATCH -t 72:00:00
#SBATCH -J flye_chr3_rerun
#SBATCH --output=analyses/logs/%x.%j.out

module load Flye

INPUT=data/raw_data/chr3_clean_nanopore.fq.gz
OUTDIR=analyses/02_genome_assembly/flye_chr3_rerun

mkdir -p $OUTDIR
mkdir -p analyses/logs

flye \
  --nano-raw $INPUT \
  --out-dir $OUTDIR \
  --threads 4
