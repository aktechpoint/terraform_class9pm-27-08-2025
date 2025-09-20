import boto3

ec2 = boto3.client('ec2')

response = ec2.run_instances(
    ImageId='ami-01b6d88af12965bb6',  # Replace with a valid AMI ID
    InstanceType='t3.micro',
    KeyName='key_12',  # Corrected parameter name (case-sensitive)
    MinCount=1,
    MaxCount=1
)

print("Instance launched:", response['Instances'][0]['InstanceId'])
