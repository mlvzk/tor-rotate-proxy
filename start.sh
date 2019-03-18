#!/bin/sh

seq $RANGE_FROM $RANGE_TO | xargs -n 1 -I'{}' tor --SocksPort {} --MaxCircuitDirtiness 10 --PidFile /var/run/tor/{}.pid --RunAsDaemon 1 --DataDirectory /var/db/tor/{}
haproxy -f /haproxy.conf -q -db
