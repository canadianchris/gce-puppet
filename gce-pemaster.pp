gce_instance { 'puppet-enterprise-master':
    ensure         => present,
    description    => 'Puppet Enterprise Master and Console',
    machine_type   => 'n1-standard-1',
    zone           => 'us-central1-a',
    network        => 'default',
    image          => 'projects/centos-cloud/global/images/centos-6-v20131120',
    tags           => ['puppet', 'pe-master'],
    startupscript  => 'puppet-enterprise.sh',
    metadata       => {
        'pe_role'         => 'master',
        'pe_version'      => '3.3.1',
        'pe_consoleadmin' => 'admin@example.com',
        'pe_consolepwd'   => 'puppetize',
    },
    service_account_scopes => ['compute-ro'],
}
