use strict;

my $genomeD='/home/knam/work/Metazoa_holocentrism/genomes/ncbi-genomes-2023-01-17';
my $sciptD='/home/knam/work/Metazoa_holocentrism/repeatmodeller/script/j';
my $template='#!/bin/bash
#SBATCH -c 24
#SBATCH --mem 100G

module load bioinfo/RepeatModeler-2.0.3

cd /home/knam/work/Metazoa_holocentrism/repeatmodeller/result

BuildDatabase -name FILENAME FITT

RepeatModeler -pa 24 -database FILENAME';

my $j=0;

opendir my $D,$genomeD;
my @files=readdir($D);

foreach my $f (@files)
{
	unless($f=~/fna/) {next}

	my $jobs=$template;
	
	my $fn="$genomeD/$f";

	$jobs=~s/FILENAME/$f/g;
	$jobs=~s/FITT/$fn/g;

	open my $fd,">$sciptD/j$j";
	print $fd $jobs;
	close $fd;

	print "sbatch $sciptD/j$j\n";
	$j++;

}

