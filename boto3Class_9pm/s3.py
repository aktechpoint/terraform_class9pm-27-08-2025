import boto3

# Create S3 client
s3 = boto3.client('s3')

# Create a bucket
response = s3.create_bucket(
    Bucket='ramalalsingh1111',   # must be globally unique
    CreateBucketConfiguration={
        'LocationConstraint': 'ap-south-1'
    }
)

print("Bucket created successfully:", response)
