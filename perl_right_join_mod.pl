=comment

command line should be $ perl perl_right_join.pl input_on_left input_on_right output_name
make sure that the 2 input files have matching names in the files, and the matching names are in the first part of the second input file.

=cut

my $input1 = shift;
my $input2 = shift;
my $output = shift;
my %intohash;
my $check = 0;

open (INPUT_ONE, "$input1") || die "Cannot open Input1 $input1";
open (INPUT_TWO, "$input2") || die "Cannot open Input2 $input2";
open (OUTPUT, "+> $output") || die "Cannot open Output $output";

while (<INPUT_TWO>) {
    my @temp = split /\t/, $_;
    $temp_size = @temp;
    unless (check == 1){
    $size = length @temp[6];
    $size = $size - 3;
    @temp[6] = substr(@temp[6], 0, $size);
    $intohash{@temp[0]} = join("\t", @temp[1..6]);
    }
    $check = 1;
}
my @keys = keys %intohash;
$key_size = @keys;
while (<INPUT_ONE>) {
    $pat = qr/Probe/;
    chomp $_;
    if ($_ =~ $pat) {
        @temm = split /\t/, $_;
        @temm[10] = substr(@temm[10], 0, 11);
        print OUTPUT join("\t", @temm);
        print OUTPUT "\tDescription\tFunction\tTAIR-annotation\tAGI\tSymbol\tshort_description\n";
    }
    else{
        for ($i = 0; $i < $key_size; $i++) {
            $patt =qr/@keys[$i]/;
            if ($_ =~ $patt) {
                @tempp = split /\t/, $intohash{@keys[$i]};
                @tem = split /\t/, $_;
                $size = length @tem[6];
                $size = $size - 3;
                @tem[6] = substr(@tem[6], 0, 3);
                print OUTPUT join("\t", @tem);
                print OUTPUT "\t";
                print OUTPUT join("\t", @tempp);
                print OUTPUT "\n";
            }
        }
    }
}

close (INPUT1);
close (INPUT2);
close (OUTPUT);
