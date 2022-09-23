#!/bin/bash

awk 'BEGIN{i = 0} {if($0 != "") i++; if(i != 0) {print $0}}' $1 > result_file
mv result_file $1
