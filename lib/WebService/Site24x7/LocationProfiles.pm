package WebService::Site24x7::LocationProfiles;

use Moo;

has client => (is => 'rw', required => 1, handles => [qw/get/]);

sub list {
    my ($self) = @_;
    my $res = $self->get('/location_profiles');
    return $res->data;
}

1;
