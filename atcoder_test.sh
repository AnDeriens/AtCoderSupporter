#! /bin/bash

executefile=$1
testdir=$2

inputdir="$testdir/in"
outputdir="$testdir/out"
inputfiles=$(ls $inputdir)

for testfilename in $inputfiles; do
    output=$(python3 $executefile < "$testdir/in/$testfilename")
    expected=$(cat "$outputdir/$testfilename")
    # echo $output
    # echo $expected
    if [ "$output" == "$expected" ]; then
        echo "True: $testfilename"
    else
        echo "False: $testfilename"
    fi
done

