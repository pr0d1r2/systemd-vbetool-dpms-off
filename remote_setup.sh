#!/usr/bin/env bash

set -e -x

cd "$(dirname "$0")"

NAME="vbetool-dpms-off"

TARGET="$1"
test -n "$1"

case $TARGET in
  *@*)
    ;;
  *)
    TARGET="root@$TARGET"
    ;;
esac

TMP_DIR="$(ssh "$TARGET" "mktemp -d")"

parallel -v "rsync -av {} '$TARGET:$TMP_DIR/'" ::: "$NAME.service" "$NAME.timer" "setup.sh"

ssh "$TARGET" "$TMP_DIR/setup.sh"

ssh "$TARGET" "rm -rf $TMP_DIR"
