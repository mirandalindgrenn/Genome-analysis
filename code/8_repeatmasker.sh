#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 04:40:00
#SBATCH -J mask_chr3
#SBATCH --output=analyses/logs/%x.%j.out


module load RepeatMasker


OUTDIR="analyses/02_genome_assembly/repeatmasker_chr3"


INPUT="analyses/02_genome_assembly/pilon_chr3/pilon_chr3.fasta"

mkdir -p $OUTDIR

RepeatMasker \
  -pa 2 \
  -species embryophyta \
  -xsmall \
  -dir $OUTDIR \
  $INPUT
