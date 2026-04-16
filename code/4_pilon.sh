#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 8
#SBATCH --mem=32G
#SBATCH -t 08:00:00
#SBATCH -J pilon_chr3
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

module purge
module load BWA
module load SAMtools
module load Pilon

set -euo pipefail

WORKDIR=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/pilon_chr3
ASSEMBLY=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/flye_chr3/flye_out/assembly.fasta
READ1=/home/mili1951/Genome-analysis/analyses/01_preprocessing/trim/CRR809859_R1_paired.fq.gz
READ2=/home/mili1951/Genome-analysis/analyses/01_preprocessing/trim/CRR809859_R2_paired.fq.gz


mkdir -p "$WORKDIR"
cd "$WORKDIR"

if [ ! -f "$ASSEMBLY" ]; then
    echo "ERROR: Assembly file not found: $ASSEMBLY"
    exit 1
fi

if [ ! -f "$READ1" ] || [ ! -f "$READ2" ]; then
    echo "ERROR: Illumina reads not found"
    exit 1
fi

bwa index "$ASSEMBLY"

bwa mem -t 8 "$ASSEMBLY" "$READ1" "$READ2" | \
samtools sort -@ 8 -o illumina_vs_flye.sorted.bam

samtools index illumina_vs_flye.sorted.bam

pilon \
  --genome "$ASSEMBLY" \
  --bam illumina_vs_flye.sorted.bam \
  --output pilon_chr3 \
  --threads 8
