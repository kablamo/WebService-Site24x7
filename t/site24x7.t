use strict;
use warnings;
use Test::More;# skip_all => 'Site24x7 account required';
use WebService::Site24x7;
use DateTime;

my $res;
my $site24x7 = WebService::Site24x7->new(
    auth_token        => $ENV{WEBSERVICE_SITE24X7_AUTH_TOKEN},
    user_agent_header => 'boop',
);

note "monitors";
$res = $site24x7->monitors;
is $res->{message}, "success", "message: success";
is $res->{code}, 0, "code: 0";
ok scalar @{ $res->{data} } >= 1, "found at least one monitor";

note "log_reports";
my $monitor_id = $res->{data}->[0]->{monitor_id};
# time zone must match the one set in the website's preferences
my $date = DateTime->now(time_zone => 'America/New_York');
$res = $site24x7->reports->log_reports($monitor_id, date => $date->ymd);
is $res->{message}, "success",              "message: success";
is $res->{code},    0,                      "code: 0";
ok $res->{data}->{headers},                 "found headers";
ok $res->{data}->{report},                  "found report";
ok scalar @{ $res->{data}->{report} } >= 1, "found at least one result";

done_testing;
