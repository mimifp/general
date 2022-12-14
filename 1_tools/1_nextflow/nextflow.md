## NextFlow

In this document are summarizes some interesants facts of Nextflow execution.

- Each process can be written in any scripting language that can be executed by the Linux platform (Bash, Perl, Ruby, Python, etc.). Processes are executed independently and are isolated from each other, i.e. they do not share a common (writable) state. The only way to communicate them is via channels (FIFO queues).
- Nextflow creates an execution directory by each task; which contains logs, relevant outputs and other files. Each directory is indentify by an unique hash.
- There are two principal ways to add numeric channels:
  ```
  - Channel.value(x) --> unlimited process
  - Channel.of(y,z,w) --> one process that iterates on values of channel
  ```
- Nextflow creates a symlink to access to files, one unique by each one. To load files:
  ```
  Channel.fromPath('directory/file.extension')
  ```
- To execute specific version of Nextflow add to command line
  ```
  NXF_VER=20.04.0 nextflow run script.sh
  ```
- To execute Nextflow in local it's neccessary a Java version between 11 and 18. For this, in macOS its helpfull to create a conda enviroment with one of this java versions. In this case, we create java_17 conda enviroment with openjk-17.0.3 java version:
  ```
  conda create -n java_17 openjdk=17
  ```
