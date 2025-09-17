import boto3

# Create S3 client
s3 = boto3.client('s3', region_name='ap-south-1')

# Delete a bucket
bucket_name = "ramalalsingh1111"

response = s3.delete_bucket(Bucket=bucket_name)

print(f"Bucket '{bucket_name}' deleted successfully:", response)
