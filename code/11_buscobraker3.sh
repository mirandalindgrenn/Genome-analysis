#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J busco_braker
#SBATCH --output=analyses/logs/%x.%j.out

module load BUSCO

OUTDIR="analyses/03_evaluation/busco_braker"
INPUT="analyses/04_annotation/braker3_chr3/braker.aa"

mkdir -p $OUTDIR

busco -i $INPUT \
      -o busco_results \
      --out_path $OUTDIR \
      -m proteins \
      -l embryophyta_odb10 \
      -c 2
