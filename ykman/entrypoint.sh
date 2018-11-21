#!/bin/bash
set -o errexit
set -o pipefail

# Start the smart card daemon
/usr/sbin/pcscd --debug --apdu
/usr/sbin/pcscd --hotplug

/usr/bin/ykman $@