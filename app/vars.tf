# provider
variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "REGION" {
  default   = "eu-west-1"
}

# security group
variable "SG_EC2_NAME" {
  default   = "tud-ca1-ec2-sg"
}
variable "SG_LB_NAME" {
  default   = "tud-ca1-lb-sg"
}
variable "SG_PROTO" {
  type      = map(string)
  default   = {
      TCP     = "TCP"
      HTTP    = "HTTP"
      ANY     = "-1"
  }
}
variable "SG_CIDR" {
  default   = "0.0.0.0/0"
}
variable "SG_PORTS" {
  type      = map(number)
  default   = {
    SSH       = 22
    HTTP      = 80
    APP       = 5000
    ANY       = 0
  }
}

# load balancer
variable "ALB_NAME" {
  default   = "tud-ca1-alb"
}
variable "ALB_TYPE" {
  default   = "application"
}
variable "ALB_MODE" {
  default   = false
}
variable "ALB_LISTENER_ACTION" {
  default   = "forward"
}
variable "ALB_TG_NAME" {
  default   = "tud-ca1-tg"
}
variable "ALB_TG_HC_PATH" {
  default   = "/pythonlogin"
}
variable "ALB_TG_HC_LIMIT" {
  default   = 4
}
variable "ALB_TG_HC_CODE" {
  default   = "200-308"
}
variable "ALB_TG_HC_INTERVAL" {
  default   = 10
}

# auto scaling group
variable "ASG_NAME"{
  default   = "tud-ca1-asg"
}
variable "ASG_HC_TYPE" {
  default   = "ELB"
}
variable "ASG_TAG_KEY" {
  default   = "Name"
}
variable "ASG_TAG_VALUE" {
  default   = "tud-ca1-asg-ec2"
}
variable "ASG_TAG_PROGATE" {
  default   = true
}
variable "ASG_HC_GRACE_TIME" {
  default   = "400"
}
variable "ASG_CAPACITY" {
  default   = 1
}

# instance
variable "INS_AMI" {
  type      = map(string)
  default   = {
    eu-west-1 = "ami-07d8796a2b0f8d29c"
    eu-west-2 = "ami-0f9124f7452cdb2a6"
  }
}
variable "INS_TYPE" {
  default   = "t2.micro"
}
variable "INS_GET_PUB_IP" {
  default     = true
}

# misc
variable "TAGS" {
  default   = "tud-ca1-demo"
}
variable "KEY_NAME" {
  default   = "aws-rsa"
}
