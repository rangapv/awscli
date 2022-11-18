#!/bin/bash
set -E

outlb () {
lb1=`$1`
out="$?"

	if [[ (( $out -eq 0 )) ]]
	then
		echo "$lb1"
	fi

}



echo "The list of Laod Balancers.."
l1="aws elbv2 describe-load-balancers --region=us-east-2"
outlb "${l1}"
