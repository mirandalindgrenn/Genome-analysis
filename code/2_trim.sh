#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 06:00:00
#SBATCH -J trim
#SBATCH --output=%x.%j.out

module load Trimmomatic


R1=/home/mili1951/Genome-analysis/data/raw_data/chr3_illumina_R1.fastq.gz
R2=/home/mili1951/Genome-analysis/data/raw_data/chr3_illumina_R2.fastq.gz


OUTDIR=/home/mili1951/Genome-analysis/analyses/01_preprocessing/trim

mkdir -p $OUTDIR


trimmomatic PE -threads 2 \
$R1 \
$R2 \
$OUTDIR/chr3_R1_paired.fq.gz \
$OUTDIR/chr3_R1_unpaired.fq.gz \
$OUTDIR/chr3_R2_paired.fq.gz \
$OUTDIR/chr3_R2_unpaired.fq.gz \
ILLUMINACLIP:$EBROOTTRIMMOMATIC/adapters/TruSeq3-PE.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
