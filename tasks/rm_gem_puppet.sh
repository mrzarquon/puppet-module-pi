#!/bin/bash

# if puppet isn't a symlink, it's the gem
if [ ! -h '/usr/local/bin/puppet' ]; then
  echo "uninstall puppet gem"
  /usr/bin/gem uninstall puppet -a -x
  /usr/bin/gem uninstall puppet-resource_api -a -x
else
  echo "puppet not detected, not removed"  
fi

if [ ! -h '/usr/local/bin/facter' ]; then
  echo "uninstall facter gem"
  /usr/bin/gem uninstall facter -a -x
else
  echo "facter not detected, not removed"
fi

if [ ! -h '/usr/local/bin/hiera' ]; then
  echo "uninstall hiera gem"
  gem uninstall hiera -a -x
else
  echo "hiera not detected, not removed"
fi
