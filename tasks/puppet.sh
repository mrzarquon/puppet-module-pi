#!/bin/bash

declare -x PUPPET_VERSION=$PT_puppet_version
declare -x PUPPET_DEB_URL=$PT_puppet_deb_url

function install_puppet {
  declare -x TEMPDIR=$(mktemp -d -t bolt-pi-XXXXXXXXXX)

  if [ ! -f '/usr/bin/curl' ]; then
    apt-get install -y curl  
  fi

  curl -o $TEMPDIR/puppet_raspbian.deb $PUPPET_DEB_URL

  dpkg -i $TEMPDIR/puppet_raspbian.deb
  apt-get update
  apt-get install -y puppet-agent

  /opt/puppetlabs/bin/puppet resource service puppet ensure=stopped enable=false
  /opt/puppetlabs/bin/puppet resource service pxp-agent ensure=stopped enable=false
  
  if [[ $TEMPDIR == *"bolt-pi-"* ]]; then
    rm -rf $TEMPDIR
  fi
}

function upgrade_puppet {
  apt-get update
  apt-get install -y --only-upgrade puppet-agent
}

if [ ! -h '/opt/puppetlabs/bin/puppet' ]; then
  install_puppet
elif [[ $PUPPET_VERSION != `/opt/puppetlabs/bin/puppet --version` ]]; then
  upgrade_puppet
else
  echo "Puppet installed and already up to date"
fi

