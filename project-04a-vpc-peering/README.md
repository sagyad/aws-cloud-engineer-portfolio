
# Project 4a: VPC Peering

## Architecture

```text
VPC-A (10.0.0.0/16)       VPC-B (10.1.0.0/16)
+----------------+        +----------------+
| Public Subnet  | Peer   | Public Subnet  |
| 10.0.x.x/24   |<-pcx->| 10.1.1.0/24    |
| EC2 Instance   |        | EC2 Instance   |
+----------------+        +----------------+

Route Table A:       Route Table B:
 0.0.0.0/0  -> IGW    0.0.0.0/0  -> IGW
 10.1.0.0/16-> pcx    10.0.0.0/16-> pcx
```

## Overview

Established a VPC Peering connection between two
VPCs in the same region to enable private
communication over the AWS backbone. Configured
route tables and security groups in both VPCs
for bidirectional traffic.

## AWS Services Used

- **VPC** — Two VPCs with non-overlapping CIDRs
- **VPC Peering** — Private connection between VPCs
- **Route Tables** — Cross-VPC routing via peering
- **Security Groups** — ICMP and SSH between CIDRs
- **EC2** — Connectivity verification instances
- **Internet Gateway** — Public access for both VPCs

## Implementation

### VPC-B Setup

```bash
aws ec2 create-vpc \
  --cidr-block 10.1.0.0/16
aws ec2 create-subnet \
  --vpc-id <vpc-b-id> \
  --cidr-block 10.1.1.0/24 \
  --availability-zone eu-west-2a
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway \
  --internet-gateway-id <igw-id> \
  --vpc-id <vpc-b-id>
aws ec2 create-route \
  --route-table-id <rtb-b> \
  --destination-cidr-block 0.0.0.0/0 \
  --gateway-id <igw-id>
```

### Peering Connection

```bash
aws ec2 create-vpc-peering-connection \
  --vpc-id <vpc-a-id> \
  --peer-vpc-id <vpc-b-id>
aws ec2 accept-vpc-peering-connection \
  --vpc-peering-connection-id <pcx-id>
```

### Route Table Updates

```bash
aws ec2 create-route \
  --route-table-id <rtb-a> \
  --destination-cidr-block 10.1.0.0/16 \
  --vpc-peering-connection-id <pcx-id>
aws ec2 create-route \
  --route-table-id <rtb-b> \
  --destination-cidr-block 10.0.0.0/16 \
  --vpc-peering-connection-id <pcx-id>
```

### Verification

```bash
aws ec2 describe-vpc-peering-connections \
  --query 'VpcPeeringConnections[].{
    ID:VpcPeeringConnectionId,
    Status:Status.Code}'
```

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| Same-region peering | Lower latency |
| Non-overlapping CIDRs | Required by AWS |
| Bidirectional routes | Both VPCs need routes |
| CIDR-based SG rules | Controlled access |

## Built With

- **CLI:** AWS CLI
- **Services:** VPC, EC2, VPC Peering
- **Region:** eu-west-2 (London)
