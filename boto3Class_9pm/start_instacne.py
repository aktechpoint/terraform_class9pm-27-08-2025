import boto3
ec2 = boto3.client('ec2')
response = ec2.start_instances(
    InstanceIds=[
        'i-085f5ec761ea27d0a'
    ]
)
print("Instance started:", response['StartingInstances'][0]['InstanceId'])