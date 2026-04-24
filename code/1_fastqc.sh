#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc
#SBATCH --output=/home/mili1951/Genome-analysis/analyses/logs/%x.%j.out

module load FastQC

WORKDIR=/home/mili1951/Genome-analysis/analyses/01_preprocessing/fastqc
READS=/home/mili1951/Genome-analysis/data/raw_data

mkdir -p $WORKDIR
cd $WORKDIR

fastqc $READS/chr3_illumina_R1.fastq.gz \
       $READS/chr3_illumina_R2.fastq.gz \
       -t 2
