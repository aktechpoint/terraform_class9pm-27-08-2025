import boto3
ec2 = boto3.client('ec2')
response = ec2.stop_instances(
    InstanceIds=[
        'i-085f5ec761ea27d0a'
    ]   
)
print("Instance stopped:", response['StoppingInstances'][0]['InstanceId'])