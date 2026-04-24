#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 04:00:00
#SBATCH -J bwa_chr3
#SBATCH --output=analyses/logs/%x.%j.out
#SBATCH --mail-type=ALL

module purge
module load BWA/0.7.18
module load SAMtools/1.22

ASSEMBLY=analyses/02_genome_assembly/flye_chr3_rerun/assembly.fasta
R1=analyses/01_preprocessing/trim/chr3_R1_paired.fq.gz
R2=analyses/01_preprocessing/trim/chr3_R2_paired.fq.gz

OUTDIR=analyses/02_genome_assembly/bwa_pilon
PREFIX=${OUTDIR}/illumina_vs_flye

mkdir -p ${OUTDIR}
mkdir -p analyses/logs

which bwa
which samtools

bwa index ${ASSEMBLY}

bwa mem -t 2 ${ASSEMBLY} ${R1} ${R2} | \
samtools view -b - | \
samtools sort -@ 2 -o ${PREFIX}.sorted.bam

samtools index ${PREFIX}.sorted.bam
samtools flagstat ${PREFIX}.sorted.bam > ${PREFIX}.flagstat.txt
