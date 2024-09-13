#!/bin/python
import os, glob
from os import listdir
from os.path import isfile, join
import fnmatch

temp='#!/bin/bash\n#SBATCH -c 8\nmodule load bioinfo/RepeatMasker-4.1.0\ncd /home/knam/work/Metazoa_holocentrism/genomes/ncbi-genomes-2023-01-17\nRepeatMasker -pa 8 -lib LIBRARY -dir OUTPUTDIR INPUTFILE -x'

libraries='/home/knam/work/Metazoa_holocentrism/repeatmodeller/libraries'
genomefiledir='/home/knam/work/Metazoa_holocentrism/genomes/ncbi-genomes-2023-01-17'
repeatmaskeroutputdir= '/home/knam/work/Metazoa_holocentrism/repeatmasker/postRMlib'
scriptD='/home/knam/work/Metazoa_holocentrism/repeatmasker/script/jrmlib'

grasshopdir='/home/knam/work/Metazoa_holocentrism/repeatmasker/GCF_021461395.2_iqSchAmer2.1_genomic.fna/indichr/ref'

genomefiles =[]
ghfiles = []

for file in os.listdir(genomefiledir):
    if fnmatch.fnmatch(file, '*.fna'):
        genomefiles.append(file)

for ghfile in os.listdir(grasshopdir):
    if fnmatch.fnmatch(ghfile, '*.fa'):
        ghfiles.append(ghfile)


i=0
for genomefile in genomefiles :
  j=temp
  inputfile = genomefiledir + '/' + genomefile
  outputdirectory= repeatmaskeroutputdir + '/'+ genomefile
  library= libraries+'/lib.'+genomefile

  j=j.replace("INPUTFILE", inputfile)
  j=j.replace("OUTPUTDIR", outputdirectory)
  j=j.replace('LIBRARY',library)
 
  fd=scriptD + '/j' + str(i)
  txt=open(fd, "w")
  txt.write(j)
  txt.close()

  i=i+1

k=0
for ghfilename in ghfiles:
  j=temp
  inputfile=grasshopdir +'/' + ghfilename
  outputdirectory=repeatmaskeroutputdir + '/GCF_021461395.2_iqSchAmer2.1_genomic.fna/' + ghfilename
  library= libraries + '/lib.GCF_021461395.2_iqSchAmer2.1_genomic.fna'

  j=j.replace("INPUTFILE", inputfile)
  j=j.replace("OUTPUTDIR", outputdirectory)
  j=j.replace('LIBRARY',library)

  fd=scriptD + '/jGH' + str(k)
  txt=open(fd, "w")
  txt.write(j)
  txt.close()

  k=k+1
