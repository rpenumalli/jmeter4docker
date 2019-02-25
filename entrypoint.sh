#!/bin/bash
# Runs jmeter, assuming the PATH is set to point to JMeter bin-dir (see Dockerfile)
# This script expects the standdard JMeter command parameters.
set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"

echo "START Running Jmeter on `date`"
echo "JVM_ARGS=${JVM_ARGS}"
echo "jmeter args=$@"

# Entrypoint will pass the standard JMeter arguments
jmeter $@
echo "END Running Jmeter on `date`"