import boto3
client = boto3.client('ec2')

response = client.terminate_instances(
    InstanceIds=[
        'i-02b1e2f106e89989e'
    ]
    
)
print("Instance terminated:", response['TerminatingInstances'][0]['InstanceId'])