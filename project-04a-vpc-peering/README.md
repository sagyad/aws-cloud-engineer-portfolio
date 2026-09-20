# Project 4a — VPC Peering 🔗

## Overview

Connected two VPCs using VPC Peering to enable private communication between resources across different VPCs — traffic stays on the AWS backbone and never touches the internet.

## Architecture
VPC-A ([IP_ADDRESS]) VPC-B (10.1.0.0/16) ┌──────────────────┐ ┌──────────────────┐ │ Public Subnet │ VPC Peering │ Public Subnet │ │ 10.0.x.x/24 │◄────(pcx-xxxxx)────────►│ 10.1.1.0/24 │ │ │ │ │ │ EC2 Instance │ Private connection │ EC2 Instance │ │ │ AWS backbone only │ │ └──────────────────┘ └──────────────────┘

Route Table A: Route Table B: 0.0.0.0/0 → IGW-A 0.0.0.0/0 → IGW-B 10.1.0.0/16 → pcx-xxxxx [IP_ADDRESS] → pcx-xxxxx


## Overview

Established a VPC Peering connection between two VPCs in the same region to enable private communication over the AWS backbone — no internet traversal required. Configured route tables and security groups in both VPCs to allow bidirectional traffic.

## AWS Services Used

- **VPC** — Two custom VPCs with non-overlapping CIDRs
- **VPC Peering** — Private connection between VPC-A and VPC-B
- **Route Tables** — Updated in both VPCs to route cross-VPC traffic via peering
- **Security Groups** — ICMP and SSH access between VPC CIDRs
- **EC2** — Instances in each VPC for connectivity verification
- **Internet Gateway** — Public internet access for both VPCs

## Implementation

### VPC-B Setup (VPC-A existed from Project 4)

```bash
aws ec2 create-vpc --cidr-block 10.1.0.0/16
aws ec2 create-subnet --vpc-id <vpc-b-id> --cidr-block 10.1.1.0/24 --availability-zone eu-west-2a
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --internet-gateway-id <igw-id> --vpc-id <vpc-b-id>
aws ec2 create-route --route-table-id <rtb-b> --destination-cidr-block 0.0.0.0/0 --gateway-id <igw-id>
Peering Connection
bash





# Create peering connection (VPC-A → VPC-B)
aws ec2 create-vpc-peering-connection --vpc-id <vpc-a-id> --peer-vpc-id <vpc-b-id>

# Accept peering request (required even within the same account)
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id <pcx-id>
Route Table Updates (both VPCs must be updated)
bash





# VPC-A: route VPC-B traffic through peering connection
aws ec2 create-route --route-table-id <rtb-a> --destination-cidr-block 10.1.0.0/16 --vpc-peering-connection-id <pcx-id>

# VPC-B: route VPC-A traffic through peering connection
aws ec2 create-route --route-table-id <rtb-b> --destination-cidr-block [IP_ADDRESS] --vpc-peering-connection-id <pcx-id>
Verification
bash





# Confirm peering status is "active"
aws ec2 describe-vpc-peering-connections \
  --query 'VpcPeeringConnections[].{ID:VpcPeeringConnectionId,Status:Status.Code}'

# SSH into VPC-A EC2 → ping VPC-B EC2 private IP → success