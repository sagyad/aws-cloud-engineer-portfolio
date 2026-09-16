import json
import boto3
import uuid
from datetime import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('portfolio-projects')

def lambda_handler(event, context):
    http_method = event['httpMethod']
    path = event.get('path', '')

    # GET /projects — list all projects
    if http_method == 'GET' and path == '/projects':
        response = table.scan()
        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(response['Items'])
        }

    # GET /projects/{id} — get one project
    if http_method == 'GET' and path.startswith('/projects/'):
        project_id = path.split('/')[-1]
        response = table.get_item(Key={'project_id': project_id})
        if 'Item' in response:
            return {
                'statusCode': 200,
                'headers': {'Content-Type': 'application/json'},
                'body': json.dumps(response['Item'])
            }
        return {
            'statusCode': 404,
            'body': json.dumps({'error': 'Project not found'})
        }

    # POST /projects — create a project
    if http_method == 'POST' and path == '/projects':
        raw_body = event.get('body', '{}')
        if isinstance(raw_body, str):
            body = json.loads(raw_body)
        else:
            body = raw_body

        item = {
            'project_id': str(uuid.uuid4()),
            'project_name': body.get('project_name', ''),
            'description': body.get('description', ''),
            'aws_services': body.get('aws_services', ''),
            'status': body.get('status', 'Not Started'),
            'github_url': body.get('github_url', ''),
            'created_date': datetime.utcnow().isoformat()
        }
        table.put_item(Item=item)
        return {
            'statusCode': 201,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps(item)
        }

    # DELETE /projects/{id} — delete a project
    if http_method == 'DELETE' and path.startswith('/projects/'):
        project_id = path.split('/')[-1]
        table.delete_item(Key={'project_id': project_id})
        return {
            'statusCode': 200,
            'body': json.dumps({'message': f'Project {project_id} deleted'})
        }

    return {
        'statusCode': 400,
        'body': json.dumps({'error': 'Unsupported route'})
    }
