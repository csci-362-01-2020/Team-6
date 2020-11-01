#!/bin/bash
findDriver() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Case[[:space:]]Driver ]]; then
            CASEDRIVER=${line:17}       
            echo $CASEDRIVER
        fi
    done
}

findValue() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Data ]]; then 
            CASEDATA=${line:10}
            echo $CASEDATA
        fi
    done
}

list=$(find ../project -name 'ThreadSafeCircularFifoQueue.java')
FILEPATH=${list[0]}

baseDirectory="../testCasesExecutables"

cp $FILEPATH $baseDirectory

testDriver=$(find ../testCases -name 'testCase1.txt')
DRIVER=$(findDriver $testDriver)
DRIVERNOEXT=${DRIVER:24:(-5)}

DATA=$(findValue $testDriver)

sed -i "s/package org.openmrs.util//" $baseDirectory/ThreadSafeCircularFifoQueue.java

javac $baseDirectory/ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $DRIVER -d $baseDirectory -cp $baseDirectory
cd $baseDirectory

touch ../temp/out.html
java $DRIVERNOEXT $DATA > ../temp/out.html

rm $baseDirectory/ThreadSafeCircularFifoQueue.java
rm $baseDirectory/*.class
rm ../temp/out.html
