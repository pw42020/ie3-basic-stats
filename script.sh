#!/bin/bash
ant clean
ant compile
ant test 2> temp.txt
OUTPUT="$(grep -c 'Test [A-Za-z0-9]* FAILED' temp.txt)"
rm temp.txt
exit $OUTPUT