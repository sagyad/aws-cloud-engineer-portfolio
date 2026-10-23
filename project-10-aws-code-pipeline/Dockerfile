
# Simple Dockerfile for testing the CI/CD pipeline
# Nginx serves a static HTML page on port 80
FROM nginx:alpine

# Custom homepage to verify deployment works
RUN echo '<h1>Project 10 — CodePipeline CI/CD</h1><p>Deployed by Sagar via AWS CodePipeline + ECS Fargate</p>' \
    > /usr/share/nginx/html/index.html

EXPOSE 80

