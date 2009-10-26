#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok('Log::Any::Adapter::Dispatch');
}

diag(
    "Testing Log::Any::Adapter::Dispatch $Log::Any::Adapter::Dispatch::VERSION, Perl $], $^X"
);
