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

#retrieves expected result of the test case from the test case file
getExpectedResult(){
	#search for line in test case file that begins with "Expected 	Result" to get the expected result value
	cat $testDriver | while read line; do
		if [[ $line =~ Expected[[:space:]]Result ]]; then
			#gets string from position 16 to the end of line
			expectedResult=${line:16} 
			echo $expectedResult
		fi
	done
}


git submodule update --init --recursive
cd ./scripts

if [[ -e ../temp/out.html ]]; then
	rm ../temp/out.html
fi

numFiles=$(ls ../testCases | wc -l)
list=$(find ../project -name 'ThreadSafeCircularFifoQueue.java')
filePath=${list[0]}
baseDirectory="../testCasesExecutables"

cp $filePath $baseDirectory
sed -i "s/package org.openmrs.util//" $baseDirectory/ThreadSafeCircularFifoQueue.java
touch ../temp/out.html
echo "<p>" >> ../temp/out.html


#loop through test case files
for (( i = 1 ; i <= $numFiles ; i++)); do

    unset driver
    unset driver
    unset driverNoExt
    unset data


    #echo "testCase"$i".txt"
    testDriver=$(find ../testCases -name 'testCase'$i'.txt')
    driver=$(findDriver $testDriver)
    driver=$(basename $driver)
    #strips the carriage return
    driver=${driver%$'\r'}


    driverNoExt=${driver%.*}

    #get value passed into driver
    data=$(findValue $testDriver)
    #get expected result for test case
    expected=$(getExpectedResult $testDriver)
    ########################################
    #gets rid of carriage return
    expected=$(basename $expected)
    expected=${expected%$'\r'}
    ########################################
    
    #output to command prompt window
    echo $testDriver
    echo $driver
    echo input value = $data
    echo expected result = $expected

    cd $baseDirectory
    javac ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $driver -d $baseDirectory -cp $baseDirectory
    echo "<b>Test "$i":</b>" >> ../temp/out.html

    #get result of test case
    actualTestResult=$(java $driverNoExt $data)
    ###########################################
    #gets rid of carriage return
    actualTestResult=$(basename $actualTestResult)
    actualTestResult=${actualTestResult%$'\r'}
    ###########################################
    echo Test Result: $actualTestResult. >> ../temp/out.html
    echo test result = $actualTestResult
    echo ""
    echo ""
    
    
    #compare expected result and actual result of the test
    if [[ $actualTestResult =~ $expected ]]; then
    	echo "Test case <span style=\"color:#00FF00\";> PASSED. </span>" >> ../temp/out.html
    else
    	echo "Test case <span style=\"color:#FF0000\";> FAILED. </span> Result of the test is not the expected result." >> ../temp/out.html
    fi
    echo "<br>" >> ../temp/out.html
    
    rm *.class

done
echo "</p>" >> ../temp/out.html
xdg-open ../temp/out.html
rm ThreadSafeCircularFifoQueue.java
#rm ../temp/out.html
