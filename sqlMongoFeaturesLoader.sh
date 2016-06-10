#!/usr/bin/env bash
# Get all files from current directory and pass
# them as arguments to the mysql insert script

ff_list=`ls $1`
echo $ff_list;
for ff in $1;
do
    python toMySql_1.py "$ff"
done
