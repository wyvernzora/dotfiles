#!/usr/bin/env bash
#
# provision/start.sh
#
# @author  Denis Luchkin-Zhou <wyvernzora@gmail.com>
# @license MIT
#


#
# Get rid of CDPATH, then make sure we are in the provisioning root
#
unset CDPATH
cd "$( dirname $(dirname "${BASH_SOURCE[0]}") )"


#
# Global configuration
#
BB_LOG_USE_COLOR=true
BB_WORKSPACE='.bb-workspace'
BB_LOG_FORMAT='[${LEVEL}] ${MESSAGE}'


#
# Boolean values
#
TRUE=0
FALSE=1


#
# Load bash booster
#
source provision/bb.sh


#
# Load utilities
#
for util in provision/util/*.sh; do
  source $util
done


#
# Load all tasks
#
for task in provision/tasks/*.sh; do
  source $task
done


#
# Hello World
#
bb-log-info "Hello World"


#
# Start the task
#
bb-task-run 't-bootstrap' 't-symlink'
