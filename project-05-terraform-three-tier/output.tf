
# =============================================
# OUTPUTS.TF — What Terraform prints after apply
# =============================================
# After "terraform apply", these values print in your terminal
# Super useful — you don't have to dig through AWS Console to find them!

# =============================================
# VPC
# =============================================
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id # prints: vpc-0abc123...
}

# =============================================
# ALB
# =============================================
output "alb_dns_name" {
  description = "ALB DNS name — paste this in browser to see your app!"
  value       = aws_lb.main.dns_name # prints: project5-alb-123456.us-east-1.elb.amazonaws.com
}

# =============================================
# EC2 — Web Tier
# =============================================
output "web_1_public_ip" {
  description = "Public IP of Web Server 1"
  value       = aws_instance.web_1.public_ip # prints: 54.xx.xx.xx
}

output "web_2_public_ip" {
  description = "Public IP of Web Server 2"
  value       = aws_instance.web_2.public_ip
}

# =============================================
# RDS
# =============================================
output "rds_endpoint" {
  description = "RDS MySQL endpoint — use this to connect from app tier"
  value       = aws_db_instance.main.endpoint # prints: project5-db.abc123.us-east-1.rds.amazonaws.com:3306
}

