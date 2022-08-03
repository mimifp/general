Channel
     .fromPath('../Documents/GitHub/general/1_tools/1_nextflow/fasta_ex.fa')
     .splitFasta( record: [id: true, seqString: true ])
     .filter { record -> record.id =~ /^MT.*/ }
     .view { record -> record.seqString }