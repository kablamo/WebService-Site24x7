package WebService::Site24x7;

use Moo;
use WebService::Site24x7::Client;
use WebService::Site24x7::Reports;

our $VERSION = "0.03";

has auth_token        => (is => 'rw', required => 1);
has user_agent_header => (is => 'rw');
has client            => (is => 'lazy', handles => [qw/get/]);

sub _build_client {
    my $self = shift;
    my $client = WebService::Site24x7::Client->new(
        auth_token => $self->auth_token,
        version    => $VERSION,
    );

    $client->user_agent_header($self->user_agent_header)
        if $self->user_agent_header;

    return $client;
}

has reports => (is => 'lazy');

sub _build_reports { WebService::Site24x7::Reports->new(client => shift) }

sub monitors {
    my ($self) = @_;
    my $res = $self->get('/monitors');
    return $res->data;
}

1;
__END__

=encoding utf-8

=head1 NAME

WebService::Site24x7 - An api client for https://site24x7.com

=head1 SYNOPSIS

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

=head1 DESCRIPTION

WebService::Site24x7 is an api client for https://site24x7.com.  Its currently
implements a really really limited subset of all the endpoints though.

=head1 LICENSE

Copyright (C) Eric Johnson.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Eric Johnson E<lt>eric.git@iijo.orgE<gt>

=cut

