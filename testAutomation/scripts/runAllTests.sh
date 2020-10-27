#!/bin/bash

list=$(find ../project -name 'ThreadSafeCircularFifoQueue.java')
FILEPATH=${list[0]}

baseDirectory="../testCasesExecutables"

cp $FILEPATH $baseDirectory

sed -i "s/package org.openmrs.util//" $baseDirectory/ThreadSafeCircularFifoQueue.java

javac $baseDirectory/ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $baseDirectory/testCase1Driver.java -d $baseDirectory -cp $baseDirectory

cd $baseDirectory
java testCase1Driver

rm $baseDirectory/ThreadSafeCircularFifoQueue.java
rm $baseDirectory/*.class
