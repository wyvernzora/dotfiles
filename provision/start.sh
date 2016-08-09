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
ROOT="$( dirname $(dirname "${BASH_SOURCE[0]}") )"
cd "${ROOT}"


#
# Global configuration
#
BB_LOG_LEVEL=1
BB_LOG_USE_COLOR=true
BB_WORKSPACE='.bb-workspace'


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
bb-log-debug 'Debug'
bb-log-info "Hello World"
bb-log-warning "Warning"
bb-log-error "Error"


#
# Start the task
#
bb-task-run 't-bootstrap' 't-symlink'
