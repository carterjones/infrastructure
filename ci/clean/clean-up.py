#!/usr/bin/env python3
import boto3
import botocore
import sys

ec2_resource = boto3.resource('ec2', region_name='us-west-2')
ec2_client = boto3.client('ec2', region_name='us-west-2')

# Deregister old AMIs.
# TODO: do not deregister AMIs that are undergoing CI testing. find a simple way to do this.
roles = ["base", "blog", "concourse", "dev", "git", "hackbox", "go-website", "pt"]
for role in roles:
    amis = list(ec2_resource.images.filter(
        Owners=["self"],
        Filters=[
            {
                "Name": "tag:role",
                "Values": [role]
            }
        ]
    ))
    # Order the AMIs by age (most recent is at position 0).
    amis.sort(key=lambda x: x.creation_date, reverse=True)
    # Get the list of the AMIs that are not the most recent.
    old_amis = amis[1:]
    for ami in old_amis:
        id = ami.id
        ami.deregister()
        print("Deregistered " + id + ".")

# Delete all EBS snapshots.
snapshots = list(ec2_resource.snapshots.filter(OwnerIds=["self"]))
for snapshot in snapshots:
    id = snapshot.id
    try:
        snapshot.delete()
    except botocore.exceptions.ClientError as e:
        if e.response["Error"]["Code"] == "InvalidSnapshot.InUse":
            continue
        else:
            raise e
    print("Deleted " + id + ".")

# Delete dangling key pairs from failed packer runs.
key_pairs = list(ec2_resource.key_pairs.all())
for kp in key_pairs:
    if kp.name.startswith("packer_"):
        # TODO: iterate over all EC2 instances and make sure that no instance is
        # using this key pair.
        name = kp.name
        kp.delete()
        print("Deleted key pair " + name + ".")

# Delete dangling security groups.
sgs = list(ec2_resource.security_groups.all())
for sg in sgs:
    if sg.group_name.startswith("packer "):
        name = sg.group_name
        try:
            sg.delete()
            print("Deleted security group " + name + ".")
        except:
            print(name + " is still in use.")

# Fail if EIP addresses are found to be disassociated.
eips = ec2_client.describe_addresses()
should_exit_nonzero = False
for eip in eips['Addresses']:
    if "AssociationId" not in eip:
        print("An EIP is not attached: " + eip["PublicIp"])
        should_exit_nonzero = True
if should_exit_nonzero:
    sys.exit(-1)
