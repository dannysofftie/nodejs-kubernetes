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

## Dockerize Node.js API

Clone this repo, install dependencies `npm i` and dockerize it `npm run docker-build`. This step is optional as I have dockerized it and available publicly on docker hub [here](https://hub.docker.com/r/dannysofftie/nodejs-kubernetes-api) and ready to be deployed to a kubernetes cluster.

## DNS management

At this point, we have a docker image that is ready to be deployed to a kubernetes cluster.

Before setting up the master and worker nodes, we need to map a domain to one of the droplets (Physical machine or a virtual server. May be an Azure VPS, Amazon EC2, but in this case using Digital Ocean Droplet) IP address which kubernetes will use for it's DNS resolution. This is pretty handy as other servers will use this IP address, or mapped domain name to join the master node.

## Setting up Kubernetes master

As we already installed kubernetes dependencies in all the 3 servers up there, we will choose one to set up kubernetes master node.

Kubernetes provides two different approaches to setting up a highly available kubernetes cluster using `kubeadm`.

1. Stacked control plane nodes,
2. External etcd cluster.

In this set up, we will use the second approach, which requires separated nodes (We have 3 different and separated servers). Control plane nodes are also separated. The first approach requires control plane nodes and etcd members to be on the same server.

### Setting up a loadbalancer in one of the servers

We install dependencies first,

1. Run `sudo apt install linux-headers-$(uname -r)`
2. Run `sudo apt install keepalived`

The load balancer will use `keepalived` to ensure uptime of up to 99.99%
