# Project 3: Serverless REST API

## Overview
A fully serverless CRUD API built with AWS Lambda, API Gateway, and DynamoDB. No servers to manage — AWS handles all scaling automatically.

## Architecture
Client → API Gateway → Lambda → DynamoDB


## AWS Services Used
- **Lambda** — Runs the Python code (no servers)
- **API Gateway** — Creates the REST API endpoints
- **DynamoDB** — NoSQL database for storing data
- **IAM** — Role and policies for permissions
- **CloudWatch** — Automatic logging

## API Endpoints
| Method | Endpoint | Action |
|--------|----------|--------|
| GET | /projects | List all projects |
| POST | /projects | Create a project |
| GET | /projects/{id} | Get one project |
| DELETE | /projects/{id} | Delete a project |

## API URL
https://wi7qng0k1j.execute-api.eu-west-2.amazonaws.com/prod


## CI/CD
GitHub Actions automatically deploys Lambda on every push to main branch.

## Key Learnings
- Lambda event structure (httpMethod, body, pathParameters)
- IAM trust policy vs permissions policy
- API Gateway resource/method/integration flow
- DynamoDB CRUD with boto3
- file:// vs fileb:// in AWS CLI