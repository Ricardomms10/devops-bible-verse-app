resource "aws_instance" "devops_server" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  tags = {
    Name = "devops-bible-app"
  }
}