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

### Network installation

#### VLANs

In order to isolate the homelab from the ISP DHCP range, I've set up VLANs in the first place.
I've configured the VLANs as untagged first on the router machine port to be able to SSH.
Then I configured new vlan interfaces on the router's ifupdown configuration to get it understand tagged vlan in an ansible playbook and restarted it.

#### DHCP + DNS | dnsmasq

> [!NOTE]
> [/etc/dnsmasq.conf example](https://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob;f=dnsmasq.conf.example;hb=HEAD)




