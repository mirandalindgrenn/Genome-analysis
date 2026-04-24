#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 4
#SBATCH --mem=16G
#SBATCH -t 06:00:00
#SBATCH -J rna_map_chr3
#SBATCH --output=analyses/logs/%x.%j.out

module load HISAT2
module load SAMtools

GENOME="analyses/02_genome_assembly/pilon_chr3/pilon_chr3.fasta"
RNADIR="data/raw_data/rna"
OUTDIR="analyses/04_annotation/rna_mapping"

mkdir -p "$OUTDIR"
mkdir -p analyses/logs

hisat2-build "$GENOME" "$OUTDIR/genome_index"

for SAMPLE in Control_1 Control_2 Control_3 Heat_treated_42_12h_1 Heat_treated_42_12h_2 Heat_treated_42_12h_3
do
    hisat2 -x "$OUTDIR/genome_index" \
        -1 "$RNADIR/${SAMPLE}_f1.fq.gz" \
        -2 "$RNADIR/${SAMPLE}_r2.fq.gz" \
        -p 4 | \
    samtools sort -@ 4 -o "$OUTDIR/${SAMPLE}.sorted.bam"

    samtools index "$OUTDIR/${SAMPLE}.sorted.bam"
done

samtools merge -@ 4 "$OUTDIR/rna_merged.sorted.bam" \
    "$OUTDIR/Control_1.sorted.bam" \
    "$OUTDIR/Control_2.sorted.bam" \
    "$OUTDIR/Control_3.sorted.bam" \
    "$OUTDIR/Heat_treated_42_12h_1.sorted.bam" \
    "$OUTDIR/Heat_treated_42_12h_2.sorted.bam" \
    "$OUTDIR/Heat_treated_42_12h_3.sorted.bam"

samtools index "$OUTDIR/rna_merged.sorted.bam"
