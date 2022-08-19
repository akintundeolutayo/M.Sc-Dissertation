#!/bin/sh
#SBATCH --job-name=trimin    #name of the Job i am runnig.
#SBATCH --account=da494      #my account that gives me access to use the HPC
#SBATCH --partition=compute  #partition name
#SBATCH --mem-per-cpu=8000   #requested memory for the analysis
#SBATCH --cpus-per-task=3    #numbers of core
#SBATCH --time=08:00:00      #max time limit allocated to run the script
 
module purge      ##to unload all previus programm and resset everything
module load anvio #To load anvio that contai the needed file


## Define variables here to be used below, input locations, outputs etc.
INPUT=/storage/osakintu/raw_data
OUTPUT=/storage/osakintu/raw_data_trimmomatic

## trimmomatic loop
for r1 in ${INPUT}/*_1.fastq.gz
   do
   name=$(basename ${r1} _1.fastq.gz)
   echo $name

   anvio trimmomatic PE -threads $SLURM_CPUS_PER_TASK ${INPUT}/${name}_1.fastq.gz ${INPUT}/${name}_2.fastq.gz ${OUTPUT}/${name}_trimmed_1.fastq.gz ${OUTPUT}/${name}_unpaired_1.fastq.gz ${OUTPUT}/${name}_trimmed_2.fastq.gz ${OUTPUT}/${name}_unpaired_2.fastq.gz \
   ILLUMINACLIP:/storage/osakintu/TrueSeq3-PE.fa:2:30:10:2:keepBothReads LEADING:3 TRAILING:3  SLIDINGWINDOW:4:30  MINLEN:20

done
