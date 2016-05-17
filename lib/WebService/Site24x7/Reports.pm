package WebService::Site24x7::Reports;

use Moo;

has client => (is => 'rw', required => 1, handles => [qw/get/]);

sub log_reports {
    my ($self, $monitor_id, %params) = @_;
    my $res = $self->get(
        "/reports/log_reports/${monitor_id}",
        \%params,
    );
    return $res->data;
}

1;
