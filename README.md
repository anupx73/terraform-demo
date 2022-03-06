# terraform-demo
This script will provision the following on aws public cloud. 

## app
  - security group
  - ec2 launch config
  - application load balancer
  - auto scaling group with app health checker
  - [pending] s3 bucket to store user data uploaded from app
  - [pending] create waf and waf rules to secure app

## db
  - aws rds instance
  - create table and insert data

## host machine setup
`yum install -y terraform mysql`  

**Note: terraform.tfvar should have proper aws accesskey and db password**
