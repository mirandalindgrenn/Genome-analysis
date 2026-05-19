#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH -t 04:00:00
#SBATCH -J featurecount_chr3
#SBATCH --output=analyses/logs/%x.%j.out

module load Subread


GTF="analyses/04_annotation/braker3_chr3/braker.gtf"


BAM_DIR="analyses/04_annotation/rna_mapping"

OUTDIR="analyses/06_differential_expression"
OUTFILE="$OUTDIR/counts.txt"

mkdir -p "$OUTDIR"
mkdir -p analyses/logs

featureCounts \
  -T 4 \
  -p \
  -a "$GTF" \
  -o "$OUTFILE" \
  -t exon \
  -g gene_id \
  "$BAM_DIR"/Control_*.sorted.bam \
  "$BAM_DIR"/Heat_treated_*.sorted.bam
