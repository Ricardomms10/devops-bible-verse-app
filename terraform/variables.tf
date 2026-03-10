variable "vpc_id" {
  description = "ID da VPC na AWS"
  type        = string
}

variable "ami_id" {
  description = "ID da AMI para a instância EC2"
  type        = string
}

variable "key_name" {
  description = "Nome do Key Pair SSH para acessar a instância EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t3.micro"
}
