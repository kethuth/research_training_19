#!/usr/bin/bash -l

#SBATCH -A snic2018-3-568
#SBATCH -p core
#SBATCH -n 12
#SBATCH -t 16:00:00
#SBATCH -J protgammaf_phylogeny
#SBATCH --mail-type=ALL
#SBATCH --mail-user karl.nyren.6523@student.uu.se

module load bioinfo-tools
module load raxml/8.2.10-gcc-mpi

ALIGNMENT_FILE_PATH=$1
FILE_EXT=$2
MR_CONS='MR_CONS'
MODEL='PROTGAMMAWAGF'
BS_EXT='RAxML_bootstrap.'
mr_cons_BS='MR_CONS-bootstrap'

# MPI loaded for boostrapping, T for number of threads(1 thread per core recommended), -b for random bootstrap seed(reproducible if same data),
# -B for branch resolution, -N Number of bootstraps to be performed, -p to reproduce ML.
raxmlHPC \
    -s $ALIGNMENT_FILE_PATH \
    -n $FILE_EXT \
    -m $MODEL \
    -T 12 \
    -b 126345 \
    -B 0.03 \
    -N 150 \
    -p 3214


raxmlHPC \
    -I autoMRE \
    -m PROTGAMMAWAGF \
    -z $BS_EXT$OUTFILE_PATH \
    -n $MR_CONS \
    -T 12 \
    -p 12321341

raxmlHPC \
    -f b \
    -z $BS_EXT$OUTFILE_PATH \
    -t $BS_EXT$OUTFILE_PATH$MR_CONS \
    -m PROTGAMMAWAGF \
    -n $mr_cons_BS
