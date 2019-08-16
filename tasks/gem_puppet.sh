#!/bin/bash

# Puppet Task Name: 

if [ ! -f '/usr/bin/ruby' ]; then
  apt-get install -y ruby
fi

if [ ! -f '/usr/local/bin/puppet' ]; then
  gem install puppet --no-ri --no-rdoc
fi
