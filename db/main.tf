# ITInfra CA1 by x00193210 (Anupam Saha)
# This script will provision the following on aws public cloud:
#   - aws rds instance
#   - create table and insert data

# define security group
resource "aws_security_group" "this" {
  name                      = var.RDS_SG_NAME
  description               = var.RDS_SG_DESC    
  ingress {         
    protocol                = var.RDS_SG_PROTO
    cidr_blocks             = [var.RDS_SG_CIDR]
    from_port               = var.RDS_SG_PORT
    to_port                 = var.RDS_SG_PORT
  }
}

# define db creation
resource "aws_db_instance" "this" {
  identifier                = var.RDS_INSTANCE_IDENTIFIER
  allocated_storage         = var.RDS_STORAGE
  engine                    = var.RDS_ENGINE
  engine_version            = var.RDS_ENGINE_VER
  instance_class            = var.RDS_INS_TYPE
  db_name                   = var.DATABASE_NAME
  username                  = var.DATABASE_USER
  password                  = var.DATABASE_PASSWORD
  vpc_security_group_ids    = [aws_security_group.this.id]
  skip_final_snapshot       = var.RDS_OPTIONS
  publicly_accessible       = var.RDS_OPTIONS
}

# define db table setup
resource "null_resource" "this" {
  depends_on                = [aws_db_instance.this]
  provisioner "local-exec" {
        command             = "mysql -u ${var.DATABASE_USER} -p${var.DATABASE_PASSWORD} -h ${aws_db_instance.this.address} < dbsetup.sql"
  }
}
