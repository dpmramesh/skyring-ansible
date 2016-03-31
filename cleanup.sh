#!/bin/sh
systemctl stop skyringd.service
service salt-master stop
mongo<<EOF
use skyring
db.skyring_session_store.drop()
db.skyring_utilization.drop()
db.block_devices.drop()
db.app_events.drop()
db.storage_nodes.drop()
db.storage_clusters.drop()
db.storage_logical_units.drop()
db.storage_profile.drop()
db.storage.drop()
db.tasks.drop()
db.mailnotifier.drop()
EOF
echo "y" | salt-key -D
rm -rf  /var/run/skyring.pid /var/run/.skyring-event
\rm -r /var/log/skyring/*.log
rm -rf /etc/salt/pki/master/*

