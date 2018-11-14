#! /usr/bin/env nextflow

params.in_files = 'data/*'
params.out_dir = '.'

in_images = Channel.fromPath( params.in_files )

process parse_files {
    container 'rocker/tidyverse:3.5'
    publishDir params.out_dir, mode: 'copy'
    
    input:
    file i from in_images

    output:
    file 'p_abstract.csv' into csv_out

    script:
    """
    Rscript $baseDir/task1.R $i 
    """
}

process create_top10 {
    container 'rocker/tidyverse:3.5'
    publishDir params.out_dir, mode: 'copy'
    
    input:
    file i from csv_out.collectFile(name: 'fin_dat.csv', newLine: true)

    output:
    file 'top10.csv' into top_10_dat

    script:
    """
    Rscript $baseDir/task2.R $i
    """
}

   