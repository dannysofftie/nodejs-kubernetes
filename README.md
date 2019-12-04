# Deploying a dockerized Node.js app to a highly available kubernetes cluster

## Installing dependencies

This is a step by step guide to deploying a Node.js application with docker, to a highly available kubernetes cluster.

In this guide, we will deploy a simple Node.js application, written in [TypeScript](https://typescriptlang.org), and uses [Fastify](https://fastify.io) as the web framework. It is minimalistic in design, but has a clean architecture to build scalable APIs.

We will deploy to 3 Digital Ocean droplets (Would 3 physical machines).

Below are the tools that we will require to achieve above, install them to follow along:

1.  Node.js, installable from [here](https://nodejs.org/en/download/),
2.  TypeScript, installable from [here](https://www.typescriptlang.org),
3.  Docker, install for Ubuntu 18.04 LTS from [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/). Instructions on how to install for other operating systems can be found on the docs.
4.  Kubernetes, install `kubectl` for Ubuntu 18.04 LTS from [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux),
5.  After adding kubernetes sources from step 5 above, run `sudo apt install kubeadm kubelet kubectl -y` to install required dependencies
6.  If on a local machine, you will require `minikube` to manage your kubernetes cluster. Follow instructions [here](https://kubernetes.io/docs/tasks/tools/install-minikube/) for installation.
7.  Repeat steps 3 to 5 above in the 3 machines (Droplets).

## DNS management

At this point, we have
