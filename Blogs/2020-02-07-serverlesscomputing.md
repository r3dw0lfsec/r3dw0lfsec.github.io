---
layout: post
title: Serverless Computing in a Nutshell
description: >
  Serverless computing is a cloud computing execution model in which the cloud provider runs and manages the server. Read this blog for depeer insights, comparison of top cloud providers and security risks in serverless computing 
sitemap: false
categories: [CloudSecurity]
permalink: /:categories/serverless.html
---


Most of the Serverless architecture are built with a motto of ***"Focus on the application, not the infrastructure and maintenance"***
{:.lead}
![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/1.jpeg)

* toc
{:toc .large-only}

## What is serverless ?
Serverless is a cloud computing execution model where the cloud provider dynamically manages the allocation and provisioning of servers (Load balancing). A serverless application runs in stateless compute containers that are event-triggered and its completely managed by the cloud provider itself.

### Popular Serverless Computing Providers
* AWS lambda
* Azure functions
* Google Cloud functions
* IBM OpenWhisk

### How Does Serverless Computing Works?
In a micro service architecture, monolithic applications are broken down into smaller services (F1,F2,F3) so you can develop, manage and scale them independently and FaaS (Function as a service) takes that step further by breaking applications to the level of functions and events.

![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/2.png)

Business person just need to write the business logic as code ( F1,F2,F3), it is loaded into the container for execution when request from the client triggers a particular function. After the execution in the container ,response is generated and delivered back to the client.

### Things Serverless Computing can Handle
* Load Balancing
* Auto scaling
* Handling Failures
* Security Isolation
* OS Management
* Managing utilization

## Sample Use-Case Scenario of Serverless Computing
When an image is uploaded into a Cloud Storage Service (such as S3), a Serverless function could automatically resize the image for mobile, tablet, desktop devices. The event that triggers the function is the file that has been uploaded to cloud storage. Serverless function then executes the function of resizing the image.

## Benefits of Serverless Computing:

1. **Pay only when you use:**The user will be charged against the time that your functions were running (Paid according to no. of request received and Compute time) . Such architectures remove the need for the traditional 'always on' server system sitting behind an application, significantly reducing operational cost and complexity.
2. **Easier Operational Management and Automatic Scaling:**Automatic scaling functionality of FaaS not only reduces computational cost but also reduces operational management overheads.

**Serverless Framework module:**The Serverless Framework consists of an open source CLI that makes it easy to develop, deploy and test serverless apps across different cloud providers, secure and monitor your serverless apps. This can be installed using the below command:
```bash
npm install -g serverless
```

## Serverless Computing using AWS Lambda
Follow the below steps to deploy a simple serverless service using AWS Lambda
{:.lead}
1. Configure your CLI with the below command:
```bash
serverless config credentials - provider aws - key "YOUR ACCOUNT KEY" - secret " YOUR SECRET KEY"
```
2. Create a project folder for serverless computing with needed template.
```bash
serverless create -t aws-nodejs
```
3. It creates two files : **handler.js** and **serverless.yml**. **serverless.yml** is like a configuration file for your handler file, **handler.js** is like a function file where each function that are required are coded.
4. Uncomment the needed event part in the serverless.yml .Here i am using the http event part
![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/3.png)
5. Run the command serverless deploy to deploy your instance.
![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/4.png)

## Serverless Computing using Azure Functions
Microsoft Azure allows the users to develop and run the serverless functions both on Cloud and Local environment. 
Follow the below steps to deploy a simple serverless service using Azure Functions 
{:.lead}
1. Run the following command from the command line to create a function app project. A github repository is also created with the same name.
```bash
func init {Folder_Name}
```
2. Select a worker runtime from the following language choices that will be prompted after creating the project:
* .NET
* Node JS
* Powershell
* Python
3. Navigate to the created project folder.
```bash
cd {Folder_Name}
```
4. Create an HTTP-triggered function using the following command:
```bash
func new --name {Function_Name} --template "HttpTrigger"
```
![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/5.png)
5. The following command starts the function app:
```bash
func start
```
6. Navigate to URL displayed, append the query string *?name={yourname}* to the URL and execute the request.
![](https://r3dw0lfsec.in//assets/img/blog/cloudsecurity/serverlesscomputing/6.png)

## Serverless Computing using Google Cloud Functions
Follow the below steps to deploy a simple serverless service using Google Cloud Functions
1. Install serverless on your machine if not installed.
```bash
npm install -g serverless
```
2. Create a project folder for serverless computing with needed template.
```bash
serverless create --template google-nodejs --path {Folder_Name}
```
3. It creates three files: **index.js**, **package.json**, **serverless.yml**
4. Install all the dependencies
```bash
npm install
```
5. Create the credential key for your project on Google Cloud Console, download the key and update the key path on serverless.yml
6. Deploy the Serverless Instance
```bash
serverless deploy
```

## Comparison
![](https://r3dw0lfsec.in/assets/img/blog/cloudsecurity/serverlesscomputing/7.png)

## Security Risks in Serverless Computing
1. **Function Event-Data Injection**: Serverless functions can consume input form different types of event sources. Various parts of these event sources may contain user-controlled or untrusted inputs that should be carefully inspected.
2. **Broken Authentication**: Applications may contain dozens or even hundreds of functions. Applying robust authentication can easily go awry if not executed carefully.
3. **Serverless Business Logic Manipulation**: Serverless applications are unique as they often follow the micro-services design and contain numerous functions chained together to form overall logic. Without proper enforcement, attackers may be able to tamper with intended logic.
4. **Insecure Application  Secrets Storage**: In Serverless application secrets such as Credentials, API Key etc. may be stored in a plain text configuration file that may be accessible to the end user and in some cases these credentials will be in plain text, as environment variables.
5. **Improper Exception Handling and Verbose Error Messages**: Serverless computing provides line-by-line debugging options for applications. As a result, developers frequently adopt the use of verbose error messages, which may leak sensitive data.

Happy Hacking!
{:.lead}