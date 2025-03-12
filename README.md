# AWS Infrastructure Terraform Configurations

This repository contains a set of separate Terraform configurations for provisioning AWS infrastructure. Each configuration corresponds to a specific layer in your environment and is arranged in a pyramid-style dependency model. This structure ensures that foundational components, such as networking, are set up first, allowing higher layers (security, compute, data, and application) to build on top of them seamlessly.

---

## Overview

The repository is organized into the following layers:

- **Network Layer:**  
  Configurations for VPCs, subnets, route tables, NAT gateways, VPNs, etc.  
  *This is the foundational layer and must be applied first.*

- **Security Layer:**  
  Configurations for IAM roles, policies, security groups, and other security-related settings.

- **Compute Layer:**  
  Configurations for EC2 instances, Auto Scaling Groups, ECS clusters, Lambda functions, and more.

- **Data/Storage Layer:**  
  Configurations for RDS, DynamoDB, S3, EFS, and other data storage solutions.

- **Application Layer:**  
  Configurations for load balancers, API Gateways, deployment pipelines, and additional application services.

Each configuration is designed with clear input and output variables, allowing the outputs from lower layers to be easily consumed by higher layers.

---

## Repository Structure

.
├── network
│   ├── vpc
│   ├── subnets
│   ├── route-tables
│   ├── nat-gateway
│   └── vpn
├── security
│   ├── iam
│   ├── security-groups
│   └── ...
├── compute
│   ├── ec2
│   ├── autoscaling
│   ├── ecs
│   └── lambda
├── data
│   ├── rds
│   ├── dynamodb
│   ├── s3
│   └── efs
└── application
    ├── alb
    ├── apigateway
    └── deployment

Each folder contains a complete Terraform configuration that can be applied independently. Start with the **Network Layer** to set up the foundational infrastructure, then move upward through the layers, ensuring that each configuration consumes the outputs of the preceding layer as needed.

---

This structure helps maintain clear separation of concerns while ensuring the dependencies between infrastructure components are met during deployment.
