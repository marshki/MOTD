# MOTD :robot:
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5bec09878ee4444fbfcd862f8a5afeb8)](https://www.codacy.com/app/marshki/MOTD?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/MOTD&amp;utm_campaign=Badge_Grade)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

Drop-in Bash script for a [message-of-the day](https://en.wikipedia.org/wiki/Motd_(Unix)) in an interactive shell.

Open to all, but tailored to rigs at [New York University's](https://www.nyu.edu/):
 - [The Center for Brain Imaging](https://as.nyu.edu/research-centers/cbi.html)
 - [The Center for Neural Science](https://as.nyu.edu/departments/cns.html)
 - [Department of Psychology](https://as.nyu.edu/departments/psychology.html)

Sample output:
```

                             )
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/==

HOSTNAME(FQDN)................: pywype.psych.nyu.edu
DATE..........................: Sunday, November 22, 2026 12:11 EST
UPTIME........................: 49d 9h 56m
LOAD AVERAGES.................: 0.12 0.06 0.06 (1, 5, 15 min)
RUNNING PROCESSES.............: 89 (total)
MEMORY USAGE..................: 91Mi used, 33Mi unused
DISK USAGE....................: 7.1G total, 4.4G used, 2.4G available (66% used)
IP ADDRESS....................: 172.22.114.85
MAC ADDRESS...................: b8:27:eb:05:6a:c7#
```

# motd

Drop-in Bash script for a [message of the day](https://en.wikipedia.org/wiki/Motd_(Unix)) in an interactive shell.

Open to all, but tailored to rigs at [New York University](https://www.nyu.edu/):

* [Neural Science](https://as.nyu.edu/departments/cns.html)
* [Psychology](https://as.nyu.edu/departments/psychology.html)
* [The Center for Brain Imaging](https://as.nyu.edu/research-centers/cbi.html)

## Sample output

```
<!-- paste current output from a real rig here -->
```

## Supported systems

Currently supported releases of:

* macOS
* Ubuntu (LTS)
* Debian
* Raspberry Pi OS
* Red Hat Enterprise Linux (RHEL)

Requires Bash 3.2 or later. The script runs on stock macOS Bash, so it avoids Bash 4+ features.
On other systems it prints what it can and shows `n/a` for the rest.

## Installation

Pick the method for your system. Each one runs the script at login; none of them source it into your shell.

### Debian, Ubuntu, Raspberry Pi OS (global)

`update-motd.d` runs on SSH login:

```bash
sudo install -m 755 motd /etc/update-motd.d/00-welcome
```

### RHEL (global)

RHEL has no `update-motd.d`, so a `profile.d` hook runs the script for interactive shells:

```bash
sudo install -m 755 motd /usr/local/bin/motd
echo 'case $- in *i*) /usr/local/bin/motd ;; esac' | sudo tee /etc/profile.d/motd.sh
```

### macOS (per user)

```bash
sudo mkdir -p /usr/local/bin
sudo install -m 755 motd /usr/local/bin/motd
echo '/usr/local/bin/motd' >> ~/.zprofile
```

macOS uses zsh by default. If you use Bash, add the line to `~/.bash_profile` instead.

Open a new terminal window or log in again to see the message.

## Notes

* **Last login** isn't part of this script. sshd already shows it for each user (`PrintLastLog yes`, the default), so leave that setting on.
* The static `/etc/motd` file, if present, is separate and is shown alongside this output.

## License

MIT

## History
v.0.1 14-JUN-2018

v.0.2 16-JAN-2024

## License
[LICENSE](https://github.com/marshki/MOTD/blob/master/LICENSE).
