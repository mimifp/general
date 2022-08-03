## NextFlow

In this document are summarizes some interesants facts of Nextflow execution.

- Nextflow creates an execution directory by each task, which contains logs, relevant outputs and other files. Each directory indentifies by an unique hash.
- There are two principal ways to add numeric channels:
  ```
  - Channel.value(x) --> unlimited process
  - Channel.of(y,z,w) --> one process that iterates on values of channel
  ```
- Nextflow creates a symlink to access to files, one unique per each one. To load files
  ```
  Channel.fromPath('directory/file.ext')
  ```
- To execute specific version of Nextflow add to command line
  ```
  NXF_VER=20.04.0
  ```
- To execute Nextflow in local its neccessary versions of Java between 11 and 18. For this, in macOS its neccesary to create an coonda enviroment with one of this java version. In my case, I create java_17 conda enviroment with openjk-17.0.3 java version.
  ```
  conda create -n java_17 openjdk=17
  ```
