package Lingua::Qaz;

use 5.010;
use strict;
use warnings;
use utf8;

use Carp qw/carp croak/;

=head1 NAME

Lingua::Qaz - Kazakh language transliteration module

=head1 VERSION

Version 0.03

=cut

our $VERSION = '0.03';

my %QAZAQPARAT = (
	'А' => 'A',  'а' => 'a',
	'Ә' => 'Ä',  'ә' => 'ä',
	'Б' => 'B',  'б' => 'b',
	'В' => 'V',  'в' => 'v',
	'Г' => 'G',  'г' => 'g',
	'Ғ' => 'Ğ',  'ғ' => 'ğ',
	'Д' => 'D',  'д' => 'd',
	'Е' => 'E',  'е' => 'e',
	'Ё' => 'Yo', 'ё' => 'yo',
	'Ж' => 'J',  'ж' => 'j',
	'З' => 'Z',  'з' => 'z',
	'И' => 'Ï ', 'и' => 'ï',
	'Й' => 'Y',  'й' => 'y',
	'К' => 'K',  'к' => 'k',
	'Қ' => 'Q',  'қ' => 'q',
	'Л' => 'L',  'л' => 'l',
	'М' => 'M',  'м' => 'm',
	'Н' => 'N',  'н' => 'n',
	'Ң' => 'Ñ',  'ң' => 'ñ',
	'О' => 'O',  'о' => 'o',
	'Ө' => 'Ö',  'ө' => 'ö',
	'П' => 'P',  'п' => 'p',
	'Р' => 'R',  'р' => 'r',
	'С' => 'S',  'с' => 's',
	'Т' => 'T',  'т' => 't',
	'У' => 'W',  'у' => 'w',
	'Ұ' => 'U',  'ұ' => 'u',
	'Ү' => 'Ü',  'ү' => 'ü',
	'Ф' => 'F',  'ф' => 'f',
	'Х' => 'X',  'х' => 'x',
	'Һ' => 'H',  'һ' => 'h',
	'Ц' => 'C',  'ц' => 'c',
	'Ч' => 'Ç',  'ч' => 'ç',
	'Ш' => 'Ş',  'ш' => 'ş',
	'Щ' => 'Şş', 'щ' => 'şş',
	'Ъ' => 'ʺ',  'ъ' => 'ʺ',
	'Ы' => 'I',  'ы' => 'ı',
	'І' => 'İ',  'і' => 'i',
	'Ь' => 'ʹ',  'ь' => 'ʹ',
	'Э' => 'E',  'э' => 'e',
	'Ю' => 'Yu', 'ю' => 'yu',
	'Я' => 'Ya', 'я' => 'ya',
);

my %TLESHOV = (
	'А' => 'A',  'а' => 'a',
	'Ә' => 'Ae',  'ә' => 'ae',
	'Б' => 'B',  'б' => 'b',
	'В' => 'V',  'в' => 'v',
	'Г' => 'G',  'г' => 'g',
	'Ғ' => 'Gh',  'ғ' => 'gh',
	'Д' => 'D',  'д' => 'd',
	'Е' => 'E',  'е' => 'e',
	'Ё' => 'E', 'ё' => 'e',
	'Ж' => 'Zh',  'ж' => 'zh',
	'З' => 'Z',  'з' => 'z',
	'И' => 'I ', 'и' => 'i',
	'Й' => 'J',  'й' => 'j',
	'К' => 'K',  'к' => 'k',
	'Қ' => 'Q',  'қ' => 'q',
	'Л' => 'L',  'л' => 'l',
	'М' => 'M',  'м' => 'm',
	'Н' => 'N',  'н' => 'n',
	'Ң' => 'Ng',  'ң' => 'ng',
	'О' => 'O',  'о' => 'o',
	'Ө' => 'Oe',  'ө' => 'oe',
	'П' => 'P',  'п' => 'p',
	'Р' => 'R',  'р' => 'r',
	'С' => 'S',  'с' => 's',
	'Т' => 'T',  'т' => 't',
	'У' => 'W',  'у' => 'w',
	'Ұ' => 'U',  'ұ' => 'u',
	'Ү' => 'Ue',  'ү' => 'ue',
	'Ф' => 'F',  'ф' => 'f',
	'Х' => 'H',  'х' => 'h',
	'Һ' => 'H',  'һ' => 'h',
	'Ц' => 'C',  'ц' => 'c',
	'Ч' => 'Ch',  'ч' => 'ch',
	'Ш' => 'Sh',  'ш' => 'sh',
	'Щ' => 'Shsh', 'щ' => 'shsh',
	'Ъ' => '',  'ъ' => '',
	'Ы' => 'Y',  'ы' => 'y',
	'І' => 'i',  'і' => 'i',
	'Ь' => '',  'ь' => '',
	'Э' => 'E',  'э' => 'e',
	'Ю' => 'Ju', 'ю' => 'ju',
	'Я' => 'Ja', 'я' => 'ja',
);

=head1 SYNOPSIS

    use Lingua::Qaz qw/in/;

	say in('tleshov', \$cyrillic_string); # out is qaz


=head1 SUBROUTINES

=head2 in

Takes Cyrillic, returns Latin. Argumets: method, string (as a scalar-ref).
Methods:
	'tleshov' - official Alphabet
	'qazaqparat' - Qazaqparat Alphabet

=cut

sub in {
	my ($method, $str) = @_;

	ref $str or croak "Argument must be a reference";

	if ($method eq 'tleshov') {
		return _transliterate($str, \%TLESHOV);
	}
	elsif ($method eq 'qazaqparat') {
		return _transliterate($str, \%QAZAQPARAT);
	}
	else {
		croak 'Unknown method: ' . $method;
	}
}

# Private

sub _transliterate {
	my ($str, $key_map) = @_;

	my @letters   = split q//, $$str;
	my $resultstr = q//;

	LETTER:
	for (@letters) {
		$resultstr .= exists $key_map->{$_} ? $key_map->{$_} : $_;
	}

	return $resultstr;
}

=head1 AUTHOR

Alexander Ponomarev, C<< <shootnix at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lingua-qaz at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Lingua-Qaz>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Lingua::Qaz


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Lingua-Qaz>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Lingua-Qaz>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Lingua-Qaz>

=item * Search CPAN

L<http://search.cpan.org/dist/Lingua-Qaz/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2017 Alexander Ponomarev.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of Lingua::Qaz
