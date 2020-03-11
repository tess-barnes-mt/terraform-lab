#!/bin/bash

# already running as root so no sudo; 
# always make sure the -y flag is set so this can be run as user data!
yum -y update
yum -y install ruby

wget https://aws-codedeploy-eu-west-2.s3.eu-west-2.amazonaws.com/latest/install
chmod +x ./install
./install auto
service codedeploy-agent status