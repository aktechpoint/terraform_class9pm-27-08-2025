import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')

    response = ec2.run_instances(
        ImageId='ami-02d26659fd82cf299',  # Replace with a valid AMI ID
        InstanceType='t3.micro',
        KeyName='key_12',  # Corrected parameter name (case-sensitive)
        MinCount=1,
        MaxCount=1
    )
    
    return response
