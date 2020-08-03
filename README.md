# Challenge Task

In this challenge I have configured the following resources on AWS:

- an VPC (**main-vpc**) with two subnets (**public-a** and **public-b**)
- two EC2 instances (ubuntu): **Server 0** and **Server 1** 
- an ELB that connect to the instances: **challenge-elb**
- a security group allowing **ssh** from anywhere and allowing **http** from ELB to the instances: **elb** and **allow-challenge**
- an internet gateway (**main-gw**)
- route tables to subnets (**route-public-a** and **route-public-b**)  be accessible from internet for ssh.

## Programs and versions used
Here are some requirements the you should have in order to success on running my challenge files.

- Terraform v0.12.18
-- provider.aws v3.0.0
--	provider.null v2.1.2
- ansible 2.9.6
- python 3.8.2

## Key Pair
In order to connect to the instances we should generate a key pairs. This can be used to connect via ssh command or by ansible. This became the proccess more secure. The name of key pair should be **mykey** and be moved to keys folder above the **.tf** directory or you will need to change manually this at *vars.tf* file

    $ mkdir keys
    $ ssh-keygen -f keys/mykey -t rsa -N ''

*The parameter -N '' is used to accept empty passphrase.*

## Steps to run

As you have all the requirements, you should run terraform to construct the AWS resources. Then, the last terraform script will call an **ansible palybook** in order to configure the two instances (Server 0 and Server 1) with nginx as reverse-proxy, docker and the docker container *bharathshetty4/supermario* 

So, in the directory that have terraform files (*.tf), you can run these commands on a terminal: 

    $ export AWS_ACCESS_KEY="YOUR KEY"
    $ export AWS_SECRET_KEY="YOUR SECRET KEY"
     
    $ terraform init
    $ terraform plan (optional)
    $ terraform apply --auto-approve

## Output

    $ ./apply.sh apply --auto-approve
    null_resource.waiting_instances_became_ready: Creating...
    null_resource.waiting_instances_became_ready: Provisioning with 'local-exec'...
    null_resource.waiting_instances_became_ready (local-exec): Executing: ["/bin/sh" "-c" "sleep 120;export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ansible/hosts  --key-file keys/mykey -u ubuntu ansible/playbook.yml; rm -f ansible/hosts"]
    aws_key_pair.mykeypair: Creating...
    aws_vpc.main: Creating...
    aws_key_pair.mykeypair: Creation complete after 0s [id=mykeypair]
    aws_vpc.main: Creation complete after 4s [id=vpc-0abdceda867b99e24]
    aws_subnet.public-a: Creating...
    aws_security_group.elb-securitygroup: Creating...
    aws_internet_gateway.main-gw: Creating...
    aws_subnet.public-b: Creating...
    aws_subnet.public-b: Creation complete after 2s [id=subnet-0123029c10304b85a]
    aws_subnet.public-a: Creation complete after 2s [id=subnet-005cb2a3c5262d63f]
    aws_internet_gateway.main-gw: Creation complete after 2s [id=igw-03747101c04804bd6]
    aws_route_table.route-public: Creating...
    null_resource.waiting_instances_became_ready: Still creating... [10s elapsed]
    aws_security_group.elb-securitygroup: Creation complete after 4s [id=sg-0da6bfaa88f45ea93]
    aws_security_group.allow-challenge: Creating...
    aws_route_table.route-public: Creation complete after 2s [id=rtb-0e008eb48c7e92805]
    aws_route_table_association.route-public-b: Creating...
    aws_route_table_association.route-public-a: Creating...
    aws_route_table_association.route-public-a: Creation complete after 1s [id=rtbassoc-0a29e5464128b26a7]
    aws_route_table_association.route-public-b: Creation complete after 1s [id=rtbassoc-08a41c773c385f62b]
    aws_security_group.allow-challenge: Creation complete after 4s [id=sg-039221842aadb632c]
    aws_instance.server[0]: Creating...
    aws_instance.server[1]: Creating...
    null_resource.waiting_instances_became_ready: Still creating... [20s elapsed]
    aws_instance.server[0]: Still creating... [10s elapsed]
    aws_instance.server[1]: Still creating... [10s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [30s elapsed]
    aws_instance.server[0]: Still creating... [20s elapsed]
    aws_instance.server[1]: Still creating... [20s elapsed]
    aws_instance.server[1]: Provisioning with 'local-exec'...
    aws_instance.server[1] (local-exec): Executing: ["/bin/sh" "-c" "echo  54.171.127.150 >> ansible/hosts"]
    aws_instance.server[1]: Creation complete after 24s [id=i-033293ae552d4ef68]
    aws_instance.server[0]: Provisioning with 'local-exec'...
    aws_instance.server[0] (local-exec): Executing: ["/bin/sh" "-c" "echo  52.30.129.97 >> ansible/hosts"]
    aws_instance.server[0]: Creation complete after 24s [id=i-003f2f9dab7b3f9db]
    aws_elb.challenge-elb: Creating...
    null_resource.waiting_instances_became_ready: Still creating... [40s elapsed]
    aws_elb.challenge-elb: Creation complete after 6s [id=challenge-elb]
    null_resource.waiting_instances_became_ready: Still creating... [50s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m0s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m10s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m20s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m30s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m40s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [1m50s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [2m0s elapsed]
    
    null_resource.waiting_instances_became_ready (local-exec): PLAY [all] *********************************************************************
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Gathering Facts] *********************************************************
    null_resource.waiting_instances_became_ready (local-exec): ok: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): ok: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Update apt-get repo and cache] *******************************************
    null_resource.waiting_instances_became_ready: Still creating... [2m10s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Install python pip3] *****************************************************
    null_resource.waiting_instances_became_ready: Still creating... [2m20s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [2m30s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [2m40s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Instaling nginx latest version] ******************************************
    null_resource.waiting_instances_became_ready: Still creating... [2m50s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Starting  nginx] *********************************************************
    null_resource.waiting_instances_became_ready (local-exec): ok: [52.30.129.97]
    null_resource.waiting_instances_became_ready (local-exec): ok: [54.171.127.150]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Copy the nginx config file (reverse proxy)] ******************************
    null_resource.waiting_instances_became_ready: Still creating... [3m0s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Create symlink (reverse proxy)] ******************************************
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Restart nginx] ***********************************************************
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Install docker.io] *******************************************************
    null_resource.waiting_instances_became_ready: Still creating... [3m10s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [3m20s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Starting docker] *********************************************************
    null_resource.waiting_instances_became_ready (local-exec): ok: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): ok: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Install Docker Module for Python] ****************************************
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Pull bharathshetty4/supermario Docker image] *****************************
    null_resource.waiting_instances_became_ready: Still creating... [3m30s elapsed]
    null_resource.waiting_instances_became_ready: Still creating... [3m40s elapsed]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Copy the supermario startup script to systemd] ***************************
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    
    null_resource.waiting_instances_became_ready (local-exec): TASK [Starting supermario] *****************************************************
    null_resource.waiting_instances_became_ready (local-exec): changed: [52.30.129.97]
    null_resource.waiting_instances_became_ready (local-exec): changed: [54.171.127.150]
    
    null_resource.waiting_instances_became_ready (local-exec): PLAY RECAP *********************************************************************
    null_resource.waiting_instances_became_ready (local-exec): 52.30.129.97               : ok=14   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    null_resource.waiting_instances_became_ready (local-exec): 54.171.127.150             : ok=14   changed=11   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
    
    null_resource.waiting_instances_became_ready: Creation complete after 3m50s [id=7309711536450701643]
    
    Apply complete! Resources: 14 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    URL_to_test = challenge-elb-1340278649.eu-west-1.elb.amazonaws.com

## Testing
Just open a web-browser and point to the output of the **URL_to_test** variable, that you will see as the last output line.

## Checking the load balancer

You can verify at your AWS account to see if all instances are **In Service**  or you can verify using the *host*  commad or using *curl -I -v URL* to check the connected IP address.
 

    $ host challenge-elb-1340278649.eu-west-1.elb.amazonaws.com
    challenge-elb-1340278649.eu-west-1.elb.amazonaws.com has address 52.208.242.165
    challenge-elb-1340278649.eu-west-1.elb.amazonaws.com has address 52.213.224.44
