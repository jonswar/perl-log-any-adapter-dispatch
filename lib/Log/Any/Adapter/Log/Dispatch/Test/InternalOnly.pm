package Log::Any::Adapter::Log::Dispatch::Test::InternalOnly;
use Test::More;
use strict;
use warnings;

sub import {
    unless ( $ENV{LOG_ANY_ADAPTER_LOG_DISPATCH_INTERNAL_TESTS} ) {
        plan skip_all => "internal test only";
    }
}

1;
