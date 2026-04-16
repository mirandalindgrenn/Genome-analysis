#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J trim
#SBATCH --output=%x.%j.out

module load Trimmomatic

WORKDIR=/home/mili1951/Genome-analysis/analyses/01_preprocessing/trim
READS=/home/mili1951/Genome-analysis/data/raw_data

mkdir -p $WORKDIR
cd $WORKDIR

# Adapter path
ADAPTER=/sw/generic/pixi-envs/shovill-1.4.2/.pixi/envs/default/share/trimmomatic-0.40-0/adapters/TruSeq3-PE.fa

trimmomatic PE -threads 2 \
$READS/CRR809859_f1.fq.gz $READS/CRR809859_r2.fq.gz \
CRR809859_R1_paired.fq.gz CRR809859_R1_unpaired.fq.gz \
CRR809859_R2_paired.fq.gz CRR809859_R2_unpaired.fq.gz \
ILLUMINACLIP:$ADAPTER:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
