#!/bin/bash 
sudo apt-get install fastp
sudo apt-get install fastqc
sudo apt-get -y install multiqc
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R1.fastq.gz?raw=true -O ACBarrie_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/ACBarrie_R2.fastq.gz?raw=true -O ACBarrie_R2.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R1.fastq.gz?raw=true -O Alsen_R1.fastq.gz
wget https://github.com/josoga2/yt-dataset/blob/main/dataset/raw_reads/Alsen_R2.fastq.gz?raw=true -O Alsen_R2.fastq.gz
mkdir output1
mkdir QC_Reports1

        fastqc ~/*.fastq.gz -o QC_Reports1

        multiqc QC_Reports1 -o output1

SAMPLES=(
        "ACBarrie"
        "Alsen"
)

for SAMPLE in "${SAMPLES[@]}"; do

        fastp \
        -i "$PWD/${SAMPLE}_R1.fastq.gz" \
        -I "$PWD/${SAMPLE}_R2.fastq.gz" \
        -o "output1/${SAMPLE}_R1.fastq.gz" \
        -O "output1/${SAMPLE}_R2.fastq.gz" \
        --html "output1/${SAMPLE}_fastp.html" 

done
