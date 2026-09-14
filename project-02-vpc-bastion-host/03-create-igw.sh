#!/usr/bin/env bash
# ============================================
# 03-create-igw.sh
# Creates and attaches Internet Gateway to VPC
# IGW is the door between VPC and the internet
# Without it, nothing in the VPC can reach outside
# IGW ID: igw-0ef64b8f3f1637861
# ============================================

# Step 1: Create IGW
aws ec2 create-internet-gateway

# Step 2: Attach to VPC (buying a door vs installing it)
aws ec2 attach-internet-gateway --internet-gateway-id igw-0ef64b8f3f1637861 --vpc-id vpc-0c763a8fa021abdab

# Step 3: Tag it
aws ec2 create-tags --resources igw-0ef64b8f3f1637861 --tags Key=Name,Value=sagar-project2-igw

#VPC_ID=vpc-0c763a8fa021abdab
#IGW=igw-0ef64b8f3f1637861  

#PUBLIC_RT=rtb-0b473fbcd57b10311   
#PRIVATE_RT=rtb-0f3987e317742b82d