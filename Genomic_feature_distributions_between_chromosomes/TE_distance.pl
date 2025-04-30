#!/bin/perl

use strict;
use File::Find;
use File::Basename;

my $iD='/scratch/hran/FAW_TE/BUSCO/data/repeatmasker/';
my $oF='/scratch/hran/FAW_TE/BUSCO/result/';

my @files;
find(sub { push @files, $File::Find::name if /.*out$/ }, $iD);

foreach my $fI (@files) {
    my ($filename) = fileparse($fI); 
    my $output_file = "$oF/${filename}_TEdist_div5_10.txt"; 
    my $res = "chrN\tleng\tDist.5div\tDist.10div\n";
    
    open my $fd, '<', $fI;
    open my $out, '>', $output_file;
    my ($S1, $n1, $S2, $n2, $e1, $e2, $e);
    my $current_chr = "";
	while(<$fd>)
	{
		$_=~s/^ {1,}//;
		$_=~s/ {1,}$//;
		$_=~s/ {1,}/\t/g;
		my @s=split("\t",$_);
		unless($s[9]=~/rn/) {next}
	         
                if ($current_chr ne "" && $current_chr ne $s[4]) {
			if ($n1 > 0 && $n2 > 0) {
                            my $d1=$S1/$n1;
                            my $d2=$S2/$n2;
                            $res.="$current_chr\t$e\t$d1\t$d2\n";}
                            ($S1, $n1, $S2, $n2, $e1, $e2, $e) = (0, 0, 0, 0, 0, 0, 0);}
                $current_chr = $s[4];
		my $div=$s[1]+$s[2]+$s[3];

		if($s[1] < 5)
		{
			my $dist=$s[5]-$e1;
			$S1+=$dist;
			$n1++;
			$e1=$s[6];
		}
		if(5 < $s[1] &&  $s[1] < 10)
		{
			my $dist=$s[5]-$e2;
			$S2+=$dist;
			$n2++;
			$e2=$s[6]
		}
		$e=$s[6];

	}
	close $fd;
	if ($n1 > 0 && $n2 > 0) {
	my $d1=$S1/$n1;
	my $d2=$S2/$n2;
	$res.="$current_chr\t$e\t$d1\t$d2\n";}

print $out $res;
close $out;
}
