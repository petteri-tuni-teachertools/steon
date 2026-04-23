
# Introduction



## Details

The assumption is that content of the CMDB:s are in /opt/stec-gh/latest-round/1-server-cmdb-submissions folder.
If not, the Centreon service config needs to be changed accordingly.

This loop goes through them all:

````
export GIT_CMDB_DIR=/opt/stec-gh/latest-round/1-server-cmdb-submissions
for dir in `ls $GIT_CMDB_DIR`; do echo $dir - $(./cmdb.sh $GIT_CMDB_DIR/$dir 2>/dev/null); done
````

## Mounting and fetching the data from git

The content from GitHub Classroom is mounted from another server, this is the records.ithou.fi server, year 2026.

````
sudo mount -t nfs 192.168.1.173:/opt/tunigit/gh /mnt/ghclassroom
````

## GitHub classroom commands








## Content example

Example of the content how it should be:

/opt/stec-gh/latest-round/1-server-cmdb-submissions/1-petteri.brown/
├── docs
│   ├── README.md
│   └── server01
│       ├── installed_packages.txt
│       └── system_status.txt
├── README.md
└── servers
    ├── server01
    │   ├── etc
    │   │   ├── apache2
    │   │   │   ├── apache2.conf
    │   │   │   ├── conf-available
    │   │   │   │   └── 99-tamk-web.conf
    │   │   │   ├── conf-enabled
    │   │   │   │   ├── 99-tamk-web.conf
    │   │   │   │   └── security.conf
    │   │   │   └── sites-enabled
    │   │   │       ├── 000-default.conf
    │   │   │       ├── 000-default-le-ssl.conf
    │   │   │       ├── 001-flashcards.conf
    │   │   │       └── 001-flashcards-le-ssl.conf
    │   │   ├── apt
    │   │   │   └── apt.conf.d
    │   │   │       └── 50unattended-upgrades
    │   │   ├── inputrc
    │   │   ├── passwd
    │   │   ├── ssh
    │   │   │   └── sshd_config.d
    │   │   │       └── 60-cloudimg-settings.conf
    │   │   └── sudoers.d
    │   │       └── 91-tamk-users
    │   └── opt
    │       └── server_setup
    │           ├── 01-ufw.sh
    │           ├── 02-apt-install.sh
    │           ├── 02-apt-updates.sh
    │           └── 03-apache.sh
    └── server02

17 directories, 21 files
