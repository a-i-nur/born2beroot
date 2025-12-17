*This project has been created as part of the 42 curriculum by aakhmeto.*

# Born2beRoot

## Description

Born2beRoot is a system administration project.

The goal is to create and configure a **secure Linux virtual machine** following **strict rules**.
The project focuses on security, users, services, and system monitoring.

During the defense, the student must be able to **explain every choice simply**, as required in the subject.

---

## Instructions

### Installation

1. Create a virtual machine using **VirtualBox**.
2. Install **Debian (stable)** without graphical interface.
3. Configure disk partitions using **LVM**.
4. Install and configure required services: sudo, SSH, UFW.
5. Configure users, groups, and password policy.
6. Add the monitoring script to **cron**.

### Usage

* Connect to the virtual machine using SSH on port **4242**.
* Log in with a user account (not root).
* The monitoring script runs automatically every 10 minutes.

---

## Virtual Machine

* The project is done on a **virtual machine**.
* Virtualization allows running an operating system inside another system.
* It is useful for testing, security, isolation, and server administration.

The virtual machine is created and configured by the student.

---

## Operating System

The chosen operating system is **Debian (stable)**.

### Why Debian

* Stable and reliable
* Easy to use
* Good documentation
* AppArmor available by default

### Debian vs Rocky

* **Debian**: simple, stable, good for learning
* **Rocky Linux**: enterprise-oriented, more complex

---

## Package Management and Security

### apt vs aptitude

* **apt**: basic package manager
* **aptitude**: advanced interface with more features

### AppArmor

* AppArmor is a security module
* It limits what programs can do
* It improves system security

AppArmor is enabled on this virtual machine.

---

## Users and Groups

* A user with the student login exists

* The user belongs to:

  * `sudo`
  * `user42`

* SSH connection as **root is disabled**

---

## Password Policy

The password policy follows the subject rules:

* Password expires every **30 days**
* Minimum **10 characters**
* At least:

  * 1 uppercase letter
  * 1 lowercase letter
  * 1 number
* No more than **3 identical characters in a row**
* Password must not contain the username

The student can explain **why this policy is useful**, with advantages and disadvantages.

---

## SUDO

* `sudo` is installed and configured
* Only authorized users can use sudo
* Sudo rules:

  * Maximum 3 password attempts
  * Custom error message
  * All sudo commands are logged in `/var/log/sudo/`
  * TTY mode enabled
  * Restricted paths

The student can explain **what sudo is**, how it works, and why it is useful.

---

## Firewall (UFW)

* **UFW** is installed and enabled
* The firewall is working correctly
* Only required ports are open

### Rules

* Port **4242** is open for SSH
* A rule can be added and removed (example: port 8080)

The student can explain **what a firewall is** and why it is important.

---

## SSH

* SSH service is installed and running
* SSH uses **only port 4242**
* SSH connection as **root is disabled**
* Login is done with a user account (password or key)

The student can explain **what SSH is** and its purpose.

---

## Monitoring Script

A script called `monitoring.sh` is created.

* It displays system information using `wall`
* It runs every **10 minutes** using **cron**

Displayed information includes:

* OS and kernel
* CPU and RAM usage
* Disk usage
* Last reboot
* LVM status
* Active connections
* Number of users
* IP and MAC address
* Number of sudo commands

The student can explain:

* How the script works
* What `cron` is
* How the script is scheduled

The script can be stopped **without modifying the script itself**, as required in the subject.

---

## Architecture Choices

### Disk Partitions and LVM

* Disk partitions follow the subject example
* **LVM** is used to manage logical volumes

LVM allows flexible disk management and easier resizing.

### Security

* AppArmor is enabled
* SSH root login is disabled
* Firewall is active

### Users

* A main user with the student login exists
* Groups: `sudo`, `user42`

### Services

* SSH (port 4242 only)
* UFW firewall
* Cron for monitoring

---

## Bonus

The bonus part was completed **after** the mandatory part.

* **WordPress** is installed and working
* **FTP service** is installed and working

Each bonus service works correctly and can be explained simply.

---

## Resources

* Debian documentation: [https://www.debian.org/doc/](https://www.debian.org/doc/)
* AppArmor documentation: [https://gitlab.com/apparmor/apparmor](https://gitlab.com/apparmor/apparmor)
* UFW documentation: [https://help.ubuntu.com/community/UFW](https://help.ubuntu.com/community/UFW)
* VirtualBox documentation: [https://www.virtualbox.org/wiki/Documentation](https://www.virtualbox.org/wiki/Documentation)
* LVM HOWTO: [https://tldp.org/HOWTO/LVM-HOWTO/](https://tldp.org/HOWTO/LVM-HOWTO/)

### AI Usage

AI was used only for:

* translating the subject
* structuring the README
* understanding theoretical concepts

AI was **not** used to generate configuration files or commands.

---

## Comparisons

### Debian vs Rocky Linux

* **Debian** is stable, simple, and beginner-friendly.
* **Rocky Linux** is more enterprise-oriented and closer to Red Hat systems.
* Debian is easier to configure for learning system administration.

### AppArmor vs SELinux

* **AppArmor** uses simple profiles based on file paths.
* **SELinux** is more powerful but more complex to configure.
* AppArmor is easier to understand and manage for this project.

### UFW vs firewalld

* **UFW** is simple and easy to use.
* **firewalld** is more flexible and used in enterprise systems.
* UFW is sufficient and clearer for basic firewall management.

### VirtualBox vs UTM

* **VirtualBox** works on most systems and is widely used.
* **UTM** is often used on macOS with Apple Silicon.
* Both allow creating and managing virtual machines, but VirtualBox is more common in the 42 environment.

---

## Conclusion

This project introduces the basics of:

* Virtualization
* Linux system administration
* Security
* User and permission management
* Automation and monitoring

All configurations follow the **Born2beRoot subject requirements**.
