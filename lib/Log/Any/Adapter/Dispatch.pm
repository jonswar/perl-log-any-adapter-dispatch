package Log::Any::Adapter::Dispatch;
use Carp qw(croak);
use Log::Any::Util qw(make_method);
use strict;
use warnings;
use base qw(Log::Any::Adapter::Base);

our $VERSION = '0.04';

sub init {
    my ($self) = @_;

    croak 'must supply dispatcher' unless defined( $self->{dispatcher} );
}

# Delegate logging methods to same methods in dispatcher
#
foreach my $method ( Log::Any->logging_methods() ) {
    __PACKAGE__->delegate_method_to_slot( 'dispatcher', $method, $method );
}

# Delegate detection methods to would_log
#
foreach my $method ( Log::Any->detection_methods() ) {
    my $level = substr( $method, 3 );
    make_method( $method,
        sub { my ($self) = @_; return $self->{dispatcher}->would_log($level) }
    );
}

1;

__END__

=pod

=head1 NAME

Log::Any::Adapter::Dispatch

=head1 SYNOPSIS

    use Log::Dispatch;
    my $dispatcher = Log::Dispatch->new();
    $dispatcher->add(Log::Dispatch::File->new(...));
    $dispatcher->add(Log::Dispatch::Screen->new(...));
    Log::Any->set_adapter('Dispatch', dispatcher => $dispatcher);

=head1 DESCRIPTION

This Log::Any adapter uses L<Log::Dispatch|Log::Dispatch> for logging. There is
a single required parameter, I<dispatcher>, which must be a valid Log::Dispatch
object.

=head1 SEE ALSO

L<Log::Any|Log::Any>, L<Log::Dispatch|Log::Dispatch>

=head1 AUTHOR

Jonathan Swartz

=head1 COPYRIGHT & LICENSE

Copyright (C) 2007 Jonathan Swartz, all rights reserved.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut
