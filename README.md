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

---

## Defense Checklist

Below is a full defense checklist with commands and links.

### BEFORE

1. Go through the full checklist and confirm everything works.
2. Shut down the VM.
3. Get the SHA1 signature of the VM disk: `sha1sum <name>.vdi`.
4. Put the signature into `signature.txt` at repo root.
5. Push and verify the repo.
6. Finalize and book the defense.

### 0. General Guidelines

1. Check that `signature.txt` exists in the root of the cloned repo.
2. Ensure that the SHA1 in `signature.txt` matches the `.vdi` file of the VM being evaluated.
   Example diff:
   `diff signature.txt <(sha1sum <name>.vdi | awk '{print $1}')`
3. As a precaution, make a copy of the submitted VM image in another directory and run the evaluation on the copy.
4. Make sure no snapshots are used (check in VirtualBox and in files).

### 1. Project Overview

The student must explain in simple words:

1. How a virtual machine works.
   Links:
   https://github.com/ayoub0x1/born2beroot?tab=readme-ov-file
   https://42-cursus.gitbook.io/guide/1-rank-01/born2beroot/whats-a-virtual-machine
2. Why they chose this OS.
   Links:
   https://www.debian.org/
   https://www.debian.org/releases/
3. Main differences between Rocky and Debian.
4. The purpose of virtual machines.
5. If Debian was chosen:
   * difference between `aptitude` and `apt`
   * what AppArmor is
   Check AppArmor status:
   `/usr/sbin/aa-status`
   Link:
   https://42-cursus.gitbook.io/guide/1-rank-01/born2beroot/install-your-virtual-machine
6. During defense the script must print info every 10 minutes. It will be checked later in detail.

### 2. Simple Configuration

1. Ensure no graphical interface is installed (no X.org, Wayland, etc.).
2. At boot you should be asked for a password.
3. Login must be done with a non-root user (student login).
4. Check password policy for the user:
   `chage -l <login>`
5. Check UFW is running:
   `sudo ufw status`
6. Check SSH is running:
   `systemctl status ssh` or `service ssh status`
7. Check OS is Debian or Rocky:
   `cat /etc/os-release` or `head -n 2 /etc/os-release`

### 3. User

1. Student login user exists and is in groups `sudo` and `user42`:
   `id <login>`
   `groups <login>`
   `getent group sudo`
   `getent group user42`

2. Password policy rules are correctly set (subject rules):

* `minlen=10`
* `ucredit=-1`
* `dcredit=-1`
* `lcredit=-1`
* `maxrepeat=3`
* `reject_username`
* `difok=7`
* `enforce_for_root`

2.1 Create a new user and assign a password that matches the policy:

* `sudo adduser testuser`
* `sudo passwd testuser`
* `id testuser`
* `groups testuser`
* `sudo chage -l testuser`

2.2 Student must explain how the password policy was configured. Files to show:

* `/etc/login.defs`
  * `PASS_MAX_DAYS 30`
  * `PASS_MIN_DAYS 2`
  * `PASS_WARN_AGE 7`
* `/etc/pam.d/common-password`
  * After `retry=3`, add the password rules listed above

Also show that `libpam-pwquality` is installed:

* `dpkg -l | grep libpam-pwquality`

3. Create a group named `evaluating` and add the new user to it:

* `sudo addgroup evaluating`
* `sudo adduser testuser evaluating`
* `getent group evaluating`

4. Student must explain advantages and disadvantages of this policy.

### 4. Hostname and Partitions

1. Check hostname format is `login42`:
   `hostname`
2. Change hostname to your login, reboot, check it changed:
   `sudo hostnamectl set-hostname <yourlogin>42`
   `sudo reboot`
   `hostname`
3. Restore original hostname.
4. Show partitions and compare to subject example:
   `lsblk`
5. Student must explain what LVM is and why it is used.

### 5. SUDO

1. Check sudo is installed:
   `dpkg -l | grep sudo`
2. Show how to add a user to `sudo` group:
   `sudo adduser <user> sudo` or `sudo usermod -aG sudo <user>`
3. Show sudo rules in `/etc/sudoers.d/`:

* `passwd_tries=3`
* `badpass_message="<custom-message>"`
* `log_input`
* `log_output`
* `iolog_dir="/var/log/sudo"`
* `requiretty`
* `secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"`

4. Student explains what sudo is and why it is useful.
5. Check `/var/log/sudo/` exists and contains log files:
   `ls /var/log/sudo`
6. Run a sudo command and check logs updated.

### 6. UFW / Firewalld

1. Check firewall is installed and running:
   `sudo ufw status` or `sudo firewall-cmd --state`
2. Show active rules. Port `4242` must be open for SSH.
3. Add a rule for port `8080`:
   `sudo ufw allow 8080`
4. Check rule was added:
   `sudo ufw status numbered`
5. Remove the rule:
   `sudo ufw delete allow 8080`

### 7. SSH

1. Check SSH service is installed and running:
   `systemctl status ssh` or `service ssh status`
2. Check SSH config:
   `/etc/ssh/sshd_config`
   * `Port 4242`
   * `PermitRootLogin no`
3. Student explains what SSH is and why it is used.
4. Check only port `4242` is used:
   `ss -tuln`
5. SSH login with new user:
   `ssh <user>@localhost -p 4242`
6. Ensure root SSH login is disabled.

If SSH key error happens:

* Remove the old key entry in `~/.ssh/known_hosts` for `[localhost]:4242` and retry.

### 8. Monitoring Script

1. Student explains how `monitoring.sh` works (show the code).
2. Student explains what cron is.
3. Show cron entry for root:
   `sudo crontab -u root -e`
   Example line:
   `*/10 * * * * sh /path/to/monitoring.sh`
4. After checking, make it run every minute.
5. Run something like `yes > /dev/null &` to test dynamic values, then `kill %1`.
6. Stop the script without modifying it (comment out cron line).
7. Reboot and confirm:
   * script is still in the same place
   * permissions are unchanged
   * script was not modified

Script must display:

* OS architecture and kernel version
* Number of physical CPUs
* Number of virtual CPUs
* Available RAM and % used
* Available disk space and % used
* CPU usage %
* Last reboot date and time
* LVM status
* Number of active connections
* Number of users
* IP and MAC address
* Number of sudo commands

### 9. Bonus

Bonus points are awarded for extra services. Typical bonus setup:

1. Disk partitions setup (LVM) is worth 2 points.
   Command:
   `lsblk`

2. WordPress stack (2 points): **lighttpd + MariaDB + PHP**.
   Install and configure:

* `sudo apt install lighttpd`
* `sudo ufw allow 80`
* `sudo apt install wget zip`
* `cd /var/www`
* `sudo wget https://wordpress.org/latest.zip`
* `sudo unzip latest.zip`
* `sudo mv html/ html_old/`
* `sudo mv wordpress/ html`
* `sudo chmod -R 755 html`

   MariaDB:

* `sudo apt install mariadb-server`
* `dpkg -l | grep mariadb-server`
* `sudo mariadb_secure_installation`
* `mariadb`
* `CREATE DATABASE wp_database;`
* `CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'strong_password';`
* `GRANT ALL PRIVILEGES ON wp_database.* TO 'wp_user'@'localhost';`
* `FLUSH PRIVILEGES;`
* `exit`
* `mariadb -u wp_user -p`
* `SHOW DATABASES;`

   PHP:

* `sudo apt install php-cgi php-mysql`
* `dpkg -l | grep php`
* `cd /var/www/html`
* `cp wp-config-sample.php wp-config.php`
* Edit `wp-config.php` with DB name, user, password
  Example reference:
  https://github.com/Vikingu-del/Born2beRoot/raw/main/photos/bonus/underlinedtochange.png
* `sudo lighty-enable-mod fastcgi`
* `sudo lighty-enable-mod fastcgi-php`
* `sudo service lighttpd force-reload`

   Student should explain:

* Lighttpd is a lightweight web server.
* WordPress is a PHP app.
* MariaDB stores the data.

3. Free-choice service (1 point). Example: FTP (vsftpd).

   Install and configure FTP:

* `sudo apt install vsftpd`
* `dpkg -l | grep vsftpd`
* `sudo ufw allow 21`
* `sudo nano /etc/vsftpd.conf`
  * Enable: `write_enable=YES`
  * Enable: `chroot_local_user=YES`
* Create FTP directories:
  * `sudo mkdir /home/<user>/ftp`
  * `sudo mkdir /home/<user>/ftp/files`
  * `sudo chown nobody:nogroup /home/<user>/ftp`
  * `sudo chmod a-w /home/<user>/ftp`
* In `/etc/vsftpd.conf` add:
  * `user_sub_token=$USER`
  * `local_root=/home/$USER/ftp`
* Edit user list:
  * `sudo nano /etc/vsftpd.userlist`
  * `sudo nano /etc/vsftpd.userlist_deny`
  * Set in config:
    * `userlist_enable=YES`
    * `userlist_file=/etc/vsftpd.userlist`
    * `userlist_deny=NO`
* Check service and port:
  * `sudo systemctl status vsftpd`
  * `sudo ss -tuln | grep :21`

   Test FTP:

* `ftp <ip-address>`
* `put text.txt`

Student must explain what the service does and why it is useful.

### Evaluation Questions

Official questions list:
https://42-cursus.gitbook.io/guide/1-rank-01/born2beroot/p2p-evaluation-questions
