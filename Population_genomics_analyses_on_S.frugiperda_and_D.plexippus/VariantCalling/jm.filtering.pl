use strict;

my $inD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/rawfq';
my $OutD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/filteredfq';

my $sOutD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/script/filtering';

my $tmp1='/scratch/knam/sfrugi_Thai/SNP/rawfq/R1';
my $tmp2='/scratch/knam/sfrugi_Thai/SNP/rawfq/R2';

opendir my $Di,$inD;
my @files=readdir($Di);
close $Di;

my %P1;
my %P2;

foreach my $f (@files)
{
	unless($f=~/\w/){next}
	$f=~/^(\w+)_(\d)\.fastq\.gz/;

	my $id=$1;
	my $pair=$2;

	my $FD="$inD/$f";

	if($pair == 1) {$P1{$id}.="$FD "}
	if($pair == 2) {$P2{$id}.="$FD "}
}

my @IDs=keys %P1;

my $j=0;

foreach my $id (@IDs)
{
	my @R1=split(' ',$P1{$id});
	my @R2=split(' ',$P2{$id});

	my $cmdd=
'#!/bin/bash

';

	if($#R1+$#R2>0)
	{
		my $nr=rand int 100000;
		my $temp1="$tmp1.$nr.fq";
		my $temp2="$tmp2.$nr.fq";

		$cmdd.="rm $temp1\n";
		$cmdd.="rm $temp2\n";
		foreach my $f1 (@R1)
		{
			$cmdd.="zcat $f1 >> $temp1\n";
			my $f2=$f1;

			$f2=~s/_1\.fq\.gz/_2\.fq\.gz/;
			$cmdd.="zcat $f2 >> $temp2\n";
		}
		$cmdd.="/scratch/knam/programs/adapterremoval-2.1.7/build/AdapterRemoval --file1 $temp1 --file2 $temp2 --basename $OutD/$id --trimns --trimqualities --minquality 20 --gzip --threads 1\n";

		$cmdd.="rm $temp1\n";
		$cmdd.="rm $temp2\n";
	}
	else
	{
		$cmdd.="/scratch/knam/programs/adapterremoval-2.1.7/build/AdapterRemoval --file1 $P1{$id} --file2 $P2{$id} --basename $OutD/$id --trimns --trimqualities --minquality 20 --gzip --threads 1\n";
	}
	
	open my $fd,">$sOutD/j$j";
	print $fd $cmdd;
	close $fd;
	
	print "sbatch $sOutD/j$j\n";
	$j++;
}

