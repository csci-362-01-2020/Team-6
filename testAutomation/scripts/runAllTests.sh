#!/bin/bash
findDriver() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Case[[:space:]]Driver ]]; then
            caseDriver=${line:17}       
            echo $caseDriver
        fi
    done
}

findValue() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Data ]]; then 
            caseData=${line:10}
            echo $caseData
        fi
    done
}


numFiles=$(ls ../testCases | wc -l)
list=$(find ../project -name 'ThreadSafeCircularFifoQueue.java')
filePath=${list[0]}
baseDirectory="../testCasesExecutables"
cp $filePath $baseDirectory
sed -i "s/package org.openmrs.util//" $baseDirectory/ThreadSafeCircularFifoQueue.java
touch ../temp/out.html

for (( i = 1 ; i <= $numFiles ; i++)); do

    unset driver
    unset driver
    unset driverNoExt
    unset data


    #echo "testCase"$i".txt"
    testDriver=$(find ../testCases -name 'testCase'$i'.txt')
    driver=$(findDriver $testDriver)
    driver=$(basename $driver)
    driver=${driver%$'\r'}

    echo $driver

    driverNoExt=${driver%.*}

    data=$(findValue $testDriver)

    cd $baseDirectory
    javac ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $driver -d $baseDirectory -cp $baseDirectory

    echo "Test "$i":" >> ../temp/out.html
    java $driverNoExt $data >> ../temp/out.html
    rm *.class

done

rm ThreadSafeCircularFifoQueue.java
#rm ../temp/out.html
