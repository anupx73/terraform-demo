# ITInfra CA1 by x00193210 (Anupam Saha)
# This script will provision the following on aws public cloud:
#   - security group
#   - ec2 launch template
#   - application load balancer
#   - auto scaling group with app health checker

# define security groups
resource "aws_security_group" "sg_ec2" {
  name                              = var.SG_EC2_NAME
  ingress {
    protocol                        = var.SG_PROTO["TCP"]
    cidr_blocks                     = [var.SG_CIDR]
    from_port                       = var.SG_PORTS["SSH"]
    to_port                         = var.SG_PORTS["SSH"]
  }
  ingress {
    protocol                        = var.SG_PROTO["TCP"]
    cidr_blocks                     = [var.SG_CIDR]
    from_port                       = var.SG_PORTS["APP"]
    to_port                         = var.SG_PORTS["APP"]
  }
  egress {
    protocol                        = var.SG_PROTO["ANY"]
    cidr_blocks                     = [var.SG_CIDR]
    from_port                       = var.SG_PORTS["ANY"]
    to_port                         = var.SG_PORTS["ANY"]
  }
}

resource "aws_security_group" "sg_lb" {
  name                              = var.SG_LB_NAME
  ingress {
    protocol                        = var.SG_PROTO["TCP"]
    cidr_blocks                     = [var.SG_CIDR]
    from_port                       = var.SG_PORTS["HTTP"]
    to_port                         = var.SG_PORTS["HTTP"]
  }
  egress {
    protocol                        = var.SG_PROTO["ANY"]
    cidr_blocks                     = [var.SG_CIDR]
    from_port                       = var.SG_PORTS["ANY"]
    to_port                         = var.SG_PORTS["ANY"]
  }
}

# define ec2 launch template
resource "aws_launch_template" "this" {
  name                              = var.EC2_LT_NAME
  image_id                          = lookup(var.INS_AMI, var.REGION)
  instance_type                     = var.INS_TYPE
  key_name                          = var.KEY_NAME
  security_group_names              = [aws_security_group.sg_ec2.name]
  user_data                         = filebase64("userdata.sh")
}

# define application load balancer
resource "aws_lb" "this" {
  name                              = var.ALB_NAME
  internal                          = var.ALB_MODE
  load_balancer_type                = var.ALB_TYPE
  security_groups                   = [aws_security_group.sg_lb.id]
  subnets                           = data.aws_subnets.default.ids
}

resource "aws_lb_listener" "this" {
  load_balancer_arn                 = aws_lb.this.arn
  protocol                          = var.SG_PROTO["HTTP"]
  port                              = var.SG_PORTS["HTTP"]
  default_action {
    type                            = var.ALB_LISTENER_ACTION
    target_group_arn                = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group" "this" {
  name                              = var.ALB_TG_NAME
  protocol                          = var.SG_PROTO["HTTP"]
  port                              = var.SG_PORTS["APP"]
  vpc_id                            = data.aws_vpc.default.id
  health_check  {
    path                            = var.ALB_TG_HC_PATH
    protocol                        = var.SG_PROTO["HTTP"]
    port                            = var.SG_PORTS["APP"]
    healthy_threshold               = var.ALB_TG_HC_LIMIT
    unhealthy_threshold             = var.ALB_TG_HC_LIMIT - 2
    interval                        = var.ALB_TG_HC_INTERVAL
    matcher                         = var.ALB_TG_HC_CODE
  }
}

# define autoscaling group
resource "aws_autoscaling_group" "this" {
  name                              = var.ASG_NAME
  availability_zones                = data.aws_availability_zones.available.names
  desired_capacity                  = var.ASG_CAPACITY
  min_size                          = var.ASG_CAPACITY
  max_size                          = var.ASG_CAPACITY + 2
  health_check_grace_period         = var.ASG_HC_GRACE_TIME
  health_check_type                 = var.ASG_HC_TYPE
  target_group_arns                 = [aws_lb_target_group.this.arn]
  launch_template {
    id                              = aws_launch_template.this.id
    version                         = var.LAUNCH_TEMPLATE_VER
  }
  tag {
    key                             = var.ASG_TAG_KEY
    value                           = var.ASG_TAG_VALUE
    propagate_at_launch             = var.ASG_TAG_PROGATE
  }
}
