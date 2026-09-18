# ================================STEP 1s =======================================================
# -------Create VPC with CidrBlock 10.1.0.0/16
aws ec2 create-vpc --cidr-block 10.1.0.0/16 --query Vpc.VpcId --output text
# vpc-0374a2fe19b346c8c 
# ----- Create VPC Tag
aws ec2 create-tags --resources vpc-0374a2fe19b346c8c --tags Key=Name,Value=Project4a-VPC-B

#------ Enable VPC DNS Hostname
aws ec2 modify-vpc-attribute --vpc-id vpc-0374a2fe19b346c8c --enable-dns-hostnames
#================================================================================================

#====================================STEP 2s ====================================================================================
#-------------CREATE IGW and Attach to VPC-------------------------
aws ec2 create-internet-gateway --tag-specification ResourceType=internet-gateway,Tags[{Key=Name,Value=project4a-igw}] --query InternetGateway.InternetGatewayId --output text
# igw-0295d15350e9d6284

aws ec2 attach-internet-gateway --internet-gateway-id igw-0295d15350e9d6284 --vpc-id vpc-0374a2fe19b346c8c 
#===============================================================================================================================

#==================================STEP 3s =======================================================
#------ Create Public Subnets in VPC-B
aws ec2 create-subnet --vpc-id vpc-0374a2fe19b346c8c --cidr-block 10.1.1.0/24 --availability-zone eu-west-2a --query Subnet.SubnetId --outupt text
#subnet-0a86cf48c314eff39
#------ Tag Subnet as public subnet
aws ec2 create-tags --resource subnet-0a86cf48c314eff39 --tags Key=Name,Value=public-project4a-subnet

#------ Create Private Subnet
aws ec2 create-subnet --vpc-id vpc-0374a2fe19b346c8c --cidr-bloc 10.1.2.0/24 --availability-zone eu-west-2b --query Subnet.SubnetId --output text
# subnet-0789b57425491a010  
#------ Tag Subnet as Private subnet
aws ec2 create-tags --resrouce subnet-0789b57425491a010 --tags Key=Name,Value=private-project4a-subnet
#===============================================================================================================================

#==================================STEP 4s =======================================================
#------ Create ROUTE TABLE - Public and Private
#Public RT
aws ec2 create-route-table --vpc-id vpc-0374a2fe19b346c8c --query RouteTable.RouteTableId --output text
# rtb-0fd9ff5d5743d4795
aws ec2 create-tags --resources rtb-0fd9ff5d5743d4795 --tags Key=Name,Value=project4a-rt

#Private RT
aws ec2 create-route-table --vpc-id vpc-0374a2fe19b346c8c --query RouteTable.RouteTableId --output text
# rtb-0c27e88dd6ed07b3e

# - Create Route with cidr-block 0.0.0.0/0 with IGW
aws ec2 associate-route-table --route-table-id rtb-0fd9ff5d5743d4795 --subnet-id subnet-0a86cf48c314eff39

#- Associate Public Route Table to Public Subnet
aws ec2 associate-route-table --route-table-id rtbassoc-0c85d841eb05eed70  --subnet-id subnet-0a86cf48c314eff39 --query AssociationId --output text
# rtbassoc-0c85d841eb05eed70

#- Associate Private Route Table to Private Subnet
aws ec2 associate-route-table --route-table-id rtb-0c27e88dd6ed07b3e --subnet-id subnet-0789b57425491a010 --query AssociationId --output text
# rtbassoc-0313544ec5ea671af
#===============================================================================================================================

#==================================STEP 5s =======================================================
# -- Create VPC Peering between 2 VPC VPC-1 vpc-0374a2fe19b346c8c   VPC-2 = vpc-0c763a8fa021abdab
aws ec2 create-vpc-peering-connection --vpc-id vpc-0374a2fe19b346c8c --peer-vpc-id vpc-0c763a8fa021abdab --query VpcPeeringConnection.VpcPeeringConnectionId --output text
# pcx-04826a55f0dc7d91d

# Add route in VPC 1 route table pointing to VPC 2
# public-rt VPC 1 = rtb-0b473fbcd57b10311
