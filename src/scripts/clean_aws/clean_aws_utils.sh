#!bin/bash


##################################################################################################
#                                          AWS: Utilities                                        #
##################################################################################################

# Regions
function get_aws_regions() {
    local regions=$(aws ec2 describe-regions --query 'Regions[].RegionName' --output text)
    echo "$regions"
}

##################################################################################################
#                                          AWS: EC2                                              #
##################################################################################################

# EC2 - Instances
function get_aws_ec2_instIDs() {
    local ec2_inst_ids=$(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --output text)
    echo "$ec2_inst_ids"
}

function get_aws_ec2_instID_by_tagKey() {
    local exclude_ec2_inst_id=$(aws ec2 describe-instances --filter "Name=tag-key,Values=$1" --query 'Reservations[].Instances[].InstanceId' --output text)
    echo "$exclude_ec2_inst_id"
}

function delete_aws_ec2_instID() {
    aws ec2 terminate-instances --instance-ids $1
    aws ec2 wait instance-terminated --instance-ids $1
}

# EC2 - VPC
function get_aws_ec2_vpc_by_instID() {
    local vpc_id=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$1" --query 'Reservations[].Instances[].VpcId' --output text)
    echo "$vpc_id"
}

function delete_aws_ec2_vpc() {
    aws ec2 delete-vpc --vpc-id $1
}

# EC2 - Subnets
function get_aws_ec2_subnets_by_vpc() {
    local subnet_ids=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$1" --query 'Subnets[].SubnetId' --output text)
    echo "$subnet_ids"
}

function delete_aws_ec2_subnet() {
    aws ec2 delete-subnet --subnet-id $1
}

# EC2 - Key Pair
function get_aws_ec2_keyPair_by_instID() {
    local key_pair_name=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$1" --query 'Reservations[].Instances[].KeyName' --output text)
    echo "$key_pair_name"
}

function delete_aws_ec2_keyPair() {
    aws ec2 delete-key-pair --key-name $1
}

# EC2 - Security Groups
function get_aws_ec2_securityGroups_by_instID() {
    local security_group_ids=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$1" --query 'Reservations[].Instances[].SecurityGroups[].GroupId' --output text)
    echo "$security_group_ids"
}

function delete_aws_ec2_securityGroup() {
    aws ec2 delete-security-group --group-id $1
}

# EC2 - Route Tables
function get_aws_ec2_routeTables_by_vpc() {
    local route_table_ids=$(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$1" --query 'RouteTables[].RouteTableId' --output text)
    echo "$route_table_ids"
}

function delete_aws_ec2_routeTable() {
    aws ec2 delete-route-table --route-table-id $1
}

# EC2 - Network ACLs
function get_aws_ec2_networkACLs_by_vpc() {
    local network_acl_ids=$(aws ec2 describe-network-acls --filters "Name=vpc-id,Values=$1" --query 'NetworkAcls[].NetworkAclId' --output text)
    echo "$network_acl_ids"
}

function delete_aws_ec2_networkACL() {
    aws ec2 delete-network-acl --network-acl-id $1
}

# EC2 - Internet Gateways
function get_aws_ec2_internetGateways_by_vpc() {
    local internet_gateways=$(aws ec2 describe-internet-gateways --filters "Name=attachment.vpc-id,Values=$1" --query 'InternetGateways[0].InternetGatewayId' --output text)
    echo "$internet_gateways"
}

function delete_aws_ec2_internetGateway_by_vpc() {
    aws ec2 detach-internet-gateway --internet-gateway-id $1 --vpc-id $2
    aws ec2 delete-internet-gateway --internet-gateway-id $1
}

# EC2 - EBS Volumes
function get_aws_ec2_volumes_by_instID() {
    local volume_ids=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$1" --query 'Reservations[].Instances[].BlockDeviceMappings[].Ebs[].VolumeId' --output text)
    echo "$volume_ids"
}

function delete_aws_ec2_volume() {
    aws ec2 delete-volume --volume-id $1
}

# EC2 - Spot Instances
function get_aws_ec2_spot_instIDs() {
    local ec2_spot_inst_reqs=$(aws ec2 describe-spot-instance-requests --query 'SpotInstanceRequests[].SpotInstanceRequestId' --output text)
    echo "$ec2_spot_inst_reqs"
}

function delete_aws_ec2_spot_instID() {
    aws ec2 cancel-spot-instance-requests --spot-instance-request-ids $1
}

##################################################################################################
#                                          AWS: RDS                                              #
##################################################################################################

# RDS - Instances
function get_aws_rds_instIDs() {
    local db_inst_ids=$(aws rds describe-db-instances --query 'DBInstances[].DBInstanceIdentifier' --output text)
    echo "$db_inst_ids"
}

function delete_aws_rds_instID() {
    aws rds delete-db-instance --db-instance-identifier $1 --skip-final-snapshot
    aws rds wait db-instance-deleted --db-instance-identifier $1
}

# RDS - Snapshots
function get_aws_rds_snapshots_by_instID() {
    local snapshot_ids=$(aws rds describe-db-snapshots --query "DBSnapshots[?DBInstanceIdentifier=='$1'].DBSnapshotIdentifier" --output text)
    echo "$snapshot_ids"
}

function delete_aws_rds_snapshots() {
    aws rds delete-db-snapshot --db-snapshot-identifier $1
}
