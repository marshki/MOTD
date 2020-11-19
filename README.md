# MOTD

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5bec09878ee4444fbfcd862f8a5afeb8)](https://www.codacy.com/app/marshki/MOTD?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/MOTD&amp;utm_campaign=Badge_Grade)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

Drop-in Bash script for a [message-of-the day](https://en.wikipedia.org/wiki/Motd_(Unix)) in an interactive shell. 

Open to all, but tailored to rigs in NYU's departments of [Neural Science](http://www.cns.nyu.edu/), [Psychology](http://as.nyu.edu/psychology.html), 
and [The Center for Brain Imaging](http://as.nyu.edu/cbi.html).

Tested to run on GNU/Linux (CentOS, Debian, Ubuntu) and currently-supported versions of macOS. 

![ALT text](https://github.com/marshki/MOTD/blob/master/docs/motd.png "motd")

## Getting Started 

**In CentOS 7:** place `motd.sh` in: `/etc/profile.d` with: `cp -v motd.sh /etc/profile.d` 
and set permissions on the file: `sudo chmod -v 755 /etc/profile.d/motd.sh`  

**In Debian 8:** place `motd.sh` in: `/etc/profile.d` with: `cp -v motd.sh /etc/profile.d`
and set permissions on the file: `sudo chmod -v 755 /etc/profile.d/motd.sh` 

**In macOS:** place `motd.sh` in: `.bash_profile`, e.g.: `cat motd.sh > ~/.bash_profile`. 

**In Ubuntu 16.04:** you may want to disable the "Message-of-the-Day" files in: `/etc/update-motd.s`. To view these messages: 
`sudo run-parts /etc/update-motd.d`. To disable them: `sudo chmod -v 644 /etc/update-motd.d/*`. 
(You can revert these changes with: `sudo chmod -v 744 /etc/update-motd.d/*` if needed).

You may also want to disable the last login message generated by the `sshd_config` file. To do so, edit the file with, e.g.: 
`sudo vi /etc/ssh/sshd_config` and then do `:/PrintLastLog` to search for the line, change `yes` to `no`, and save your edits.   

Then place `motd.sh` in: `/etc/profile.d` with: `cp -v motd.sh /etc/profile.d` 
and set permissions on the file: `sudo chmod -v 755 /etc/profile.d/motd.sh`. 

## History 
v.0.1 2018092

## License 
[LICENSE](https://github.com/marshki/MOTD/blob/master/LICENSE). 
