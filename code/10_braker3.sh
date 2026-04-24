#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 8
#SBATCH --mem=64G
#SBATCH -t 24:00:00
#SBATCH -J braker3_chr3
#SBATCH --output=analyses/logs/%x.%j.out

module load SAMtools

GENOME="/home/mili1951/Genome-analysis/analyses/02_genome_assembly/repeatmasker_chr3/pilon_chr3.fasta.masked"
BAM="/home/mili1951/Genome-analysis/analyses/04_annotation/rna_mapping/rna_merged.sorted.bam"
OUTDIR="/home/mili1951/Genome-analysis/analyses/04_annotation/braker3_chr3"
BRAKER_SIF="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/braker3.sif"
PROTEIN_DB="/proj/uppmax2026-1-61/Genome_Analysis/2_Zhou_2023/Ceratodon_purpureus/C_purpureus.faa"

export TMPDIR="$OUTDIR/tmp"

mkdir -p "$OUTDIR"
mkdir -p "$TMPDIR"

singularity exec \
  -B /home/mili1951:/home/mili1951 \
  -B /proj/uppmax2026-1-61:/proj/uppmax2026-1-61 \
  -B /home/mili1951/Genome-analysis/augustus_config:/opt/Augustus/config \
  "$BRAKER_SIF" braker.pl \
    --genome="$GENOME" \
    --bam="$BAM" \
    --prot_seq="$PROTEIN_DB" \
    --species=Niphotrichum_japonicum_chr3 \
    --softmasking \
    --threads=8 \
    --workingdir="$OUTDIR"
