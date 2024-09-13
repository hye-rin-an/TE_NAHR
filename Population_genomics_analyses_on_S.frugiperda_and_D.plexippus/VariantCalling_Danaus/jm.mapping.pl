use strict;

my $scriptD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/script/mapping';
my $inD='/scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/filteredfq';

my $cmdd='#!/bin/bash
#SBATCH -c 8
. /local/env/envjava-1.8.0.sh

SAMPLE=DGIMI

cd /scratch/knam/Metazoa_holocentrism/Danaus_plexippus/SNV/ref

/scratch/knam/programs/bowtie2-2.3.4.1-linux-x86_64/bowtie2 -x Dplex_v4 -1 ../filteredfq/$SAMPLE.pair1.truncated.gz -2 ../filteredfq/$SAMPLE.pair2.truncated.gz --very-sensitive-local -p 8 | /home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/samtools view -F 4 -b -h -o ../bam/$SAMPLE.raw.bam

cd ../bam

/home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/samtools sort -o $SAMPLE.sorted.bam $SAMPLE.raw.bam

rm $SAMPLE.raw.bam

java -Xmx4g -Djava.io.tmpdir=temp.$SAMPLE -jar /scratch/knam/programs/picard.jar MarkDuplicates INPUT=$SAMPLE.sorted.bam OUTPUT=$SAMPLE.dupl_rm.bam REMOVE_DUPLICATES=true METRICS_FILE=$SAMPLE.metricN.log ASSUME_SORTED=True MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=1000 

rm -rf temp.$SAMPLE
rm $SAMPLE.sorted.bam

java -Xmx4g -Djava.io.tmpdir=temp.$SAMPLE -jar /scratch/knam/programs/picard.jar AddOrReplaceReadGroups INPUT=$SAMPLE.dupl_rm.bam OUTPUT=$SAMPLE.bam RGID=$SAMPLE RGLB=lib1 RGPL=illumina RGPU=unit1 RGSM=$SAMPLE;

rm -rf temp.$SAMPLE
rm $SAMPLE.dupl_rm.bam

/home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/samtools index $SAMPLE.bam
/home/genouest/inra_umr1333/knam/programs/samtools-1.19.2/samtools stats $SAMPLE.bam > $SAMPLE.stats';

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


