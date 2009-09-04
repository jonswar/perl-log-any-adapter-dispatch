#!perl
use File::Temp qw(tempdir);
use Log::Any;
use Log::Any::Util qw(read_file);
use Log::Dispatch::File;
use Log::Dispatch;
use Test::More tests => 26;
use strict;
use warnings;

my $dir = tempdir( 'log-any-dispatch-XXXX', TMPDIR => 1, CLEANUP => 1 );
my $dispatcher = Log::Dispatch->new();
$dispatcher->add(
    Log::Dispatch::File->new(
        name      => 'foo',
        min_level => 'notice',
        filename  => "$dir/test.log",
        mode      => 'append',
        callbacks => sub { my %params = @_; "$params{message}\n" },
    )
);
Log::Any->set_adapter( 'Log::Dispatch', dispatcher => $dispatcher );

my $log = Log::Any->get_logger();
foreach my $method (Log::Any->logging_methods, Log::Any->logging_aliases) {
    $log->$method("logging with $method");
}
my $contents = read_file("$dir/test.log");
foreach my $method (Log::Any->logging_methods, Log::Any->logging_aliases) {
    if ($method !~ /debug|info/) {
        like($contents, qr/logging with $method\n/, "found $method");
    }
    else {
        unlike($contents, qr/logging with $method/, "did not find $method");
    }
}
foreach my $method (Log::Any->detection_methods, Log::Any->detection_aliases) {
    if ($method !~ /debug|info/) {
        ok($log->$method, "$method");
    }
    else {
        ok(!$log->$method, "!$method");
    }
}
