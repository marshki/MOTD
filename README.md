# MOTD :robot:
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5bec09878ee4444fbfcd862f8a5afeb8)](https://www.codacy.com/app/marshki/MOTD?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/MOTD&amp;utm_campaign=Badge_Grade)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

Drop-in Bash script for a [message-of-the day](https://en.wikipedia.org/wiki/Motd_(Unix)) in an interactive shell.

Open to all, but tailored to rigs at [New York University's](https://www.nyu.edu/):
 - [Neural Science](https://as.nyu.edu/departments/cns.html)
 - [Psychology](https://as.nyu.edu/departments/psychology.html)
 - [The Center for Brain Imaging](https://as.nyu.edu/research-centers/cbi.html)

Sample output:

                             )
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/==

    HOSTNAME(FQDN)................: pywype.psych.nyu.edu
    LAST LOGIN....................: pi pts/0 10.27.0.162 Thu Jan 16 12:10 still logged in
    UPTIME........................: 2 min 1
    LOAD AVGS.....................: 0.78, 0.78, 0.34 (1 min 5 mins 15 mins)
    RUNNING PROCESSES.............: 89 (total)
    MEMORY USAGE..................: 39 41 (used unused)
    DISK USAGE....................: 7.1G 4.0G 2.8G 60% (size used avail capacity)
    IP ADDRESS....................: 172.22.114.85
    MAC ADDRESS...................: b8:27:eb:05:6a:c7

## Getting Started 
Notes: 
------
**motd**: A read-only file, located at: `/etc/motd`.

**motd.sh**: An executable shell script, placed in `/etc/profile.d`.

For changes to take effect, you may need to do one (1) of the following:

- open a new terminal window

- logout/login

- restart the ssh service

Instructions by OS:
-------------------
**In Debian, Ubuntu (global)**:

Place the contents of `motd.sh` in: `/etc/update-motd.d/00-welcome` by creating the file, e.g.:

- `sudo cat motd.sh > /etc/update-motd.d/00-welcome`

Make the file executable with:

- `sudo chmod +x /etc/update-motd.d/00-welcome`

Modify: `sshd_config` file, changing: `#PrintLastLog yes` to: `PrintLastLog no`, by backing up the file, then editing it:

- `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak`

- `sudo sed -i 's/#PrintLastLog yes/PrintLastLog no/g' /etc/ssh/sshd_config`

Restart the `ssh service` with: 

- `sudo systemctl restart sshd`

**In macOS (per user)**:

Place `motd.sh` in: `.bash_profile`, e.g.:

- `cat motd.sh >> ~/.bash_profile`

then source the file:

- `source ~/.bash_profile`

**In Red Hat Enterprise Linux (RHEL) (global)**:

Place `motd.sh` in: `/etc/profile.d`, e.g.:

- `cp -v motd.sh > /etc/profile.d/`

Set permisisons on the file:

- `chmod 755 /etc/profile.d/motd.sh`

## History 
v.0.1 14-JUN-2018

v.0.2 16-JAN-2024

## License 
[LICENSE](https://github.com/marshki/MOTD/blob/master/LICENSE).
