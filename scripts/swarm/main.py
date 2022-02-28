#!/usr/bin/env python3

import boto3
import click


def connection_string(ip, key_name):
    return f'ssh ec2-user@{ip} -i ~/.ssh/{key_name}.pem'


def enum_instances():
    filters = [
        {'Name': 'tag:collection', 'Values': ['swarm']},
        {'Name': 'instance-state-name', 'Values': ['running']},
    ]
    ec2 = boto3.resource('ec2')
    for instance in ec2.instances.filter(Filters=filters):
        yield instance


def latest_amazon_linux_image(ec2):
    filters = [
        {'Name': 'architecture', 'Values': ['arm64']},
        {'Name': 'name', 'Values': ['amzn2-ami-kernel-5.10-hvm-*']},
    ]
    unsorted_images = ec2.images.filter(
        Filters=filters,
        Owners=['amazon'],
    )
    images = sorted(
        unsorted_images,
        key=lambda x: x.creation_date,
        reverse=True
    )
    # Assume this will work. If it doesn't, fail hard intentionally.
    return images[0].id


def get_vpc(ec2):
    filters = [{'Name': 'tag:Name', 'Values': ['app-swarm']}]
    return [x for x in ec2.vpcs.filter(Filters=filters).limit(1)][0]


def get_subnet(ec2, is_public):
    public_or_private = 'public' if is_public else 'private'
    name = f'app-swarm-{public_or_private}-us-west-2b'
    subnets = ec2.subnets.filter(
        Filters=[{'Name': 'tag:Name', 'Values': [name]}]
    )
    return [x for x in subnets][0].id


def get_security_group(ec2):
    vpc = get_vpc(ec2)
    security_groups = ec2.security_groups.filter(
        Filters=[
            {'Name': 'tag:Name', 'Values': ['swarm']},
            {'Name': 'vpc-id', 'Values': [vpc.id]},
        ]
    )
    return [x for x in security_groups][0].id


def create_instance(is_public):
    ec2 = boto3.resource('ec2')
    ami = latest_amazon_linux_image(ec2)
    subnet = get_subnet(ec2, is_public)
    security_group = get_security_group(ec2)
    key_name = 'ec2-us-west-2'
    instances = ec2.create_instances(
        ImageId=ami,
        InstanceType='t4g.nano',
        SecurityGroupIds=[security_group],
        SubnetId=subnet,
        TagSpecifications=[{
            'ResourceType': 'instance',
            'Tags': [{'Key': 'collection', 'Value': 'swarm'}],
        }],
        KeyName=key_name,
        MinCount=1,
        MaxCount=1,
    )
    print("The instance is being being created.")
    print("Once it is running, connection info will be shown here:")
    for instance in instances:
        instance.wait_until_running()
        instance.load()
        if is_public:
            print(connection_string(instance.public_ip_address, key_name))
        else:
            print('Public connection is not possible.')


@click.group()
def cli():
    pass


@cli.command()
@click.option('--public/--private', default=True)
def create(public):
    create_instance(public)


@cli.command()
def list():
    instances = enum_instances()
    header_shown = False
    key_name = 'ec2-us-west-2'
    for box in instances:
        if not header_shown:
            print("Instances:")
            header_shown = True
        conn_str = connection_string(box.public_ip_address, key_name)
        print(f'{box.id}: {conn_str}')


if __name__ == '__main__':
    cli()
