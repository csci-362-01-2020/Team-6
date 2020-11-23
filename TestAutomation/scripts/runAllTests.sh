#!/bin/bash

#Utility Methods

#Finds the test case driver from the text file given
findDriver() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Case[[:space:]]Driver ]]; then
            caseDriver=${line:17}       
            echo $caseDriver
        fi
    done
}

#Finds the Test Data to pass into the test case
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

#Gets the Test Case ID from the given text file
getID() {
    cat $testDriver | while read line; do
        if [[ $line =~ Test[[:space:]]Case[[:space:]]ID ]]; then
            idNum=${line:14}
            echo $idNum
        fi
    done
}

#Gets the test method from the given text file
getMethod() {
    cat $testDriver | while read line; do
        if [[ $line =~ Method ]]; then
            methodTest=${line:21}
            echo $methodTest
        fi
    done
}

#Retrieving submodule
git submodule update --init --recursive
cd ./scripts

#Cleaning any prior runs
if [[ -e ../temp/out.html ]]; then
	rm ../temp/out.html
fi

#Getting the number of files and finding the file to copy over
numFiles=$(ls ../testCases | wc -l)
list=$(find ../project -name 'ThreadSafeCircularFifoQueue.java')
filePath=${list[0]}
baseDirectory="../testCasesExecutables"

#Copying the file into the necessary directory and commenting out package declaration
cp $filePath $baseDirectory
sed -i "s/package org.openmrs.util//" $baseDirectory/ThreadSafeCircularFifoQueue.java

#Creating the output file
touch ../temp/out.html
echo "<p>" >> ../temp/out.html


#loop through test case files
for (( i = 1 ; i <= $numFiles ; i++)); do

    #Resetting data from previous runs
    unset driver
    unset driver
    unset driverNoExt
    unset data

    testDriver=$(find ../testCases -name 'testCase'$i'.txt')
    driver=$(findDriver $testDriver)
    fileTest=$driver
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
    expected=${expected%$'\r'}
    ########################################
    idNum=$(getID $testDriver)
    methodTest=$(getMethod $testDriver)

    cd $baseDirectory
    javac ThreadSafeCircularFifoQueue.java -d $baseDirectory && javac $driver -d $baseDirectory -cp $baseDirectory
    
    #Outputting Template for HTML file
    echo "<b>Date and Time Test Ran:</b> "$(date '+%d/%m/%Y %H:%M:%S')" EST<br>" >> ../temp/out.html
    echo "<b>Test Case ID:</b> "$idNum"<br>" >> ../temp/out.html
    echo "<b>File Being Tested:</b> "$filePath"<br>" >> ../temp/out.html
    echo "<b>Method Being Tested:</b> "$methodTest"<br>" >> ../temp/out.html
    echo "<b>Test Arguments:</b> "$data"<br>" >> ../temp/out.html
    
    #Stripping whitespace from expected and outputting to file
    expected=$(echo -e "${expected}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    expected=$(echo -e "${expected}" | sed 's/\xc2\xa0/ /g')
    echo "<b>Expected Result:</b> "$expected"<br>" >> ../temp/out.html


    #get result of test case
    actualTestResult=$(java $driverNoExt $data)
    ###########################################
    #gets rid of carriage return
    actualTestResult=${actualTestResult%$'\r'}
    ###########################################

    #Stripping any whitespace from beginning and end of result
    actualTestResult=$(echo -e ${actualTestResult} | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    actualTestResult=$(echo -e ${actualTestResult} | sed 's/\xc2\xa0/ /g')
    echo "<b>Test Result</b>: "$actualTestResult"<br>" >> ../temp/out.html

    
    #compare expected result and actual result of the test
    if [[ $actualTestResult =~ "$expected" ]]; then
    	echo "Test case <span style=\"color:#00FF00\";> PASSED. </span>" >> ../temp/out.html
    else
    	echo "Test case <span style=\"color:#FF0000\";> FAILED. </span> Result of the test is not the expected result." >> ../temp/out.html
    fi
    echo "<br><br>" >> ../temp/out.html
    
    rm *.class

done

#Ending the paragraph body and opening the file and removing the copied file
echo "</p>" >> ../temp/out.html
xdg-open ../temp/out.html
rm ThreadSafeCircularFifoQueue.java

