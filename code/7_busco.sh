#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2

#SBATCH -t 02:00:00
#SBATCH -J busco_chr3
#SBATCH --output=analyses/logs/%x.%j.out

module load BUSCO

OUTDIR="analyses/03_evaluation/busco_chr3"
INPUT="analyses/02_genome_assembly/pilon_chr3/pilon_chr3.fasta"

mkdir -p $OUTDIR

busco -i $INPUT \
      -o busco_results \
      --out_path $OUTDIR \
      -m genome \
      -l embryophyta_odb10 \
      -c 2
