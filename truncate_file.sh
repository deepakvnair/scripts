#!/bin/bash
#Script to check the size of log file and truncate it if its size is greater than 20G,maxsize is defined in bytes
FILENAME=/var/log/testfile
LOGFILE=/var/log/truncate.log
#MAXSIZE=21474836480
MAXSIZE=5368709120
FILESIZE=$(stat -c%s "$FILENAME")
echo "Size of $FILENAME = $FILESIZE bytes"
if ((FILESIZE > MAXSIZE)); then
echo "$(uname -n) :$(date +"%m-%d-%Y %T") :$FILENAME Size is larger than 5GB truncating...... " >> $LOGFILE
cat /dev/null > /var/log/testfile
retval=$?
if [ $retval -eq 0 ]; then
echo "Truncated the file, current /var Filesystem Size : $(du -sh /var |awk '{print $1}')" >> $LOGFILE
mail -s "Logfile size Truncate invoked" deepakv.nair@gmail.com < $LOGFILE
cat /dev/null > $LOGFILE
fi
fi
