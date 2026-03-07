resource "aws_security_group" "app_sg" {
  name = "devops-app-sg-v2"

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "devops_server" {
  ami           = "ami-053b0d53c279acc90"
  instance_type = "t3.micro"

  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install docker.io -y
              systemctl start docker
              systemctl enable docker

              docker pull ghcr.io/ricardomms10/devops-bible-verse-app/bible-app:latest

              docker run -d -p 3000:3000 ghcr.io/ricardomms10/devops-bible-verse-app/bible-app:latest
              EOF

  tags = {
    Name = "devops-bible-app"
  }
}