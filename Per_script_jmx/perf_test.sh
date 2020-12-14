#!/bin/sh

#here 200 is number is threads and 120 is rampup time. By default 100 thread will run if you dont mention 
user=1;
ssh -i Performance-test.pem ec2-user@15.207.18.211 ./perf_script.sh $user 1

sleep 1


echo "#Running Jmeter tests#"

echo " generate reports"

echo "removing old report file"
rm perfReports.jtl

scp -i Performance-test.pem ec2-user@15.207.18.211:/home/ec2-user/perfReports.jtl .

sleep 1

#rm -rf output/*
echo "Generate HTML reports"
#file =report-"`date +"%Y-%m-%d-%H-%M-%S"`"
jmeter -g perfReports.jtl -o output/report-$user-"`date +"%Y-%m-%d-%H-%M-%S"`"

