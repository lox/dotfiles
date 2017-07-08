#!/bin/sh
if [ -e "/Applications/Postgres.app" ]; then
	export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/9.6/bin/"
fi
