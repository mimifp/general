#!/usr/bin/env nextflow
nextflow.enable.dsl=2

params.str = 'Esto es una prueba'

process splitLetters {
  output:
    path 'chunk_*'

  """
  printf '${params.str}' | split -b 2 - chunk_
  """
}

process convertToUpper {
  input:
    file x
  output:
    stdout

  """
  cat $x | tr '[a-z]' '[A-Z]'
  """
}

workflow {
  splitLetters | flatten | convertToUpper | view { it.trim() }
}