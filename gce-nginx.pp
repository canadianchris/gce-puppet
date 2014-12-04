gce_firewall { 'allow-nginx':
    ensure      => present,
    network     => 'default',
    description => 'allow incoming TCP port 8000',
    allowed     => 'tcp:8000',
}

gce_firewall { 'puppet-traffic':
  ensure      => present,
  network     => 'default',
  description => 'allow puppet master traffic',
  allowed     => 'tcp:8140',
}

gce_disk { 'boot-disk':
    ensure       => present,
    size_gb      => 10,
    zone         => 'us-central1-a',
    source_image => 'debian-7',
}

gce_instance { "homework-nginx":
    ensure        => present,
    description   => 'Basic nginx Server',
    machine_type  => n1-standard-1,
    disk          => 'boot-disk,boot',
    zone          => 'us-central1-a',
    modules       => ['puppetlabs-vcsrepo','jfryman-nginx'],
    require       => Gce_disk['boot-disk'],
    puppet_master => "puppet-enterprise-master.c.stackware-dot-io.internal",
    startupscript => 'puppet-enterprise.sh',
    metadata       => {
      'pe_role'    => 'agent',
      'pe_master'  => "puppet-enterprise-master.c.stackware-dot-io.internal",
      'pe_version' => '3.3.1',
    },
    manifest      => "
        class { 'nginx': }

        service { 'httpd':
            ensure => stop,
        }

        file { '/var/www/html/homework':
            ensure => directory,
        }

        vcsrepo { '/var/www/html/homework':
            ensure    => latest,
            provider  => git,
            source    => 'git://github.com/puppetlabs/exercise-webpage',
            revision  => 'master',
        }
        
        nginx::resource::vhost { 'homework.puppetlabs.vm':
            listen_port      => 8000,
            www_root => '/var/www/html/homework',
        }
        "

}
