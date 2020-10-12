#!/bin/bash

set -ue

function usage {
    cat <<EOF
Usage: atcoder_test test [options] <file> <testcase directory>
Options:
  -h  This help

Arguments:
  <file>      Execute <file>
  <directory> Directory Path you put input/output case files. In the directory, need to set 'in' and 'out' directory.
EOF
}


function main()
{
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
}

if [ $# -lt 1 ]; then
    echo "[Error] subcommand required"
    exit 1
fi

case $1 in
    "-h")
        usage
    ;;

    test)
        if [ $# -lt 3 ]; then
            echo "[Error] two arguments required"
            exit 1
        fi
        main $2 $3
    ;;

    *)
        echo $1
        echo "[Error] subcommand not found"
    ;;
esac
