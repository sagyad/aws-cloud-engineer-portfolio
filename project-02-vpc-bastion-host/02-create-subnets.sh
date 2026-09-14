#!/usr/bin/env bash
# ============================================
# 02-create-subnets.sh
# Creates 4 subnets (2 public + 2 private)
# across 2 AZs for high availability
# VPC: vpc-0c763a8fa021abdab
# ============================================

# Public Subnet 1 — eu-west-2a
# subnet-06f360db6792e1045
aws ec2 create-subnet --vpc-id vpc-0c763a8fa021abdab --cidr-block 10.0.1.0/24 --availability-zone eu-west-2a

# Public Subnet 2 — eu-west-2b
# subnet-0fd30853f0e58ae19
aws ec2 create-subnet --vpc-id vpc-0c763a8fa021abdab --cidr-block 10.0.2.0/24 --availability-zone eu-west-2b

# Private Subnet 1 — eu-west-2a
# subnet-06367c99d23a5f2ce
aws ec2 create-subnet --vpc-id vpc-0c763a8fa021abdab --cidr-block 10.0.3.0/24 --availability-zone eu-west-2a

# Private Subnet 2 — eu-west-2b
# subnet-086fc20f5ccfda265
aws ec2 create-subnet --vpc-id vpc-0c763a8fa021abdab --cidr-block 10.0.4.0/24 --availability-zone eu-west-2b

aws ec2 create-tags --resources subnet-0fd30853f0e58ae19 --tags Key=Name,Value=sagar-public-subnet-1-2a
aws ec2 create-tags --resources subnet-06f360db6792e1045 --tags Key=Name,Vaue=sagar-public-subnet-2-2b
aws ec2 create-tags --resources subnet-06367c99d23a5f2ce --tags Key=Name,Value=sagar-private-subnet-1-2a
aws ec2 create-tags --resources subnet-086fc20f5ccfda265  --tags Key=Name,Value=sagar-private-subnet-2-2b

#VPC_ID=vpc-0c763a8fa021abdab
#IGW="igw-0ef64b8f3f1637861"  

#PUBLIC_RT=rtb-0b473fbcd57b10311   
#PRIVATE_RT=rtb-0f3987e317742b82d