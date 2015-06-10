#!/usr/bin/env bash
source /home/kiki/.rvm/environments/ruby-2.1.0@rhubarb
cd /home/kiki/rhubarb.northpole.ro/current/
RACK_ENV=production ki tasks seed
