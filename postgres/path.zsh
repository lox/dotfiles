#!/bin/sh

if [ -e "/Applications/Postgres.app" ]; then
	export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"
fi
