This repository holds a list of talks given by members of Google's Cloud Graphite team. 
The team develops integrations with open source software like Ansible, Cloud Foundry, Elastic, Inspec, and Terraform.

## Cloud Foundry North America 2019

### A Portable Cloud Foundry on Kubernetes

In the past few years Kubernetes has become the de-facto cloud platform, but many until now Cloud Foundry applications haven't been able to take advantage of its benefits. Joseph and Matt have been working on Project Eirini to bring the power of Kubernetes to CF operators. Simultaneously they’ve re-built the GCP Service Broker on Terraform allowing it to provision infrastructure on any major cloud and natively on Kubernetes. Together, these projects let operators deploy Cloud Foundry and application dependencies (databases, caches, etc.) into a self-contained, cloud-agnostic Kubernetes cluster which reduces overhead, increases developer velocity, and returns control of the stack to the business.

* Speakers: Matthew Broomfield, Joseph Lewis III
* [Learn More & Code](https://github.com/GoogleCloudPlatform/graphite-talks/tree/master/cf-on-k8s)

### You got Terraform in my Service Broker

Joseph will introduce Brokerpaks, a way for developers and operators to collaborate in designing their own services with Terraform that they can inject into the Cloud Foundry service catalog. Brokerpaks allow multi-cloud integration, faster turnaround, longer support, and a custom experience you can match to your organization’s structure.

* Speakers: Joseph Lewis III
