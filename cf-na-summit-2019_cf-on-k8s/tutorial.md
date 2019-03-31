# Install CF on GKE

## Introduction

This tutorial will walk you through installing a Cloud Foundry platform solely on GKE.
All necessary infrastructure will also be created.

<walkthrough-tutorial-duration duration="45">
</walkthrough-tutorial-duration>

## Prerequisites

Cloud foundry will be deployed as a subdomain under a given root domain.
Ensure that you have:

- created a GCP DNS Zone for the root zone
- configured the GCP DNS Zone with a registered domain.

## Select a project

Choose the project you want to use with the rest of this tutorial.

<walkthrough-project-setup>
</walkthrough-project-setup>

## Installation

First, fill out the `terraform.tfvalues` configuration.
Afterwards, initialize Terraform:

    terraform init

Now execute the Terraform plan:

    terraform apply -v project_id={{project-id}}

This should take about 30 minutes to complete. Take a ☕ break!

## Login to CF

Your CF installation has been created! Execute the following command to log in:

    cf login --skip-ssl-verify -a $(terraform output cf_api_endpoint) -u admin -p $(terraform output cf_admin_password)

## Deploy an example application

Let's deploy a Hello World application to the Cloud Foundry.
Use the cf CLI:

    cf push hello-world-app

## Cleanup

Terraform can be used to completely wipe the environment. do `terraform destroy -auto-approve`

Would you like to keep this environment? We recommend GitOps.

Run `this command` to create a new Cloud Source Repositories + Cloud Build solution 

## More information

This concludes this tutorial.
Check out these links for more information.
