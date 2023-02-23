# Unified collator spin up

## Overview
The main goal is to provide production-ready deployment for the Collator node that could work for any parachain with very few adjustments.

There are a lot of parachains in the substrate ecosystem, and each of them has its guide on how to spin up a collator node. Most of those guides are just examples of how to start a collator for testing purposes and are not production-ready. That complicates life for those who want to manage collators for several parachains because each new parachain requires an entirely new setup. This project aims to pack a common part of infrastructure and Collator node deployment into functional building blocks that could be used with any parachain and make it highly extendable and configurable for each specific case.

Every collator node has common steps to run it that are not depend on concrete parachain:
- Build
- Containerize
- Terraform infrastructure
- Deploy

## Project Details
Project aims to provide reproducible and configurable infrastructure via terraforming one of the supported clouds. In most cases, Collator nodes have similar requirements on infrastructure, but in case of special requirements, it would be pretty easy to configure terraform scripts for the needs.

Project aims to provide confgurability is a deployment step which would be handled by ansible scripts. We would provide unified deployment with configuration for the relay chain and common Collator parameters.

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
Further instruction of AWS deployment are [here](AWS/README.md)

## GCP
Further instruction of GCP deployment are [here](GCP/README.md)
