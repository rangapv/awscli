#!/bin/bash

source <(curl -s https://raw.githubusercontent.com/rangapv/bash-source/main/s1.sh) >/dev/null 2>&1
tag1s=1
tag2s=1


awscli() {
awse1=`which aws`
awse1s="$?"
if [[ (( $awse1s -ne 0 )) ]]
then

awscli1=`curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" >/dev/null 2>&1`

awscli2=`sudo apt install unzip -y >/dev/null 2>&1`

awscli3=`unzip ./awscliv2.zip >/dev/null 2>&1`

awscli4=`sudo ./aws/install >/dev/null 2>&1`
fi

awsjq=`which jq`
awsjqs="$?"
if [[ (( $awsjqs -ne 0 )) ]]
then
`sudo $cm1 -y install jq >/dev/null 2>&1`
fi

}


cont() {
acid="$1"
secid="$2"
export AWS_ACCESS_KEY_ID=${acid}
export AWS_SECRET_ACCESS_KEY=${secid}
#sudo $cm1 -y install awscli >/dev/null 2>&1
awscli
}

hid() {

ecm=`which ec2-metadata`
ecms="$?"
if [[ (( $ecms -ne 0 )) ]]
then
wget http://s3.amazonaws.com/ec2metadata/ec2-metadata
chmod u+x ec2-metadata
`sudo mv ./ec2-metadata /usr/local/bin/`
fi
str23=`ec2-metadata -i`
str233=`ec2-metadata -z | awk '{split($0,a," "); print a[2]}' | sed 's/.$//'`
str231=`ec2-metadata -z | awk '{split($0,a," "); print a[2]}'`
str232=`echo $str23 | awk '{split($0,a," "); print a[2]}'`
#echo "region $str231"
#echo "id $str232"
#echo "str232 is $str233"

}

displaytag() {
tag1=`aws ec2 describe-tags --region $str233 | grep 'master' | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(a-z)]*\w*'`
tag1s="$?"

tag2=`aws ec2 describe-tags --region $str233 | grep 'worker' | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(a-z)]*\w*'` 
#tag2=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232"| grep 'worker' `
tag2s="$?"
#tag1=`aws ec2 describe-tags --region $str233 --filter "Name=resource-id,Values=$str232" --filter "key=Name" `
#echo "the tag is $tag1 and status is $tag1s"
#echo "the tag is $tag2 and status is $tag2s"
}

master() {

mc1=`mkdir simplek8s;cd simplek8s`
mc2=`git init; git pull https://github.com/rangapv/Simplek8s.git`
mc3=`./simpleccm.sh "$1" "$2"`
}


master_publicip() {

de=`aws ec2 describe-instances --region $str233`
#echo "$de"
de2=`aws ec2 describe-instances --region $str233 --filter "Name=tag:Name,Values=$tag1" | grep "PublicIpAddress" | awk '{split($0,a," "); print a[2]}'| grep -oh '\w*[(0-9\.)]*\w*'`
#echo "DE2 is $de2"
}




worker_scp() {

waldo=`chmod 400 /home/ubuntu/Aldo3.pem`
wmkdir=`mkdir /home/ubuntu/.kube/`
wscp=`scp -i /home/ubuntu/Aldo3.pem ubuntu@$de2:/home/ubuntu/.kube/config ./home/ubuntu/.kube/`

}

cont "$1" "$2"
hid
displaytag
master_publicip

