package App::perlmv::scriptlet::prefix_with_number;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

our $SCRIPTLET = {
    summary => 'Prefix filenames with number (usually to make them easily sortable)',
    description => <<'_',


_
    args => {
        digits => {
            summary => 'Number of digits to use (1 means 1,2,3,..., 2 means 01,02,03,...); the default is to autodetect',
            schema => 'posint*',
            req => 1,
        },
        start => {
            summary => 'Number to start from',
            schema => 'int*',
            default => 1,
        },
        interval => {
            summary => 'Interval from one number to the next',
            schema => 'int*',
            default => 1,
        },
    },
    code => sub {
        package
            App::perlmv::code;

        use vars qw($ARGS $TESTING $i);

        $ARGS //= {};
        my $digits = $ARGS->{digits} // (@$FILES >= 1000 ? 4 : @$FILES >= 100 ? 3 : @$FILES >= 10 ? 2 : 1);
        my $start  = $ARGS->{start} // 1;
        my $interval = $ARGS->{interval} // 1;

        $i //= 0;
        $i++ unless $TESTING;

        my $num  = $start + ($i-1)*$interval;
        my $fnum = sprintf("%0${digits}d", $num);
        "$fnum-$_";
    },
};

1;

# ABSTRACT:

=head1 SYNOPSIS

The default is sorted ascibetically:

 % perlmv prefix-with-number foo bar.txt baz.mp3

 1-bar.txt
 2-baz.mp3
 3-foo

Don't sort (C<-T> perlmv option), use two digits:

 % perlmv prefix-with-number foo bar.txt baz.mp3

 01-foo
 02-bar.txt
 03-baz.mp3


=cut
