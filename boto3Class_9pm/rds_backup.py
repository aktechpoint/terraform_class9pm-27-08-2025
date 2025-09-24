import boto3
import datetime
import os

def lambda_handler(event, context):
    rds = boto3.client('rds')

    # Endpoint (set as env variable in Lambda)
    endpoint = os.environ['DB_ENDPOINT']

    # Get DB instance identifier from endpoint
    instances = rds.describe_db_instances()['DBInstances']
    db_instance_id = None
    for instance in instances:
        if instance['Endpoint']['Address'] == endpoint:
            db_instance_id = instance['DBInstanceIdentifier']
            break

    if not db_instance_id:
        return {
            'statusCode': 400,
            'body': f"No RDS instance found with endpoint {endpoint}"
        }

    # Generate snapshot identifier with timestamp
    snapshot_id = f"{db_instance_id}-snapshot-{datetime.datetime.now().strftime('%Y-%m-%d-%H-%M-%S')}"

    try:
        response = rds.create_db_snapshot(
            DBInstanceIdentifier=db_instance_id,
            DBSnapshotIdentifier=snapshot_id
        )
        return {
            'statusCode': 200,
            'body': f"Snapshot {snapshot_id} created successfully!",
            'response': str(response)
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f"Error creating snapshot: {str(e)}"
        }
