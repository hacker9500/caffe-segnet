#!/bin/bash
# Usage parselog.sh caffe.log 
# It creates two files one caffe.log.test that contains the loss and test accuracy of the test and
# another one caffe.log.loss that contains the loss computed during the training

if [ "$#" -lt 1 ]
then
echo "Usage parselog.sh /path_to/caffe.log"
fi
if [ "$#" -gt 1 ]
then
 INIT=$2
else
 INIT=0
fi
if [ "$#" -gt 2 ]
then
 INC=$3
else
 INC=1000
fi
LOG=`basename $1`
grep -B 2 'Test ' $1 > aux.txt
grep 'Iteration ' aux.txt | awk -F ',| ' '{print $7}' > aux0.txt
grep 'Test score #0' aux.txt | awk '{print $8}' > aux1.txt
grep 'Test score #1' aux.txt | awk '{print $8}' > aux2.txt
grep ' loss =' $1 | awk '{print $6,$9}' | sed 's/,//g' | column -t > $LOG.loss 
paste aux0.txt aux1.txt aux2.txt | column -t > $LOG.test
rm aux0.txt aux1.txt aux2.txt