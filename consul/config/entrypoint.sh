#!/bin/dumb-init /bin/sh
set -e

gosu consul /bin/consul agent -server -config-dir=/consul/config -data-dir=/consul/data

