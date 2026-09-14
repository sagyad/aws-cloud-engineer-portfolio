#!/usr/bin/env bash
# ============================================
# 01-create-vpc.sh
# Creates a VPC — our private network in AWS
# CIDR: [IP_ADDRESS] (65,536 IPs)
# VPC ID: vpc-0c763a8fa021abdab
# ============================================

# Step 1: Create VPC
aws ec2 create-vpc --cidr-block [IP_ADDRESS] --region eu-west-2 --query 'Vpc.VpcId' --output text

# Step 2: Tag it
aws ec2 create-tags --resources vpc-0c763a8fa021abdab --tags Key=Name,Value=sagar-project2-vpc

# Step 3: Enable DNS hostnames (needed for EC2 DNS names)
aws ec2 modify-vpc-attribute --vpc-id vpc-0c763a8fa021abdab --enable-dns-hostnames '{"Value": true}'

#VPC_ID=vpc-0c763a8fa021abdab