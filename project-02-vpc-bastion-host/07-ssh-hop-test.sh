#!/usr/bin/env bash
# ============================================
# 07-ssh-hop-test.sh
# SSH into bastion, then hop to private server
# ============================================

# Step 1: Copy key to bastion
scp -i sagar-project2-key.pem sagar-project2-key.pem ec2-user@BASTION_PUBLIC_IP:/home/ec2-user/

# Step 2: SSH into bastion
ssh -i sagar-project2-key.pem ec2-user@BASTION_PUBLIC_IP

# Step 3: From bastion, SSH into private server
chmod 400 sagar-project2-key.pem
ssh -i sagar-project2-key.pem ec2-user@PRIVATE_SERVER_IP
