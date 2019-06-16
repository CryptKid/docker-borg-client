#!/bin/bash
out() {
	echo "$@"
	logger "$@"
	out "creating backup"
}
BORG_PASSPHRASE="$borg_password"
if [ -z "$TERM" ]; then
        borg create -v --stats --compression lz4 $borg_repo::$(date +$borg_date_prefix:%Y-%m-%d-%H-%M-%S) $borg_path
else
        borg create -v -p --stats --compression lz4 $borg_repo::$(date +$borg_date_prefix:%Y-%m-%d-%H-%M-%S) $borg_path
fi


