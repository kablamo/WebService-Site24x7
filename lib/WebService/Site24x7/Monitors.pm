package WebService::Site24x7::Monitors;

use Moo;

has client => (is => 'rw', required => 1, handles => [qw/get/]);

sub list {
    my ($self) = @_;
    my $res = $self->get('/monitors');
    return $res->data;
}

1;
