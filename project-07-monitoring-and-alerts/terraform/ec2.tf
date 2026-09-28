# --------------------------------------------------
# EC2: Project 7 Monitoring and Alerts
# Web server instance to monitor with CloudWatch
# AMI Data Source 2.EC2 3.ALB 4.APP in EC2
# --------------------------------------------------

# Data Look up for EC2
data "http" "my_ip" {
  url = "https://ifconfig.me/ip"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "main" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]


  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-web"
  })
}