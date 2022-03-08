# terraform-demo
This script will provision the following on aws public cloud. 

## app
  - security group
  - ec2 launch config
  - application load balancer
  - auto scaling group with app health checker

## db
  - aws rds instance
  - create table and insert data

## s3
  - aws s3 bucket
  - create and upload files from uploads/ folder

## host machine setup
`yum install -y terraform mysql`  

## notes  
  - terraform.tfvar should have proper aws accesskey and db password
  - add the db connection name to app/userdata.sh from the output of db provisioning
