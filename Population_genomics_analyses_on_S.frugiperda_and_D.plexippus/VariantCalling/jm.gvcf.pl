use strict;

my $scriptD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/script/gvcf';
my $inD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/filteredfq';

my $cmdd=
'#!/bin/bash
#SBATCH -c 4
#SBATCH --mem=40G

. /local/env/envconda3.sh
. genouest_conda_activate "python-3.8.5"
. /local/env/envjava-1.8.0.sh

SAMPLE=DGIMI

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/gvcf

/scratch/knam/programs/gatk-4.1.2.0/gatk HaplotypeCaller -R ../ref/GCA_009731565.1_Dplex_v4_genomic.fna -I ../bam/$SAMPLE.bam -O $SAMPLE.g.vcf.gz -ERC GVCF

';

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my @IDs;
foreach my $f (@files)
{
        if($f=~/^(\w+).*pair1/) {push @IDs,$1}
}

my $j=0;
foreach my $id (@IDs)
{
        my $tc=$cmdd;
        $tc=~s/DGIMI/$id/g;

        open my $fd,">$scriptD/j$j";
        print $fd $tc;
        close $fd;

        print "sbatch $scriptD/j$j\n";
        $j++;
}

