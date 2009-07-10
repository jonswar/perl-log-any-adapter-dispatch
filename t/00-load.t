#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Log::Any::Adapter::Log::Dispatch' );
}

diag( "Testing Log::Any::Adapter::Log::Dispatch $Log::Any::Adapter::Log::Dispatch::VERSION, Perl $], $^X" );
