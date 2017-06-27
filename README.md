#Simple Terraform Example

##Prerequisites

You need to have the AWS command line tools installed and configured.

[Installation
Guide](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

[Configuration](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

Terraform will read your AWS credentials from the .aws folder that is created.

##Assumptions

These examples assume an AWS account with several individual IAM users
authorized.  We tag each instance with several common tags to enable
everyone to see who owns each instance and what it's purpose is.

##Simple One/Few Server Example

The terraform file specifies one (count=1) EC2 instance.  Change the value of count to create mutliple servers of the same type.  The default
region is us-east-2 (Ohio) but can be changed.  Likewise this calls
for a specific AMI and instance type, which can also be changed.

This example shows how to tag the instance with some common tags.  You
can edit these to fit your specific purposes.  The "Name" tag is what
will show in the AWS console so it's highly recommended to use it.
This example allows you to pass your username in on the command line
and it will automatically use that in the tags.

NOTE: similar to Vagrant the terraform tool works using the data in
the current working directory.  So you need to be in the folder that
holds the .tf file.  Terraform will create several files to hold state
information as it works.  DO NOT delete those files.

###Test Your Configuration using the PLAN command

To use this simple config, do this:

```
cd simple
TF_VAR_UNAME="<your username>" terraform plan
```

You should see something that looks similar to this:

```
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

The Terraform execution plan has been generated and is shown below.
Resources are shown in alphabetical order for quick scanning. Green resources
will be created (or destroyed and then created if an existing resource
exists), yellow resources are being changed in-place, and red resources
will be destroyed. Cyan entries are data sources to be read.

Note: You didn't specify an "-out" parameter to save this plan, so when
"apply" is called, Terraform can't guarantee this is what will execute.

+ aws_instance.test
    ami:                          "ami-8b92b4ee"
    associate_public_ip_address:  "<computed>"
    availability_zone:            "<computed>"
    ebs_block_device.#:           "<computed>"
    ephemeral_block_device.#:     "<computed>"
    instance_state:               "<computed>"
    instance_type:                "t2.micro"
    ipv6_address_count:           "<computed>"
    ipv6_addresses.#:             "<computed>"
    key_name:                     "<computed>"
    network_interface.#:          "<computed>"
    network_interface_id:         "<computed>"
    placement_group:              "<computed>"
    primary_network_interface_id: "<computed>"
    private_dns:                  "<computed>"
    private_ip:                   "<computed>"
    public_dns:                   "<computed>"
    public_ip:                    "<computed>"
    root_block_device.#:          "<computed>"
    security_groups.#:            "<computed>"
    source_dest_check:            "true"
    subnet_id:                    "<computed>"
    tags.%:                       "4"
    tags.Name:                    "gherlein-test"
    tags.function:                "testing"
    tags.owner:                   "gherlein"
    tags.project:                 "personal"
    tenancy:                      "<computed>"
    volume_tags.%:                "<computed>"
    vpc_security_group_ids.#:     "<computed>"


Plan: 1 to add, 0 to change, 0 to destroy.
```

If youd did not see this, you made an error editing the file.  Please
go fix that.

###Create the Resource using the APPLY command

You can then actually create the resources in AWS using the "apply"
command.

```
cd simple
TF_VAR_UNAME="<your username>" terraform apply
```

The resource will be created in AWS.

###See the State of the Resource using the SHOW command

You can see the status of the resource using the "show" command

```
cd simple
TF_VAR_UNAME="<your username>" terraform show

aws_instance.test:
  id = i-0dd8c8e25d73ad27c
  ami = ami-8b92b4ee
  associate_public_ip_address = true
  availability_zone = us-east-2a
  disable_api_termination = false
  ebs_block_device.# = 0
  ebs_optimized = false
  ephemeral_block_device.# = 0
  iam_instance_profile =
  instance_state = running
  instance_type = t2.micro
  ipv6_addresses.# = 0
  key_name =
  monitoring = false
  network_interface.# = 0
  network_interface_id = eni-85d5c6ed
  primary_network_interface_id = eni-85d5c6ed
  private_dns = ip-172-31-15-6.us-east-2.compute.internal
  private_ip = 172.31.15.6
  public_dns = ec2-13-58-50-79.us-east-2.compute.amazonaws.com
  public_ip = 13.58.50.79
  root_block_device.# = 1
  root_block_device.0.delete_on_termination = true
  root_block_device.0.iops = 100
  root_block_device.0.volume_size = 8
  root_block_device.0.volume_type = gp2
  security_groups.# = 0
  source_dest_check = true
  subnet_id = subnet-64403c0d
  tags.% = 4
  tags.Name = gherlein-test
  tags.function = testing
  tags.owner = gherlein
  tags.project = personal
  tenancy = default
  volume_tags.% = 0
  vpc_security_group_ids.# = 1
  vpc_security_group_ids.2830017738 = sg-d73b03be
```

###Destroying the Resource using the DESTROY command

When you no longer need the resource you can destroy it like this:

```
cd simple
TF_VAR_UNAME="<your username>" terraform destroy

Do you really want to destroy?
  Terraform will delete all your managed infrastructure.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_instance.test: Refreshing state... (ID: i-0dd8c8e25d73ad27c)
aws_instance.test: Destroying... (ID: i-0dd8c8e25d73ad27c)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 10s elapsed)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 20s elapsed)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 30s elapsed)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 40s elapsed)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 50s elapsed)
aws_instance.test: Still destroying... (ID: i-0dd8c8e25d73ad27c, 1m0s elapsed)
aws_instance.test: Destruction complete

Destroy complete! Resources: 1 destroyed.
```




