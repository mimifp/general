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

process convertToReverse {
  input:
    file x
  output:
    stdout

    """
    rev $x
    """
}

workflow {
  splitLetters | flatten | convertToReverse | view { it.trim() }
}