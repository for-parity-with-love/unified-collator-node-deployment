# Unified collator deployment

## Overview
The main goal is to provide production-ready deployment for the Collator node, which could work for any parachain with only a few adjustments.

There are a lot of parachains in the substrate ecosystem, and each of them has its guide on how to spin up a collator node. Most of those guides are just examples of how to start a collator for testing purposes and are not production-ready. That complicates life for those who want to manage collators for several parachains because each new parachain requires an entirely new setup. This project aims to pack a common part of the infrastructure and Collator node deployment into functional building blocks that could be used with any parachain and make it highly extendable and configurable for each specific case.

Every collator node has common steps to run it that are not dependent on concrete parachain:
- Build
- Containerize
- Terraform infrastructure
- Deploy

## Project Details
The project aims to provide reproducible and configurable infrastructure via terraforming one of the supported clouds and one-click deployment. 

In most cases, Collator nodes have similar requirements on infrastructure, but in case of special requirements, it is pretty easy to configure Terraform scripts for your needs.

The same applies to deployment; we provide default good-enough parameters that you can easily adjust for your needs. 

## Components
- Terraform deployment of the Collator infrastructure to the corresponding Cloud
- Terraform scrips for the configurable deployment of a Collator node for different parachains

### Technologies
- Docker as virtualization for the collator node
- Kubernetes as deployment automatization and management of containerized collator
- Terraform as IaC for the reliable and reproducible infrastructure deployment
- Terraform as a deployment automatization tool
- A cloud platform that provides necessary APIs and infrastructure hosting

## Supported clouds

## AWS
Further instructions of AWS deployment is [here](AWS/README.MD)

## GCP
Further instructions of GCP deployment is [here](GCP/README.MD)
