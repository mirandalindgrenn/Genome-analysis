#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_trim
#SBATCH --output=analyses/logs/%x.%j.out

module load FastQC

OUTDIR=analyses/01_preprocessing/fastqc_trim
READS=analyses/01_preprocessing/trim

mkdir -p $OUTDIR

fastqc \
$READS/chr3_R1_paired.fq.gz \
$READS/chr3_R2_paired.fq.gz \
--outdir $OUTDIR \
-t 2
