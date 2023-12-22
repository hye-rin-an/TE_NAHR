#!/bin/python

tree="2 1\n(exigua, sfrugi);\n"
n=0
txt=""
while n<1000:
    txt=txt+tree
    n+=1

with open("/home/han/work/Metazoa_holocentrism/FAW_BAW/dnds/script/1000tree","w")as tfile:
    tfile.write(''.join(txt))
tfile.close()


