# A Portable Cloud Foundry on Kubernetes

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is a demo for installing [Eirini](https://github.com/cloudfoundry-incubator/eirini) on GCP using only Terraform.

This demo was created for the [Cloud Foundry NA Summit 2019](https://www.cloudfoundry.org/event/nasummit2019/).

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/GoogleCloudPlatform/graphite-talks&cloudshell_git_branch=master&cloudshell_image=gcr.io/graphite-cloud-shell-images/cf-on-k8s&cloudshell_working_dir=cf-on-k8s&cloudshell_tutorial=tutorial.md&cloudshell_open_in_editor=terraform.tfvars)

## Our Vision

Over the past few years Kubernetes has grown from being a toy to the platform of choice for large-scale applications in the cloud and on-prem. With its emergence into the mainstream, Kubernetes installs are quickly outpacing CF and the tooling available to operators is evolving at a much faster rate. However, the developer experience of CF remains top-notch. Our vision is to join the two, bringing together the operations experience of Kubernetes and the write once run-anywhere development experience of CF.

By putting everything in Kubernetes, the entire software stack from the infrastructure up is cloud native, but can also work on prem, and can minimize the pain of moving between cloud providers and your existing data centers.

Flattening the stack down to replace BOSH and Diego with Kubernetes means all your applications, data, and platforms run in the same control plane, enabling you to use a unified monitoring, security, and control stack.

## Cloud Foundry Deployment

We combined [SCF](https://github.com/SUSE/scf) with [Project Eirini](https://github.com/cloudfoundry-incubator/eirini) to deploy CF on top of Kubernetes.

SCF containerizes the BOSH releases of Cloud Foundry, allowing them to be deployed to Kubernetes via helm. However, the Diego scheduler is still in use, causing visibility issues and complications due to running containers in containers.

Project Eirini solves this by building and deploying CF apps straight to Kubernetes. The Eirini team provides modified Helm charts for deploying SCF with Eirini at [eirini-release](https://github.com/cloudfoundry-incubator/eirini-release).

### Tooling

- Terraform is used to deploy the Kubernetes cluster.
- Helm is used (via Terraform) to deploy CF to Kubernetes.
- A git repository is used to store the Terraform and Helm configurations.

### Kubernetes Details:

Zoning:
The following namespaces will be used in a Kubernetes cluster:
- `uaa` namespace for UAA
- `scf` namespace for SCF
- `apps` namespace for CF apps

Other namespaces for other components (like service brokers)


## Services

Applications are only half the story. Your applications on CF are likely 12-factor containerized workloads that can scale. That likely isn’t the case with your services or data which might be in multiple clouds, on-prem in specialized VMs, dedicated servers, or mainframes, and in BOSH deployed services.

The benefit of CF is that some of the mechanisms of creating and managing access to some of these services are abstracted away behind service brokers.

### Cloud Services

If you use Azure, GCP, or AWS service brokers today, they also have Helm charts you can install alongside your Eirini cluster. 

[AWS Service Broker](https://github.com/awslabs/aws-servicebroker)
[Azure Open Service Broker](https://github.com/Azure/open-service-broker-azure)
[GCP Service Broker](https://github.com/GoogleCloudPlatform/gcp-service-broker)

The added benefit of using these brokers with Helm is that they also work with the [Kubernetes Service Catalog](https://svc-cat.io/), so you can start to manage services even for traditional applications that were never ported to Cloud Foundry.

### BOSH Deployed Services

You may be using some services directly deployed on top of BOSH today like MySQL or Redis. You can swap these out for Helm deployed services. Helm provides a [catalog of hundreds of production-ready services](https://hub.helm.sh/) for you to use. Even if you prefer the features of hosted versions, giving developers access to these in non-production environments can help cut costs and increase velocity.

[Helm Broker](https://github.com/google/helm-broker)
[Kibosh](https://github.com/cf-platform-eng/kibosh)

### On-Prem Services

There’s a good chance you’re still using some on-prem manually managed services today. These could be organization-wide queues to distribute real-time events, shared databases, or even access to mainframe calls via DB stored procedures.

Traditionally, these services haven’t fit well with the service broker model. But, the GCP Service Broker has recently added support for creating custom-defined services using Terraform modules.

With this, you can bundle up [Terraform providers](https://www.terraform.io/docs/providers/) and templates together and offer them to your developers. For example, you could use the [RabbitMQ provider](https://www.terraform.io/docs/providers/rabbitmq/index.html) to provision read-only users on a shared queue, or mix together a DNS, object store, and JIRA providers to create a storage bucket behind a URL on your company’s domain then creates a JIRA ticket for your security team to set up the proxy.

## Future Work

### Known Improvements

#### Helm in Terraform is difficult
There’s a problem here that DNS records are currently required AFTER the helm deploys of CF. In a perfect world: no extra infrastructure would be needed after helm deploy. This might be possible if we update the helm charts to use GKE load balancers which managed certs, but that’s going to take a lot of legwork given the components of CF

#### Operators
Flux could be used for middleman operator for GitOps Helm https://github.com/weaveworks/flux

#### Combine the UAA and SCF namespaces
Helm: use SuseCF + Project Eirini to install CF into a flat namespace

### Future Stories

There are still a few stories which need to be understood for the vision to be complete.

#### Project Eirini 

We’re committed to making project Eirini the path forward for Cloud Foundry installations. More work is needed to support all CF workloads on Eirini.

#### Multi-site Kubernetes

Kubernetes doesn’t solve the multi-site solution (easily). We need a way for k8s pods to easily communicate with each other, and for workloads to be easily movable from one k8s cluster to another, regardless of location.

Projects have already begun to make this happen:
https://github.com/kubernetes-sigs/federation-v2

## Contact

Here are a few ways to get in contact with the authors:
- Ping `@mattysweeps` on [Cloud Foundry Slack](https://cloudfoundry.slack.com/) or post in the `#gcp` channel
- Email `mattysweeps@google.com` or `jlewisiii@google.com`

