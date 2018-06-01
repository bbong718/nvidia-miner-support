package gpu::gpu_global;
use warnings;
use strict;

my %_singleton = (
    'nvidia-settings'    => '/usr/bin/nvidia-settings',
    'nvidia-smi'        => '/usr/bin/nvidia-smi', 

    # Immutable, should be set during configuration
    'manager'           => 'nvidia-smi',
    'settings'          => 'nvidia-settings',
    'lspci-bin'         => '/usr/bin/lspci',
    'lspci'             => 'NVIDIA',
);

sub get_property { my $prop = shift;
    return $_singleton{$prop};
}

sub put_property { my ($name, $prop) = @_;
    if ( $name !~ 'manager|settings|lspci' ) {
        return $_singleton{$name} = $prop;
    } else {
        die "attempt at modifying immutable property!";
    }
}

sub delete_property { my $prop = shift;
    if ( $prop !~ 'manager|settings|lspci' ) {
        return delete $_singleton{$prop};
    } else {
        die "attempt at modifying immutable property!";
    }
}

sub debug { my ($level, $id, $log) = @_;
    printf localtime(time()). " : $level : $id : $log\n";
}


1;
