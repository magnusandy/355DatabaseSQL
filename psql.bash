#!/bin/bash
export PGPASSWORD=qwertyhero
psql -U cmpt355_team01 -d cmpt355_team01 -h lovett.usask.ca
unset PGPASSWORD
