#! /bin/bash
export PATH=/sbin:/usr/sbin:/bin:/usr/bin:/opt/bbs/bin

[ -z "$LOG" ] && export LOG=/opt/bbs/spool/webbuild.log

# ************
# *  Debug 
# ************
debug()
{
 echo "*** Starting Debug Shell [${FUNCNAME[1]}] line ${BASH_LINENO[0]} ***"
 set > /tmp/debug_vars
 /bin/sh
}

# ******************************
# * Message to log and console
# ******************************
msg() {
    echo "** - ${1}" 
}

# *******************
# * Report warning 
# *******************
warn() {
    echo "*** WARNING - ${1}" 
}

# *****************************
# * Report Error but continue 
# *****************************
err() {
    echo "**** ERROR - ${1}" 
    sleep 5
}