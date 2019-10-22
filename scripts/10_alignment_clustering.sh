#!/usr/bin/bash -l

#SBATCH -A snic2018-3-568
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 00:30:00
#SBATCH -J alignment_clustering

module load bioinfo-tools
module load biopython/1.73-py3
module load blast/2.9.0+

SCRIPT_PATH='/home/karlnyr/research_training_19/scripts/09_alignment_grouping.py'
FILE_PATH=$1
PERC_CUTOF=$2
MIN_LENGTH=$3

python3 SCRIPT_PATH FILE_PATH PERC_CUTOF MIN_LENGTH > FILE_PATH'_clustering'
