#!bin/bash


source $SCRIPTS/clean_aws/clean_aws_utils.sh

default_region=$AWS_DEFAULT_REGION
exclude_tag_key="MyTagKey"


regions=$(get_aws_regions)

# Loop through each region
for region in $regions; do
    echo "AWS Region: $region"

    # Set the current region for AWS CLI
    export AWS_DEFAULT_REGION=$region

    ec2_inst_ids=$(get_aws_ec2_instIDs)
    exclude_ec2_inst_id=$(get_aws_ec2_instID_by_tagKey $exclude_tag_key)

    for ec2_inst_id in $ec2_inst_ids; do
        if [ "$ec2_inst_id" == "$exclude_ec2_inst_id" ]; then
            continue
        fi
        vpc_ids=$(get_aws_ec2_vpc_by_instID $ec2_inst_id)
        key_pair_names=$(get_aws_ec2_keyPair_by_instID $ec2_inst_id)
        volume_ids=$(get_aws_ec2_volumes_by_instID $ec2_inst_id)
        security_group_ids=$(get_aws_ec2_securityGroups_by_instID $ec2_inst_id)

        echo "EC2 Instance: $ec2_inst_id"
        delete_aws_ec2_instID $ec2_inst_id

        for key_pair_name in $key_pair_names; do
            echo "Key Pair: $key_pair_name"
            delete_aws_ec2_keyPair $key_pair_name
        done

        for vpc_id in $vpc_ids; do
            echo "VPC: $vpc_id"

            network_acl_ids=$(get_aws_ec2_networkACLs_by_vpc $vpc_id)
            internet_gateways=$(get_aws_ec2_internetGateways_by_vpc $vpc_id)
            subnet_ids=$(get_aws_ec2_subnets_by_vpc $vpc_id)
            route_table_ids=$(get_aws_ec2_routeTables_by_vpc $vpc_id)

            for subnet_id in $subnet_ids; do
                echo "Subnet ID: $subnet_id"
                delete_aws_ec2_subnet $subnet_id
            done

            for internet_gateway in $internet_gateways; do
                echo "Internet Gateway: $internet_gateway"
                delete_aws_ec2_internetGateway_by_vpc $internet_gateway $vpc_id
            done

            for security_group_id in $security_group_ids; do
                echo "Security Group: $security_group_id"
                delete_aws_ec2_securityGroup $security_group_id
            done

            # for route_table_id in $route_table_ids; do
            #     echo "Route Table ID: $route_table_id"
            #     delete_aws_ec2_routeTable $route_table_id
            # done

            # for network_acl_id in $network_acl_ids; do
            #     echo "Network ACL: $network_acl_id"
            #     delete_aws_ec2_networkACL $network_acl_id
            # done

            delete_aws_ec2_vpc $vpc_id
        done

        # for volume_id in $volume_ids; do
        #     echo "EBS Volume: $volume_id"
        #     delete_aws_ec2_volume $volume_id
        # done
    done

    ec2_spot_inst_reqs=$(get_aws_ec2_spot_instIDs)
    for ec2_spot_inst_req in $ec2_spot_inst_reqs; do
        echo "EC2 Spot Instance: $ec2_spot_inst_req"
        delete_aws_ec2_spot_instID $ec2_spot_inst_req
    done

    rds_inst_ids=$(get_aws_rds_instIDs)
    for rds_inst_id in $rds_inst_ids; do
        snapshot_ids=$(get_aws_rds_snapshots_by_instID $rds_inst_id)
        echo "RDS Instance: $rds_inst_id"
        delete_aws_rds_instID $rds_inst_id
        for snapshot_id in $snapshot_ids; do
            echo "RDS Snapshot: $snapshot_id"
            delete_aws_rds_snapshots $snapshot_id
        done

    done

    echo
done

export AWS_DEFAULT_REGION=$default_region

echo "All resources across all regions have been deleted except those with tag $exclude_tag_key."
