#!/bin/bash
#This script needs to be run with ./aws-tag.sh access_ket secret_key

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >/dev/null 2>&1
tag1s=1
tag2s=1

cont() {
acid="$1"
secid="$2"
export AWS_ACCESS_KEY_ID=${acid}
export AWS_SECRET_ACCESS_KEY=${secid}
sudo $cm1 -y install awscli >/dev/null 2>&1
sudo $cm1 -y install jq >/dev/null 2>&1
}

hid() {
wget http://s3.amazonaws.com/ec2metadata/ec2-metadata
chmod u+x ec2-metadata
str23=`./ec2-metadata -i`
str233=`./ec2-metadata -z | awk '{split($0,a," "); print a[2]}' | sed 's/.$//'`
str231=`./ec2-metadata -z | awk '{split($0,a," "); print a[2]}'`
str232=`echo $str23 | awk '{split($0,a," "); print a[2]}'`
#echo "region $str231"
#echo "id $str232"
#echo "str232 is $str233"
}

displaytag() {
tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232"| grep 'master' `
tag1s="$?"
tag2=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232"| grep 'worker' `
tag2s="$?"
#tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232" --filter "key=Name" `
#echo "the tag is $tag1 and status is $tag1s"
}




if [[ (( "$#" -eq 0 )) ]]
then
	echo "THis file needs to be run with 2 command line params accesy_key secret_key"
	exit
fi

cont "$1" "$2"
hid
displaytag

if [[ (( $tag1s -eq 0 )) ]]
then
	echo "This is the Master, Install K8s master components"
 
elif [[ (( $tag2s -eq 0 )) ]]
then
	echo "This is the WOrker, Install k8s worker components"
else
	echo "Could not determine Master or Node so no k8s components are installed ..exiting k8s install"
fi

