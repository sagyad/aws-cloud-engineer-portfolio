#!/usr/bin/env bash
# ============================================
# 06-launch-instances.sh
# Bastion: public subnet, public IP
# Private: private subnet, no public IP
# ============================================

# Get latest Amazon Linux 2023 AMI
aws ec2 describe-images --owners amazon --filters "Name=name,Values=al2023-ami-2023*-x86_64" "Name=state,Values=available" --query "Images | sort_by(@, &CreationDate) | [-1].ImageId" --output text

# Launch Bastion (public subnet + public IP)
aws ec2 run-instances --image-id ami-0f9629c639a701fa7 --instance-type t3.micro --key-name sagar-project2-key --subnet-id subnet-06f360db6792e1045 --security-group-ids sg-0176b81cf3d542fff --associate-public-ip-address

# Launch Private Server (private subnet, NO public IP)
aws ec2 run-instances --image-id ami-0f9629c639a701fa7 --instance-type t3.micro --key-name sagar-project2-key --subnet-id subnet-06367c99d23a5f2ce --security-group-ids sg-08a022f3ff4323a0b
