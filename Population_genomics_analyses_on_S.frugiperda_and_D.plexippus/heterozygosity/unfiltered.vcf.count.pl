use strict;

my $vcfF='/home/knam/work/missing/sfC.ver6.unfiltered.allsites.vcf.gz';
my $resF='/home/knam/work/missing/FAW.unfiltered.txt';

my $WS=100000;
my %homo;

my $n=0;
my $pchr="d";
open my $fd,"zcat $vcfF | ";
while(<$fd>)
{
	if($_=~/#/) {next}
	$_=~s/\n//g;	
	
	my @s=split("\t",$_);

	my $nv=0;
	while($s[4]=~/,/g) {$nv++}
	if($nv>2) {next}	    # only biallelic
	if($s[4]=~/\w{2,}/) {next}  # remove indel

	for(my $i=9;$i<=$#s;$i++)
	{
		my $key="$s[0]\t".int($s[1]/$WS)."\t".($i-9);
	
		if($s[$i]=~/0\/0/) {$homo{$key}++}
	}

	if($n % 100000 == 0)
	{
		print "$s[0] $s[1]\n";
	}
	$n++;
	#	if($pchr ne $s[0])
	#	{
	#		print "$s[0]\n";
	#		$pchr=$s[0];
	#	}
}

my @ws=sort {$a cmp $b} keys %homo;

my $res="chro\tstart\tsample\tn.00\n";
foreach my $w (@ws)
{
	$res.="$w\t$homo{$w}\n";
}

open my $fd,">$resF";
print $fd $res;
close $fd;


