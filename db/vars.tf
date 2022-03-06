# provider
variable "ACCESS_KEY" {}
variable "SECRET_KEY" {}
variable "REGION" {
  default   = "eu-west-1"
}

# db connection
variable "DATABASE_NAME" {
  default = "pythonlogin"
}
variable "DATABASE_USER" {
  default = "root"
}
variable "DATABASE_PASSWORD" {}

# db server
variable "RDS_SG_NAME" {
  default = "tud-ca1-db-sg"
}
variable "RDS_SG_DESC" {
  default = "SQL DB Security Grp"
}
variable "RDS_INSTANCE_IDENTIFIER" {
  default = "tud-ca1-rds"
}
variable "RDS_SG_PROTO" {
  default   = "tcp"
}
variable "RDS_SG_CIDR" {
  default   = "0.0.0.0/0"
}
variable "RDS_SG_PORT" {
  default   = 3306
}
variable "RDS_ENGINE" {
  default =  "mysql"
}
variable "RDS_ENGINE_VER"{
  default = "8.0.27"
}
variable "RDS_INS_TYPE" {
  default = "db.t2.micro"
}
variable "RDS_STORAGE" {
  default = 20
}
variable "RDS_OPTIONS" {
  default = true
}
