#!/bin/bash
#SBATCH --mem=200G
module load devel/Miniconda/Miniconda3
module load bioinfo/pixy/1.2.11
module load bioinfo/tabix/1.18
module load bioinfo/Bcftools/1.21
module load bioinfo/bgzip/1.18
#whole chromosome

tabix -p vcf -f ../data/sfC.ver6.final.allsites.vcf.gz
pixy --stats pi --vcf ../data/sfC.ver6.final.allsites.vcf.gz --populations sfC.txt --bypass_invariant_check 'yes' --window_size 100000 --n_cores 16 --output_folder ../result/ --output_prefix pixy_sfC


tabix -p vcf -f ../data/merged.Danaus_plexippus.final.allsites.vcf.gz
pixy --stats pi --vcf ../data/merged.Danaus_plexippus.final.allsites.vcf.gz --populations Dplex.txt --window_size 100000 --bypass_invariant_check 'yes' --n_cores 4 --output_folder ../result/ --output_prefix pixy_Dplex_test

#4D sites only

tabix -f ../data/sfC.allsites.filtered.4D.vcf.gz
pixy --stats pi --vcf ../data/sfC.allsites.filtered.4D.vcf.gz --populations sfC.txt --bypass_invariant_check 'yes' --window_size 100000 --n_cores 4 --output_folder ../result/ --output_prefix pixy_sfC_4D_woTE

tabix -f ../data/Danaus.allsites.4D.vcf.gz
pixy --stats pi --vcf ../data/Danaus.allsites.4D.vcf.gz --populations Dplex.txt --window_size 100000 --bypass_invariant_check 'yes' --n_cores 4 --output_folder ../result/ --output_prefix pixy_Dplex_4D_woTE


#0D sites only

tabix -f ../data/sfC.allsites.filtered.0D.woTE.vcf.gz
pixy --stats pi --vcf ../data/sfC.allsites.filtered.0D.woTE.vcf.gz --populations sfC.txt --bypass_invariant_check 'yes' --window_size 100000 --n_cores 4 --output_folder ../result/ --output_prefix pixy_sfC_0D_woTE

tabix -f ../data/Danaus.allsites.0D.vcf.gz
pixy --stats pi --vcf ../data/Danaus.allsites.0D.vcf.gz --populations Dplex.txt --window_size 100000 --bypass_invariant_check 'yes' --n_cores 4 --output_folder ../result/ --output_prefix pixy_Dplex_0D_woTE
