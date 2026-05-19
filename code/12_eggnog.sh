#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH --mail-type=ALL
#SBATCH -t 24:00:00
#SBATCH -J eggnog_chr3
#SBATCH --output=analyses/logs/%x.%j.out

module load eggnog-mapper/2.1.13-gfbf-2024a

INPUT_PROTEINS="/home/mili1951/Genome-analysis/analyses/04_annotation/braker3_chr3/braker.aa"
OUT_DIR="/home/mili1951/Genome-analysis/analyses/05_functional_annotation/eggnog_chr3"

mkdir -p "$OUT_DIR"
cd "$OUT_DIR"


emapper.py -i "$INPUT_PROTEINS" \
           --output chr3_functional \
           --output_dir "$OUT_DIR" \
           --cpu 2 \
           --itype proteins \
           --data_dir /sw/data/eggNOG/5.0.0/rackham/ \
           --sensmode fast \
           --override
