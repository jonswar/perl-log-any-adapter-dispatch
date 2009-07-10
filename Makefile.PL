use inc::Module::Install;

name 'Log-Any-Adapter-Log-Dispatch';
abstract 'Adapter to use Log::Dispatch with Log::Any';
all_from 'lib/Log/Any/Adapter/Log/Dispatch.pm';
author 'Jonathan Swartz <swartz@pobox.com>';

perl_version '5.006';

build_requires 'Test::Class' => 0;
build_requires 'Test::Most'  => 0;

# requires 'List::MoreUtils'           => '0.13';

license 'perl';

auto_install;

WriteAll;
