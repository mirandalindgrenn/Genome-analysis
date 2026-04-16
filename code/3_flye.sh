#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 16
#SBATCH --mem=32G
#SBATCH -t 08:00:00
#SBATCH -J flye_chr3
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

module purge
module load Flye

set -euo pipefail

WORKDIR=/home/mili1951/Genome-analysis/analyses/02_genome_assembly/flye_chr3
READS=/home/mili1951/Genome-analysis/data/raw_data/chr3_clean_nanopore.fq.gz
OUTDIR=${WORKDIR}/flye_out

mkdir -p "$WORKDIR"
cd "$WORKDIR"

if [ ! -f "$READS" ]; then
    echo "ERROR: Reads file not found: $READS"
    exit 1
fi

if [ -d "$OUTDIR" ]; then
    echo "Existing Flye output found in $OUTDIR"
    echo "Remove it first if you want a clean rerun:"
    echo "rm -rf $OUTDIR"
    exit 1
fi

flye --nano-raw "$READS" \
     --out-dir "$OUTDIR" \
     --threads 16
