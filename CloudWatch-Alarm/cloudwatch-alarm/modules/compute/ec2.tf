resource "aws_instance" "ec2_instance" {
  ami           = "ami-0c55b159cbfafe1f0" # Example AMI ID
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.service_name}-${var.env}-ec2"
  }
}

