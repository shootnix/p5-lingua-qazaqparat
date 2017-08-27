#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Lingua::Qazaqparat;

use utf8;


# 1. croak test
# ...

# 2. single char test
is(Lingua::Qazaqparat::in(\'А'), 'A');

# 3. multi char test
is(Lingua::Qazaqparat::in(\'Әә'), 'Ää');

# 4. chars + spaces
is(Lingua::Qazaqparat::in(\'Ә ә'), 'Ä ä');

# 5. chars + numbers
is(Lingua::Qazaqparat::in(\'Ә ә 2'), 'Ä ä 2');

# 6. multilines
# ...


# 1. croak test
# ...

# 2. single char test
is(Lingua::Qazaqparat::out(\'A'), 'А');

# 3. multi char test
is(Lingua::Qazaqparat::out(\'Ää'), 'Әә');

# 4. chars + spaces
is(Lingua::Qazaqparat::out(\'Ä ä'), 'Ә ә');

# 5. chars + numbers
is(Lingua::Qazaqparat::out(\'Ä ä 2'), 'Ә ә 2');

# 6. multilines
# ...




done_testing();