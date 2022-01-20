variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
 default ="eu-west-1"
}
variable "AMIS"{
 type=map
 default={
  eu-west-1="ami-0531922bc56dc0d2f"

  }
 
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
  
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}



variable "INSTANCE_USERNAME" {
  default="terraform"
}

variable "INSTANCE_PASSWORD" {}

