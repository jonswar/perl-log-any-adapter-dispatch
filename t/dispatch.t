#!perl
use File::Temp qw(tempdir);
use File::Slurp;
use Log::Any;
use Test::More tests => 1;
use Log::Dispatch;
use Log::Dispatch::File;
use strict;
use warnings;

my $dir = tempdir('log-any-dispatch-XXXX', TMPDIR => 1, CLEANUP => 1);
my $dispatcher = Log::Dispatch->new();
$dispatcher->add(
    Log::Dispatch::File->new(
        name      => 'foo',
        min_level => 'info',
        filename  => "$dir/test.log",
        callbacks => sub { my %params = @_; "$params{message}\n" },
    )
);
Log::Any->set_adapter( 'Log::Dispatch', dispatcher => $dispatcher );

Log::Any->get_logger( category => 'Foo' )->error("hello");
Log::Any->get_logger( category => 'Bar' )->info("goodbye");
Log::Any->get_logger( category => 'Baz' )->debug("aigggh!");

is( read_file("$dir/test.log"), "hello\ngoodbye\n", "got expected logs" );
