# =============================================
# RDS.TF — MySQL Database (Tier 3 — Most Protected!)
# =============================================
# We need 2 things to create an RDS database:
#   1. DB Subnet Group — tells RDS which subnets to use (must be private!)
#   2. RDS Instance    — the actual MySQL database
#
# Traffic flow: App EC2 (private) → port 3306 → RDS MySQL (private)
# =============================================
# 1. DB Subnet Group — tells RDS which private subnets to use
# =============================================
resource "aws_db_subnet_group" "main" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = [aws_subnet.private_1.id, aws_subnet.private_2.id]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

# =============================================
# 2. RDS MySQL Instance
# =============================================
resource "aws_db_instance" "main" {
  identifier             = "${var.project_name}-db"      # unique name for this DB in AWS
  engine                 = "mysql"                       # database engine: mysql, postgres, mariadb, etc.
  engine_version         = "8.0"                         # MySQL version
  instance_class         = "db.t3.micro"                 # smallest/cheapest instance — free tier eligible
  allocated_storage      = 20                            # storage in GB
  db_name                = "project5db"                  # name of the database created inside RDS
  username               = "admin"                       # master username
  password               = "project51234"                  # master password (we'll improve this later!)
  db_subnet_group_name   = aws_db_subnet_group.main.name # use our private subnet group from above
  vpc_security_group_ids = [aws_security_group.db_sg.id] # DB SG — allows 3306 from app tier only
  multi_az               = false                         # false = single AZ (saves cost for learning)
  publicly_accessible    = false                         # false = no internet access — only app tier can reach it
  skip_final_snapshot    = true                          # skip backup snapshot when we destroy — fine for learning

  tags = {
    Name = "${var.project_name}-db"
  }
}