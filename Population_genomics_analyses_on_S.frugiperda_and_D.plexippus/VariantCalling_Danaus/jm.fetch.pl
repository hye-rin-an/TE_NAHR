use strict;

my $OD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/script/fetch';
my $sampleID='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/sample/SRR_Acc_List.txt';

my $j=0;
open my $fd,$sampleID;
while(<$fd>)
{
	$_=~s/\n//;
	my $cmdd=
"#!/bin/bash

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/rawfq

/scratch/knam/programs/sratoolkit.3.0.0-ubuntu64/bin/fastq-dump --split-3 --gzip $_;

";

	open my $fd,">$OD/j$j";
	print $fd $cmdd;
	close $fd;

	print "sbatch j$j\n";
	$j++;

}
close $fd;

