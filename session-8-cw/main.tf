resource "aws_key_pair" "main" {
  key_name   = "terraform-local-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "main" {
  name        = "main"
  description = "this is a security group for ec2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "main" {
  depends_on = [ null_resource.main ]                   // Explicit Dependency
  ami           = data.aws_ami.amazon_linux_2023.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.main.id                  // Implicit Dependency
  tags = {
    Name        = "${var.env}-instance"
    Environment = var.env
  }
  vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "/Users/bektursunkudaibergenov/projects/terraform-session/session-8-cw/index.html"
    destination = "/tmp/index.html"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("~/.ssh/id_rsa")
  }


  provisioner "remote-exec" {
    inline = [
      "sudo dnf install httpd -y",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = self.public_ip
      private_key = file("~/.ssh/id_rsa")
    }
  }
}


resource "null_resource" "main" {
    provisioner "local-exec" {
      command = "echo  'testing local exec' > index.html" 
    }
}