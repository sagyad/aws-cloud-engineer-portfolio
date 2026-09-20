# =============================================
# EC2.TF — Web and App Tier Instances
# =============================================
# We need 4 things here:
#   1. AMI data source — to find the latest Amazon Linux 2 image
#   2. Web EC2 instances — 2 servers in public subnets (behind ALB)
#   3. ALB target group attachment — register web EC2s to the ALB target group
#   4. App EC2 instances — 2 servers in private subnets (behind web tier)
#
# Traffic flow: ALB → Web EC2 (public) → App EC2 (private) → RDS (private)
# =============================================
# 1. AMI — Find latest Amazon Linux 2 image
# =============================================
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# =============================================
# 2. Web Tier — EC2 instances in public subnets
# =============================================
# These sit behind the ALB and serve web content (Nginx/Apache)
resource "aws_instance" "web_1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Web Server 1 — AZ-a</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-web-1"
  }
}

resource "aws_instance" "web_2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public_2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Web Server 2 — AZ-b</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-web-2"
  }
}

# =============================================
# 3. Register Web EC2s to ALB Target Group
# =============================================
resource "aws_lb_target_group_attachment" "web_1" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_2" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web_2.id
  port             = 80
}

# =============================================
# 4. App Tier — EC2 instances in private subnets
# =============================================
resource "aws_instance" "app_1" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "${var.project_name}-app-1"
  }
}

resource "aws_instance" "app_2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.private_2.id # PRIVATE subnet AZ-b
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  tags = {
    Name = "${var.project_name}-app-2"
  }
}