#----------------------Step 1:  Create VPC (10.1.0.0/16)---------------------------------------
 aws ec2 create-vpc --cidr-block 10.1.0.0/16 --query Vpc.VpcId
 #vpc-06d5e891e6185bbb6
#----------------------------------------------------------------------------------------------

#----------------------Step 2:  Tag VPC  (10.1.0.0/16)---------------------------------------
aws ec2 create-tags --resources vpc-06d5e891e6185bbb6 --tags Key=Name,Value=project4a-vpc
#----------------------------------------------------------------------------------------------

#----------------------Step 3: Enable DNS Hostname VPC (10.1.0.0/16)---------------------------------------
aws ec2 modify-vpc-attribute --vpc-id vpc-06d5e891e6185bbb6 --enable-dns-hostnames
#----------------------------------------------------------------------------------------------

#----------------------Step 4:  Create 1 Public Subnet (10.1.1.0/24)---------------------------------------
aws ec2 create-subnet --vpc-id vpc-06d5e891e6185bbb6 --cidr-block 10.1.1.0/24 --availability-zone eu-west-2a --query Subnet.SubnetId
#  subnet-0874c8c21fbed7966
#----------------------------------------------------------------------------------------------

#----------------------Step 5:  Tag Subnet-----------------------------------------------------
aws ec2 create-tags --resources subnet-0874c8c21fbed7966 --tags Key=Name,Value=project4a-public-subnet
#----------------------------------------------------------------------------------------------

#----------------------Step 6:  Enable auto-assign public IP on subnet---------------------------------------
aws ec2 modify-subnet-attribute --subnet-id subnet-0874c8c21fbed7966 --map-public-ip-on-launch
#----------------------------------------------------------------------------------------------

# Step 7:  Create IGW
aws ec2 create-internet-gateway --tag-specifications ResourceType=internet-gateway,Tags=[{Key=Name,Value=project4a-igw}] --query InternetGateway.InternetGatewayId --output text
# igw-01829be972e8af7e9 

# Step 8:  Attach IGW to VPC
aws ec2 attach-internet-gateway --internet-gateway-id igw-01829be972e8af7e9 --vpc-id vpc-06d5e891e6185bbb6

# Step 9:  Create Route Table
aws ec2 create-route-table --vpc-id vpc-06d5e891e6185bbb6 --query RouteTable.RouteTableId --output text
# rtb-083894828ef93b48d                                                                                                                                                                            
aws ec2 create-tags --resources rtb-083894828ef93b48d --tags Key=Name,Value=project4a-rtb

# Step 10: Add Route (0.0.0.0/0 → IGW)
aws ec2 create-route --route-table-id rtb-083894828ef93b48d --destination-cidr-block 0.0.0.0/0 --gateway-id igw-01829be972e8af7e9

# Step 11: Associate Route Table to Subnet
aws ec2 associate-route-table --route-table-id rtb-083894828ef93b48d --subnet-id subnet-0874c8c21fbed7966 --query AssociationId --output text
# rtbassoc-0dbd2af5a19203ebc                                                                                                                                                                                                                       

# Step 12: Create Peering Connection (VPC-A ↔ VPC-B)
aws ec2 create-vpc-peering-connection --vpc-id vpc-0c763a8fa021abdab --peer-vpc-id vpc-06d5e891e6185bbb6 --query VpcPeeringConnection.VpcPeeringConnectionId --output text
# pcx-0bc0b8675c21cbab8 

# Step 13: Accept Peering
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-0bc0b8675c21cbab8 
# Step 14: Add route in VPC-A RT (10.1.0.0/16 → Peering)
# VPC A - rtb-0b473fbcd57b10311
# VPC B - cidr-bloc = 10.1.0.0/16
aws ec2 create-route --route-table-id rtb-0b473fbcd57b10311 --destination-cidr-block 10.1.0.0/16 --vpc-peering-connection-id pcx-0bc0b8675c21cbab8

# Step 15: Add route in VPC-B RT (10.0.0.0/16 → Peering)
# VPC B - rtb-083894828ef93b48d
# VPC A - cidr-bloc = 10.0.0.0/16
aws ec2 create-route --route-table-id rtb-083894828ef93b48d --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection-id pcx-0bc0b8675c21cbab8


#Step 16 : Verify VPC Peering.
aws ec2 describe-vpc-peering-connections --query 'VpcPeeringConnections[].{ID:VpcPeeringConnectionId,Status:Status.Code}'


aws ec2 run-instances --image-id ami-0bffc51387b7268b8 --instance-type t3.micro --subnet-id subnet-0874c8c21fbed7966 --security-group-ids sg-071606614f929083a --key-name sagar-project2-key --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=PeerTest-VPC-B}]"
