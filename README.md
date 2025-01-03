# MOTD :robot:

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/5bec09878ee4444fbfcd862f8a5afeb8)](https://www.codacy.com/app/marshki/MOTD?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/MOTD&amp;utm_campaign=Badge_Grade)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)

Drop-in Bash script for a [message-of-the day](https://en.wikipedia.org/wiki/Motd_(Unix)) in an interactive shell. 

Open to all, but tailored to rigs in NYU's departments of [Neural Science](http://www.cns.nyu.edu/), [Psychology](http://as.nyu.edu/psychology.html), 
and [The Center for Brain Imaging](http://as.nyu.edu/cbi.html).

Tested to run on GNU/Linux (CentOS, Debian, Ubuntu) and currently-supported versions of macOS. 

Sample output: 

                             )            
                            (__        -----------------------
                            _  )_      < CBI//CNS//PSYCH TEK >
                           (_)_(_)     -----------------------
                            (o o)  _ _/
                           ==\o/== 

    HOSTNAME(FQDN)................: pipy
    LAST LOGIN....................: pi pts/0 172.22.114.145 Tue Feb 7 16:40 still logged in
    UPTIME........................: 373 days 11
    LOAD AVGS.....................: 0.11, 0.18, 0.17 (1 min 5 mins 15 mins)
    RUNNING PROCESSES.............: 84 (total)
    MEMORY USAGE..................: 0 0 (used unused)
    DISK USAGE....................: 7.6G 3.5G 3.8G 49% (size used avail capacity)
    IP ADDRESS....................: 172.22.114.85 
    MAC ADDRESS...................: b8:27:eb:05:6a:c7

## Getting Started 

**In Debian:** place `motd.sh` in: `/etc/profile.d` with: `cp -v motd.sh /etc/profile.d`
and set permissions on the file: `sudo chmod -v 755 /etc/profile.d/motd.sh` 

**In macOS:** place `motd.sh` in: `.bash_profile`, e.g.: `cat motd.sh > ~/.bash_profile`. 

**In Ubuntu:** you may want to disable the "Message-of-the-Day" files in: `/etc/update-motd.s`. To view these messages: 
`sudo run-parts /etc/update-motd.d`. To disable them: `sudo chmod -v 644 /etc/update-motd.d/*`. 
(You can revert these changes with: `sudo chmod -v 744 /etc/update-motd.d/*` if needed).

You may also want to disable the last login message generated by the `sshd_config` file. To do so, edit the file with, e.g.: 
`sudo vi /etc/ssh/sshd_config` and then do `:/PrintLastLog` to search for the line, change `yes` to `no`, and save your edits.   

Then place `motd.sh` in: `/etc/profile.d` with: `cp -v motd.sh /etc/profile.d` 
and set permissions on the file: `sudo chmod -v 755 /etc/profile.d/motd.sh`. 

## History 
v.0.1 14-JUN-2018

## License 
[LICENSE](https://github.com/marshki/MOTD/blob/master/LICENSE). 
