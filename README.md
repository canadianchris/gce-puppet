#GCE Puppet

This is my first try at building interactions with GCE through Puppet. I'm leaning on some key modules to build
a simple nginx server that hosts a webpage pulled down through git. 

###Requirements

* Puppet master server. I'm using the learning VM from Puppet right now as my master.
* modules: jfryman-nginx, puppetlabs-vcsrepo and puppetlabs-gce_compute
* GCE SDK installed, configured and gcloud auth complete! 

###gce-pemaster.pp

This manifests deploys a PE master.

###gce-nginx.pp

This manifest deploys the nginx server, and connects puppet agent to the master.
