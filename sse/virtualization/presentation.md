class: center
## Virtualization with OpenStack

.height_8em[[![Virtualization](vmw-virtualization-defined.jpg)](http://www.vmware.com/virtualization/virtualization-basics/how-virtualization-works)]

### Chris Wilson, AfNOG 2015

You can access this presentation at: http://afnog.github.io/sse/virtualization/
([edit](https://github.com/afnog/sse/firewalls/virtualization.md))

---
## What will we do?

.fill[[![OpenStack Havana Architecture](openstack_havana_conceptual_arch.png)](http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_overview.html)]

---
## Why are we doing it?

Rapid deployments

* Redundancy
* Fault tolerance
* Scalability
* Managed by [Juju](https://jujucharms.com/)

???

Juju can provision virtual machines (nodes) on:

* commercial providers (e.g. EC2)
* our OpenStack cluster
* bare metal (MAAS)

---
## How will we do it?

* Create 3 virtual machines (nodes)
* Install Ubuntu
* Install OpenStack "Kilo" components
  * Roughly following the instructions at:
    http://docs.openstack.org/kilo/install-guide/install/apt/content/index.html
* Requirements: A PC with 4 GB RAM, 20 GB free disk space

**Warning:** the procedure described here is highly customised for this demonstration. For a real deployment you should follow
the installation guide linked above.

???
The setup is complicated because we're using three virtual machines and networking them together. In real life it would be simpler,
but we don't have enough computers for everyone!

Take heart that it might be the last time you ever need to configure Apache and NTP by hand!

---
## Install VirtualBox

* You can find installers and packages at: https://www.virtualbox.org/wiki/Downloads

---
## Create Networks

.fill[[![Minimal architecture example with OpenStack Networking (neutron)—Network layout](installguidearch-neutron-networks.png)](http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html)]

---
## Create Networks

Open *Settings > Network*:

.height_8em[![Adding NAT networks](add-networks.png)]

* Create four NAT networks:
  * "External" - 10.196.1.0/24
  * "Management" - 10.196.2.0/24
  * "Tunnel" - 10.196.3.0/24
  * "Storage" - 10.196.4.0/24

---
## Create a Virtual Machine

* Named "OpenStack Compute 1"
  * One of our three nodes, the Compute Node
* Allocate 1024 MB RAM, 20 GB disk space
  * Name the disk image "Trusty OpenStack"
* Configure network devices:
  * Interface 1: Management
  * Interface 2: Tunnel
  * Interface 3: Storage

---
## Install Ubuntu

* Do not install updates yet!
* Normally would use the server edition and drive from command line
* In a virtual machine, the GUI makes it easier to manage (until SSH is up)

---
## Enable cache

Start the virtual machine and log in.

Check that you can ping the Apt cache server:

	$ ping mini1.sse.ws.afnog.org
	PING mini1.sse.ws.afnog.org (197.4.15.144): 56 data bytes
	64 bytes from 197.4.15.144: icmp_seq=0 ttl=63 time=1.434 ms

Sudo edit `/etc/apt/apt.conf.d/01proxy` and add:

	Acquire::http::Proxy "http://196.200.219.2:3142";

---
## Install the Kilo repository

Sudo edit `/etc/apt/sources.list.d/cloudarchive-kilo.list` and add:

	deb http://ubuntu-cloud.archive.canonical.com/ubuntu trusty-updates/kilo main

Then execute:

	$ sudo apt-get update
	$ sudo apt-get install ubuntu-cloud-keyring ntp openssh-server nano
	$ sudo apt-get dist-upgrade

And shut down the machine.

---
## Share the disk

Use Virtual Media Manager to:

* Release the disk (detach from virtual machine)
* Modify > Multi-attach

Then reattach to virtual machine:

* Settings > Storage > Controller: SATA
* Click *Add new attachment* icon below
* Choose *Add hard disk*
* *Choose existing disk*
* Choose the *Trusty Openstack* disk image

---
## Create the Controller Node

1024 MB RAM, use existing disk image.

Configure network devices:
* Interface 1: Management

---
## Create the Network Node

1024 MB RAM, use existing disk image.

Configure network devices:

* Interface 1: Management
* Interface 2: Tunnel
* Interface 3: External
  * Change the *Promiscuous Mode* to *Allow all*

---
## Hostnames and IP addresses

* Start all three virtual machines (nodes)
* Change their hostnames to be unique:
  * controller.local
  * network.local
  * compute1.local
* Note their IP addresses on all interfaces (networks)

---
## Setup port forwarding

* Open *VirtualBox Settings > Network > External*
* Click on the screwdriver (to the right)
* Click *Port Forwarding*
* Add entries named after the machine plus "SSH"
* Set local port to:
  * "2201" for the controller node
  * "2202" for network
  * "2203" for compute 1
* Set guest IP to the host IP address on management network
* Set guest port to 22

???
Forward local ports to each of your node's management IPs, for easier remote management.
---

## Setup port forwarding

.fill[![Adding port forwarding](port-forwarding.png)]

---
## Connect with SSH

Start SSH sessions in three separate terminals to:

* Controller: localhost port 2201
* Network: localhost port 2202
* Compute: localhost port 2203

You should be able to:

* see them all
* identify which is which
* switch easily between them.

---
## Create /etc/hosts

Normally you would set up DNS entries for all machines. In a test environment it's easier to use a `hosts` file.

Create a `hosts` file with the name of each node and its **management** interface address:

	127.0.0.1	localhost
	10.196.1.x	controller.local
	10.196.1.y	network.local
	10.196.1.z	compute1.local

Copy this file to each computer, replacing its original `/etc/hosts`.

---
## Verify connectivity

Check that each node can ping the Internet and all other nodes:

	$ ping 8.8.8.8
	$ ping controller.local
	$ ping network.local
	$ ping compute1.local

---
## Follow the instructions

Start following the OpenStack Kilo installation guide:

* Choose a password and use it for everything ending in `PASS`.
* Start from the [Network Time Protocol](http://docs.openstack.org/kilo/install-guide/install/apt/content/ch_basic_environment.html#basics-ntp) step.
* Skip the *OpenStack packages* step, already done.
* Check carefully which node to run each command on.
* Remember to prefix most commands with `sudo`.

---
## Identity Service

Read all about the [Identity Service](http://docs.openstack.org/kilo/install-guide/install/apt/content/keystone-concepts.html). It's very important.

Shell redirects don't work with `sudo`, so:

* Either become `root` (bad practice), or
* Replace `>` with `| sudo tee` (and `>>` with `| sudo tee -a`)

Also, when the instructions say `controller`:

* You should write the controller' hostname:
* `controller.local`

And use the password instead of generating a token with `openssl rand -hex 10`.

---
## Configuring Apache

The instructions are out of date:

There is no `ServerName` line in `/etc/apache2/apache2.conf`

So add one at the end:

	ServerName controller.local

---
## Testing Keystone

After installing Keystone:

* Add a port forwarding for port 8001 to your controller IP port 80
* Check that you can access http://localhost:8001

You should see some JSON data like this:

	{"versions": {"values": [{"status": "stable", "updated": ...

---
## Openstack authentication

`openstack` commands are authenticated by token, not Unix user id.

So you don't need to `sudo openstack` ever. For example:

	chris@controller:~$ openstack service create --name keystone --description "OpenStack Identity" identity

---
## Project List command

The guide contains a mistake in the `project list` command:

	$ openstack --os-auth-url http://controller.local:35357   --os-project-name admin --os-username admin --os-auth-type password   project list
	Password: 
	WARNING: keystoneclient.auth.identity.base Failed to contact the endpoint at http://controller:35357/v2.0 for discovery. Fallback to using that endpoint as the base url.

To fix it, add the following options to the command:

	--os-project-domain-id default --os-user-domain-id default

---
## Image Service

The guide doesn't specify, so install this service on the Controller node.

When *Verifying operation of the Image service*, don't download the image file
with `wget`. You should find it in the files supplied on the USB stick, to save
the download time (and our bandwidth).

---
class: center, middle, inverse

## FIN

Any questions?
