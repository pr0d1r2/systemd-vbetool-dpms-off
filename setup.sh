#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

NAME="vbetool-dpms-off"
ON_CALENDAR="*-*-* 00:00:00"

command -v vbetool 1>/dev/null || apt-get install -y vbetool

cat "$NAME.timer" | sed -e "s|ON_CALENDAR|$ON_CALENDAR|g" > "/etc/systemd/system/$NAME.timer"
cp "$NAME.service" "/etc/systemd/system/$NAME.service"

systemctl daemon-reload

systemctl enable "$NAME.service"
systemctl enable "$NAME.timer"

systemctl start "$NAME.service"
