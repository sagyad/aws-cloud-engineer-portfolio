#!/usr/bin/env bash
# ============================================
# 01-create-dynamodb.sh
# Creates a DynamoDB — 
# ============================================


# Step 1  Create Table
aws dynamodb create-table --table-name portfolio-projects --attribute-definitions AttributeName=project_id,AttributeType=S --key-schema AttributeName=project_id,KeyType=HASH --billing-mode PAY_PER_REQUEST --query TableDescription.TableArn --output text

# Step 2 — Create IAM Role for Lambda
aws iam create-role --role-name lambda-portfolio-api-role --assume-role-policy-document file://trust-policy.json

# Step 3 - Attach permissions policy
aws iam put-role-policy --role-name lambda-portfolio-api-role --policy-name lambda-dynamodb-access --policy-document file://lambda-policy.json

# Step 4 - Lambda Function

# Step 5 - ZIP the lambda Function
powershell Compress-Archive -Path lambda_function.py -DestinationPath function.zip

# Step 6 - Create Lambda Function
aws lambda create-function --function-name portfolio-api --runtime python3.12 --role arn:aws:iam::865189667468:role/lambda-portfolio-api-role --handler lambda_function.lambda_handler --zip-file fileb://function.zip --timeout 10 --memory-size 128

# Step 7 - Create API Gateway
 aws apigateway create-rest-api --name portfolio-api --description "Portfolio Projects REST API" --query id --output text
#wi7qng0k1j

# Step 8 - Get root resource ID
aws apigateway get-resources --rest-api-id wi7qng0k1j
# {                                                                                                                                                                                                                                                                                                         
#     "items": [
#         {
#             "id": "ir9u33q258",
#             "path": "/"
#         }
#     ]
# }

# Step 9 - Create Project resource
aws apigateway create-resource --rest-api-id wi7qng0k1j --parent-id ir9u33q258 --path-part projects
# {                                                                                                                                                                                                                   
#     "id": "zen2f6",
#     "parentId": "ir9u33q258",
#     "pathPart": "projects",
#     "path": "/projects"
# }
aws apigateway create-resource --rest-api-id wi7qng0k1j --parent-id zen2f6 --path-part "{id}"
# {                                                                                                                                                                                                                   
#     "id": "3muoqc",
#     "parentId": "zen2f6",
#     "pathPart": "{id}",
#     "path": "/projects/{id}"
# }
aws apigateway put-method --rest-api-id wi7qng0k1j --resource-id zen2f6 --http-method GET --authorization-type NONE
# {                                                                                                                                                                                                                   
#     "httpMethod": "GET",
#     "authorizationType": "NONE",
#     "apiKeyRequired": false
# }
aws apigateway put-method --rest-api-id wi7qng0k1j --resource-id zen2f6 --http-method POST --authorization-type NONE
# {                                                                                                                                                                                                                   
#     "httpMethod": "POST",
#     "authorizationType": "NONE",
#     "apiKeyRequired": false
# }
aws apigateway put-method --rest-api-id wi7qng0k1j --resource-id 3muoqc --http-method GET --authorization-type NONE
# {                                                                                                                                                                                                                   
#     "httpMethod": "GET",
#     "authorizationType": "NONE",
#     "apiKeyRequired": false
# }
aws apigateway put-method --rest-api-id wi7qng0k1j --resource-id 3muoqc --http-method DELETE --authorization-type NONE
# {                                                                                                                                                                                                                   
#     "httpMethod": "DELETE",
#     "authorizationType": "NONE",
#     "apiKeyRequired": false
# }
aws apigateway put-integration --rest-api-id wi7qng0k1j --resource-id zen2f6 --http-method GET --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations
# {                                                                                                                                                                                                                   
#     "type": "AWS_PROXY",
#     "httpMethod": "POST",
#     "uri": "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations",
#     "passthroughBehavior": "WHEN_NO_MATCH",
#     "timeoutInMillis": 29000,
#     "cacheNamespace": "zen2f6",
#     "cacheKeyParameters": []
# }
aws apigateway put-integration --rest-api-id wi7qng0k1j --resource-id zen2f6 --http-method POST --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations
# {                                                                                                                                                                                                                   
#     "type": "AWS_PROXY",
#     "httpMethod": "POST",
#     "uri": "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations",
#     "passthroughBehavior": "WHEN_NO_MATCH",
#     "timeoutInMillis": 29000,
#     "cacheNamespace": "zen2f6",
#     "cacheKeyParameters": []
# }
aws apigateway put-integration --rest-api-id wi7qng0k1j --resource-id 3muoqc --http-method GET --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations
# {                                                                                                                                                                                                                   
#     "type": "AWS_PROXY",
#     "httpMethod": "POST",
#     "uri": "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations",
#     "passthroughBehavior": "WHEN_NO_MATCH",
#     "timeoutInMillis": 29000,
#     "cacheNamespace": "3muoqc",
#     "cacheKeyParameters": []
# }
aws apigateway put-integration --rest-api-id wi7qng0k1j --resource-id 3muoqc --http-method DELETE --type AWS_PROXY --integration-http-method POST --uri arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations
# {                                                                                                                                                                                                                   
#     "type": "AWS_PROXY",
#     "httpMethod": "POST",
#     "uri": "arn:aws:apigateway:eu-west-2:lambda:path/2015-03-31/functions/arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api/invocations",
#     "passthroughBehavior": "WHEN_NO_MATCH",
#     "timeoutInMillis": 29000,
#     "cacheNamespace": "3muoqc",
#     "cacheKeyParameters": []
# }

# Step 10 - Give API Gateway permission to invoke Lambda. 
aws lambda  add-permission --function-name portfolio-api --statement-id apigateway-projects --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/GET/projects"
# {                                                                                                                                                                                                                   
#     "Statement": "{\"Sid\":\"apigateway-projects\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"apigateway.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/GET/projects\"}}}"
# }

aws lambda add-permission --function-name portfolio-api --statement-id apigateway-projects-post --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/POST/projects"
# {                                                                                                                                                                                                                   
#     "Statement": "{\"Sid\":\"apigateway-projects-post\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"apigateway.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/POST/projects\"}}}"
# }
aws lambda add-permission --function-name portfolio-api --statement-id apigateway-project-get --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/GET/projects/*"
# {                                                                                                                                                                                                                   
#     "Statement": "{\"Sid\":\"apigateway-project-get\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"apigateway.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/GET/projects/*\"}}}"
# }
aws lambda add-permission --function-name portfolio-api --statement-id apigateway-project-delete --action lambda:InvokeFunction --principal apigateway.amazonaws.com --source-arn "arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/DELETE/projects/*"
# {                                                                                                                                                                                                                   
#     "Statement": "{\"Sid\":\"apigateway-project-delete\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"apigateway.amazonaws.com\"},\"Action\":\"lambda:InvokeFunction\",\"Resource\":\"arn:aws:lambda:eu-west-2:865189667468:function:portfolio-api\",\"Condition\":{\"ArnLike\":{\"AWS:SourceArn\":\"arn:aws:execute-api:eu-west-2:865189667468:wi7qng0k1j/*/DELETE/projects/*\"}}}"
# }

# Step 11 - Deploy the API to Prod
aws apigateway create-deployment --rest-api-id wi7qng0k1j --stage-name prod
# {                                                                                                                                                                                                                                            
#     "id": "2fwu77",
#     "createdDate": "2026-09-15T19:55:06+01:00"
# }