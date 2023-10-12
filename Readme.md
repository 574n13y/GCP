# GCP Commands

## Google Cloud Shell & gcloud

## Setup and Requirements

* Confirm that you are authenticated

```
gcloud auth list
```

### Show & active your project

```
gcloud config list project
```

if not, you can set it:

```
gcloud config set project <PROJECT_ID>
```

or 

`export PROJECT_ID=$(gcloud info --format='value(config.project)')`

If you already have selected your project before opening CloudShell.

### Set up your zone

`gcloud config set compute/zone us-west1-b`

## First command line

After Cloud Shell launches, you can use the command line to invoke the Cloud SDK gcloud command or other tools available on the virtual machine instance.

> You can also use your `$HOME` directory in persistent disk storage to store files across projects and between Cloud Shell sessions. Your `$HOME` directory is private to you and cannot be accessed by other users.

* `gcloud -h`
* `gcloud config --help` or `gcloud help config`
* `gcloud config list` or more detailled like `gcloud config list --all`


## Create VPC 
```
gcloud compute networks create stanley-vpc --subnet-mode custom
```
```
gcloud compute networks subnets create stanley-wp --network=stanley-vpc --region us-east1 --range=192.168.16.0/20
```
```
gcloud compute networks subnets create stanley-mgmt --network=stanley-vpc --region us-east1 --range=192.168.32.0/20
```

## Creating VM
```
gcloud compute instances create managementnet-us-vm --zone=us-west3-b --machine-type=e2-micro --subnet=privatesubnet-us --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=privatenet-us-vm
```
```
gcloud compute instances create privatenet-us-vm --zone=us-west3-b --machine-type=e2-micro --subnet=privatesubnet-us --image-family=debian-11 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=privatenet-us-vm
```

## Creating Firewalls 
```
gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
```
```
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
```

## Create bastion host
```
gcloud compute instances create bastion --network-interface=network=stanley-vpc,subnet=stanley-mgmt --network-interface=network=stanley-prod-vpc,subnet=stanley-prod-mgmt --tags=ssh --zone=us-east1-b
```
```
gcloud compute firewall-rules create fw-ssh-dev --source-ranges=0.0.0.0/0 --target-tags ssh --allow=tcp:22 --network=stanley-vpc
```
```
gcloud compute firewall-rules create fw-ssh-prod --source-ranges=0.0.0.0/0 --target-tags ssh --allow=tcp:22 --network=stanley-prod-vpc
```


## Create and configure Cloud SQL Instance
```
gcloud sql instances create stanley-db --root-password password --region=us-east1
gcloud sql connect stanley-db
CREATE DATABASE wordpress;
GRANT ALL PRIVILEGES ON wordpress.* TO "wp_user"@"%" IDENTIFIED BY "stormwind_rules";
FLUSH PRIVILEGES;

exit
```
## Create Kubernetes cluster
```
gcloud container clusters create stanley \
 --network stanley-vpc \
 --subnetwork stanley-wp \
 --machine-type n1-standard-4 \
 --num-nodes 2 \
 --zone us-east1-b
```
gcloud container clusters get-credentials stanley --zone us-east1-b
cd ~/

## Create a WordPress deployment
```
kubectl create -f wp-deployment.yaml
kubectl create -f wp-service.yaml
```


![lab1](https://github.com/574n13y/GCP/assets/35293085/8222bd5c-bdb1-4984-9982-982f1405f39c)
![LAB-NAT](https://github.com/574n13y/GCP/assets/35293085/109a6baa-0c1a-4a7b-9c9e-05599a2eae56)
![LAB mcserver](https://github.com/574n13y/GCP/assets/35293085/3bd14b3e-c486-4d74-ae38-bc4c15f0b980)
![lab mc-server](https://github.com/574n13y/GCP/assets/35293085/5789af22-1cee-466c-83bc-39b9884362c3)
![LAB IAM policies](https://github.com/574n13y/GCP/assets/35293085/0427e1af-44ec-4625-906f-dc313cbcf90e)
![LAB billing bigquerry](https://github.com/574n13y/GCP/assets/35293085/8592b9a9-f4d1-4baf-9707-d54ab0b707e8)
![lab6](https://github.com/574n13y/GCP/assets/35293085/78efb46e-aed2-4af2-a0aa-2d7f1358cf83)
![lab6 1](https://github.com/574n13y/GCP/assets/35293085/825a8988-3a8b-403c-8562-59c15a598a5e)
![lab5](https://github.com/574n13y/GCP/assets/35293085/b05bef5a-7b9e-4838-828e-49a649c84441)
![lab4](https://github.com/574n13y/GCP/assets/35293085/6ff07c28-43c3-40e9-9328-102091b3223a)
![lab3](https://github.com/574n13y/GCP/assets/35293085/c3198b0d-3d3c-4175-967f-4193b57d70b6)
![lab3 2](https://github.com/574n13y/GCP/assets/35293085/392a5133-89ce-4e63-8b69-a0872d87de7e)
![lab3 1](https://github.com/574n13y/GCP/assets/35293085/6ffe45ef-e54e-4d69-8fa2-2ad2ff7a69b7)
![lab2](https://github.com/574n13y/GCP/assets/35293085/73b82ae0-698e-4ae7-a391-ef8334ace7d9)
