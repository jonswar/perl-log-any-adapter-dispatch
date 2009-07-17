use inc::Module::Install;

name 'Log-Any-Adapter-Dispatch';
abstract 'Adapter to use Log::Dispatch with Log::Any';
all_from 'lib/Log/Any/Adapter/Dispatch.pm';
author 'Jonathan Swartz <swartz@pobox.com>';

perl_version '5.006';

build_requires 'File::Temp'  => '0.20';
build_requires 'Test::More'  => 0;

requires 'Log::Any' => '0.01';
requires 'Log::Dispatch' => '2.20';

license 'perl';

auto_install;

WriteAll;
