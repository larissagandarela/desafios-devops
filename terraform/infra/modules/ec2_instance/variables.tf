variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "security_group_id" {
  description = "Security Group"
  type        = string
}

variable "name" {
  description = "Name for the instance"
  type        = string
}


