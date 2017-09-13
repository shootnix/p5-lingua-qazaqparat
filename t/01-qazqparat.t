#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Lingua::Qaz;

use utf8;


# 1. croak test
# ...

# 2. single char test
is(Lingua::Qaz::in('qazaqparat', \'А'), 'A');

# 3. multi char test
is(Lingua::Qaz::in('qazaqparat', \'Әә'), 'Ää');

# 4. chars + spaces
is(Lingua::Qaz::in('qazaqparat', \'Ә ә'), 'Ä ä');

# 5. chars + numbers
is(Lingua::Qaz::in('qazaqparat', \'Ә ә 2'), 'Ä ä 2');


done_testing();