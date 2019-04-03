# Install CF on GKE

<walkthrough-author name="mattysweeps"></walkthrough-author>
<walkthrough-author repositoryUrl="https://github.com/GoogleCLoudPlatform/graphite-talks"></walkthrough-author>
<walkthrough-author tutorialName="cloud-graphite-cf-on-k8s"></walkthrough-author>

## Introduction

This tutorial will walk you through installing a Cloud Foundry platform solely on GKE.
All necessary infrastructure will also be created.

<walkthrough-tutorial-duration duration="45"></walkthrough-tutorial-duration>

## Prerequisites

Cloud foundry will be deployed as a subdomain under a given root domain.
Ensure that you have:

- created a GCP DNS Zone for the root zone
- configured the GCP DNS Zone with a registered domain.

## Select a project

Choose the project you want to use with the rest of this tutorial.

<walkthrough-project-setup></walkthrough-project-setup>

## Configuration

All configuration is performed inside the `terraform.tfvalues` file.
Fill out the configuration.

When finished, initalize terraform:
```bash
terraform init
```

Do NOT `terraform apply` yet. There are a few more steps to take before then.

## Deploy a Source Repository

This tutorial uses GitOps best practices to maintain the state of your Cloud Foundry and Kubernetes cluster.
The current directory contains the Terraform config and state files, which should always be maintained in a Git repository.

Run the following command to deploy a new repository from the current directory:

```bash
gcloud config set project {{project-id}} && \
gcloud source repos create cf-on-k8s && \
git config --global user.name "Matthew Broomfield (mattysweeps)" && \
git config --global user.email "mattysweeps@google.com" && \
git config --global credential.https://source.developers.google.com.helper gcloud.sh && \
git init && \
git remote add google https://source.developers.google.com/p/graphite-test-eirini/r/cf-on-k8s && \
git add -A && \
git commit -m "Initial commit" && \
git push --set-upstream google master
```

## Installation

Execute the Terraform plan to deploy Cloud Foundry:

```bash
terraform apply -var project_id={{project-id}}
```

This should take about 30 minutes to complete. Take a ☕ break!

## Commit the Terraform state

Since Cloud Shell workspaces for tutorials are ephemeral, commit the Terraform state:

```bash
git add terraform.tfstate terraform.tfvars && \
git commit -m "Initial deployment" && \
git push
```

## Login to CF

Your CF installation has been created! Execute the following command to log in:

```bash
cf login --skip-ssl-validation -a $(terraform output cf_api_endpoint) -u admin -p $(terraform output cf_admin_password)
```

## Deploy an example application

Let's deploy a Hello World application to the Cloud Foundry.
Use the cf CLI:

```bash
cf create-space demo \
&& cf tagert -s demo \
&& cf push
```

## Optional Cleanup

Terraform can be used to completely wipe the environment. Skip this step if you would like to keep your environment.

```bash
terraform destroy -auto-approve
```

The source repository can also be removed:
```bash
gcloud source repos delete cf-on-k8s
```

## Tutorial Complete

This concludes this tutorial!

