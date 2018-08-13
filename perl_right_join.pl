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
    if (length @temp[1] < 11) {
        @temp[1] = substr(@temp[1], 0, 3);
    }
    else {
        @temp[1] = substr(@temp[1], 0, 11);
    }
    $intohash{@temp[0]} = @temp[1];
}
my @keys = keys %intohash;
$key_size = @keys;
while (<INPUT_ONE>) {
    $pat = qr/Probe/;
    chomp $_;
    if ($_ =~ $pat) {
        @temm = split /\t/, $_;
        @temm[9] = substr(@temm[9], 0, 5);
        print OUTPUT join("\t", @temm);
        print OUTPUT "\tHomolog_GID\n";
    }
    else{
        print "else loop is working\t";
        for ($i = 0; $i < $key_size; $i++) {
            $patt =qr/@keys[$i]/;
            if ($_ =~ $patt) {
                @tem = split /\t/, $_;
                @tem[9] = substr(@tem[9], 0, 3);
                print OUTPUT join("\t", @tem);
                print OUTPUT "\t$intohash{@keys[$i]}\n";
            }
        }
    }
}

close (INPUT1);
close (INPUT2);
close (OUTPUT);
print "done\n";
