# homelab

Personal homelab configuration. All these notes are for everyone interested but mostly for myself to keep track of what I've done so far.

- [1. Hardware](#hardware)
- [1. Software](#software)
- [1. Installation and management](#installation-and-management)


## Hardware

### Current specifications

__Networking__

**Switch:** TP-Link TL-SG608E Manageable version
**Router:** Dell Wyse 3040 2Gb RAM 16Gb eMMC ([Debian 13 Trixie](https://www.debian.org/download))

__Services hosts__

**Server1:** [Dell Optiplex 3050 Micro i5-6500T 16Gb RAM](https://www.hardware-corner.net/desktop-models/Dell-OptiPlex-3050M/) ([Debian 13 Trixie](https://www.debian.org/download))
**Server2:** [HP EliteDesk 800 G3 Mini i5-7500T (vPro) 8Gb RAM](https://www.hardware-corner.net/desktop-models/HP-EliteDesk-800-G3-Mini/) ([Debian 13 Trixie](https://www.debian.org/download))
**(Soon) Server3 (NAS):** In search of a Lenovo Tiny and a small SSD Bay

### Network scheme 

Router-on-a-stick because the Wyse only has one ethernet interface.

```ascii
         +------------+
         | ISP Router |
         | VLAN 1 WAN |
         +------+-----+
                |
Port 1 (VLAN 1) |
         +------+-----+
         |  Switch    |
         +--+-----+--+
     Port 2 |     | Port 3/4
(VLAN 1,10) |     | (VLAN 10)
            |     | 
   +--------+     +-------+
   | Router |     |Server1|
   +--------+     +-------+ 
                  |Server2|       
                  +-------+       
```

### Switch configuration

> [!NOTE]
> VLAN 802.1q

| Switch Port | Plugged-in | VLAN        | VLAN Name(s) |
|-------------|------------|-------------|--------------|
| 1           | ISP Router | 1 untagged  | WAN          |
| 2           | Router     | 1,10 tagged | WAN,LAN      |
| 3           | Server1    | 10 untagged | LAN          |
| 4           | Server2    | 10 untagged | LAN          |

### Router configuration

## Software

__Router__
- [dnsmasq | DNS + DHCP](https://en.wikipedia.org/wiki/Dnsmasq)
- [cloudflared | Tunneling via Cloudflare (TODO)](https://github.com/cloudflare/cloudflared)
- [? | Reverse-proxy (TODO)]()

## Installation and management

### Network

#### VLANs

In order to isolate the homelab from the ISP DHCP range, I've set up VLANs in the first place.
I've configured the VLANs as untagged first on the router machine port to be able to SSH.
Then I configured new vlan interfaces on the router's ifupdown configuration to get it understand tagged vlan in an ansible playbook and restarted it.

> [!NOTE]
> I had also to change the PVID of 802.1q to 10 for the corresponding ports in the switch configuration.

#### DHCP | dnsmasq

> [!NOTE]
> [/etc/dnsmasq.conf example](https://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob;f=dnsmasq.conf.example;hb=HEAD)

In the first place I've set up DHCP on the .10 vlan virtual interface using [dnsmasq with this config](./ansible/roles/dnsmasq/templates).

### Orchestration

#### Kubernetes (k0s)

> [!CAUTION]
> Version installed: [v0.28.0](https://github.com/k0sproject/k0sctl/releases/tag/v0.28.0) for amd64

I use [k0sctl](https://k0sproject.io/) for managing the cluster configuration.

For network connectivity and observability, I decided to change from kuberouter to [cilium](https://docs.cilium.io/en/stable/installation/k0s/).

#### Notes to myself

Installed on the controller via:
```shell
sudo wget https://github.com/k0sproject/k0sctl/releases/download/v0.28.0/k0sctl-linux-amd64 -P /usr/local/bin
sudo mv /usr/local/bin/k0sctl-linux-amd64 /usr/local/bin/k0sctl
sudo chmod +x /usr/local/bin/k0sctl
```

For Cilium, there is a generated kubeconfig file at ~/.kube/k0s-mycluster.config (and exists as a env variable).


