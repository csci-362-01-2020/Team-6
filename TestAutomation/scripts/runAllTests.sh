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

getID() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Case[[:space:]]ID ]]; then
            idNum=${line:14}
            echo $idNum
        fi
    done
}

getMethod() {
    cat $testDriver | while read line; do
        if [[ $line =~ Method ]]; then
            methodTest=${line:21}
            echo $methodTest
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
    fileTest=$driver
    #echo $driver
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
    #expected=$(basename $expected)
    expected=${expected%$'\r'}
    ########################################
    idNum=$(getID $testDriver)
    methodTest=$(getMethod $testDriver)
    
    #output to command prompt window
    #echo $testDriver
    #echo $driver
    #echo input value = $data
    echo expected result = $expected
    echo $idNum

    cd $baseDirectory
    javac ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $driver -d $baseDirectory -cp $baseDirectory
    echo "<b>Date and Time Test Ran:</b> "$(date '+%d/%m/%Y %H:%M:%S')" EST<br>" >> ../temp/out.html
    echo "<b>Test Case ID:</b> "$idNum"<br>" >> ../temp/out.html
    echo "<b>File Being Tested:</b> "$filePath"<br>" >> ../temp/out.html
    echo "<b>Method Being Tested:</b> "$methodTest"<br>" >> ../temp/out.html
    echo "<b>Test Arguments:</b> "$data"<br>" >> ../temp/out.html
    expected=$(echo $expected | tr -dc '[:print:]\n\r')
    echo "<b>Expected Result:</b> "$expected"<br>" >> ../temp/out.html


    #get result of test case
    actualTestResult=$(java $driverNoExt $data)
    ###########################################
    #gets rid of carriage return
    #actualTestResult=$(basename $actualTestResult)
    actualTestResult=${actualTestResult%$'\r'}
    ###########################################

    actualTestResult=$(echo $actualTestResult | tr -dc '[:print:]\r\n')
    echo "<b>Test Result</b>: "$actualTestResult"<br>" >> ../temp/out.html
    echo test result = $actualTestResult
    #echo ""
    #echo ""


    echo $actualTestResult | hexdump -C
    echo $expected | hexdump -C
    
    #compare expected result and actual result of the test
    echo $actualTestResult
    echo $expected
    if [[ $actualTestResult =~ $expected ]]; then
    	echo "Test case <span style=\"color:#00FF00\";> PASSED. </span>" >> ../temp/out.html
    else
    	echo "Test case <span style=\"color:#FF0000\";> FAILED. </span> Result of the test is not the expected result." >> ../temp/out.html
    fi
    echo "<br><br>" >> ../temp/out.html
    
    rm *.class

done
echo "</p>" >> ../temp/out.html
xdg-open ../temp/out.html
rm ThreadSafeCircularFifoQueue.java
#rm ../temp/out.html
