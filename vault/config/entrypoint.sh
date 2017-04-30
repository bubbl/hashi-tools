#!/bin/dumb-init /bin/sh
set -e

gosu vault /bin/vault server -config=/vault/config/config.hcl

