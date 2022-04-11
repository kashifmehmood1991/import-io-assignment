# Cloud Infrastructure Engineer
## Take-home technical assessment

## Introduction
The purpose of this assessment is for **import.io** to ascertain the technical suitability of candidates applying for a Cloud Infrastructure Engineer position.

Please note the following:

 - Use any tools that you think are relevant to the tasks. We have added context around the tools currently in use at import.io (indicated on each task with the :arrow_forward: emoji) but if you are inexperienced with these, please use an alternative that you're comfortable with (e.g. Terraform instead of AWS CDK)
 - We do not expect this test to take more than 2 hours

## Process

 1. Clone this repository to your local device
 2. Push it to a *different* publicly-accessible repository (another Github repo or any other cloud-based Git repository host). Do not fork the repository, as other candidates will be able to see your work
 3. Complete the tasks listed below
 4. Edit this `README.md` file to include brief answers to the questions about the assessment listed below
 5. Push your work to your new repository
 6. Send your recruitment contact a link to the new repository

If you have any questions about this process, please speak to your recruitment contact.

## Tasks

### 1. Docker
A basic TypeScript application has been created in the `application` folder. Create a Dockerfile to build this application, making sure that it runs on your local device.

### 2. CI/CD
 - :arrow_forward: CircleCI
 - :arrow_forward: Bitbucket Pipelines
 - :arrow_forward: Github Actions

Write a YAML-based CI/CD pipeline to build, push and deploy this docker image to an imaginary Amazon Kubernetes Service cluster.

Kubernetes resource definitions have been included in the `kubernetes` folder.

Use whatever mechanism/tools you think are appropriate/relevant to "deploy" the application.

NOTE: This pipeline does not have to be active. All we're looking for is the YAML file. Minor syntax errors will be overlooked.

### 3. Infrastructure as Code
 - :arrow_forward: AWS CDK in TypeScript
 - :arrow_forward: Terraform

Create some Infrastructure as Code resources to deploy an EC2 instance and an RDS database to an imaginary AWS account.

The EC2 instance must be able to connect to RDS, and the EC2 instance will need to be accessed as follows:
 - SSH from IPs `107.22.40.20` and `18.215.226.36`
 - HTTPS traffic from anywhere

Consider other general security best practices.

Assume the default VPC exists and can be used for this infrastructure.

Other configuration can be decided by yourself, based on the instance being used for a low resource usage, low traffic web application.

## Questions

 1. How long did you spend on this assessment in total?\
 _

 2. What was the most difficult task?\
 _

 3. If you had an unlimited amount of time to complete this task, what would you have done differently?\
 _

