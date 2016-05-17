# NAME

WebService::Site24x7 - An api client for https://site24x7.com

# SYNOPSIS

    use WebService::Site24x7;

    my $site24x7 = WebService::Site24x7->new(
        auth_token        => '...'
        user_agent_header => 'mybot v1.0',
    );

    my $res = $site24x7->monitors;
    for my $monitor (@{ $res->{data} }) {
        print $monitor->{display_name}, "\n";
    }

    my $res = $site24x7->reports->log_reports($monitor_id, date => $date);
    print $res->{data}->{report}->{dns_time}, "\n";

# DESCRIPTION

WebService::Site24x7 is an api client for https://site24x7.com.  Its currently
implements a really really limited subset of all the endpoints though.

# LICENSE

Copyright (C) Eric Johnson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Eric Johnson <eric.git@iijo.org>
