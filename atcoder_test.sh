#! /bin/bash

set -ue

executefile=$1
testdir=$2

inputdir="$testdir/in"
outputdir="$testdir/out"
inputfiles=$(ls $inputdir)

noProblem=0
noCorrect=0
noWrong=0

for testfilename in $inputfiles; do
    output=$(python3 $executefile < "$testdir/in/$testfilename")
    expected=$(cat "$outputdir/$testfilename")
    # echo $output
    # echo $expected
    noProblem=$((++noProblem))
    if [ "$output" == "$expected" ]; then
        echo "True: $testfilename"
        noCorrect=$((++noCorrect))
    else
        echo "False: $testfilename"
        noWrong=$((++noWrong))
    fi
done

echo "テスト数: $noProblem"
echo "正解: $noCorrect"
echo "間違い: $noWrong"

