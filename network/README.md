# Network Terraform Configuration

This configuration sets up a simple AWS network architecture that includes:

- **Two VPCs**:
  - **Public VPC**
  - **Private VPC**

- **Subnets**:
  - Each VPC contains two subnets, one in Availability Zone A and one in Availability Zone B.

- **Transit Gateway**:
  - A Transit Gateway is provisioned to interconnect the Public and Private VPCs.
  - Appropriate route tables in each VPC are configured to enable bidirectional communication between the VPCs.

> **Note:** All network details like CIDR blocks and other related configurations are stored in the `locals.tf` file for easy customization.
