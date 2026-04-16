#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 03:00:00
#SBATCH -J fastqc
#SBATCH --output=%x.%j.out

module load FastQC

WORKDIR=/home/mili1951/Genome-analysis/analyses/01_preprocessing/fastqc
READS=/home/mili1951/Genome-analysis/data/raw_data

mkdir -p $WORKDIR
cd $WORKDIR

fastqc $READS/CRR809859_f1.fq.gz \
       $READS/CRR809859_r2.fq.gz \
       -t 2
