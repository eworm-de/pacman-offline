pacman-offline
==============

**Run offline system update with pacman.**

The offline system update with pacman is achieved by integrating into
[offline updates in systemd](https://www.freedesktop.org/software/systemd/man/systemd.offline-updates.html#/etc/system-update).
In fact only two scripts and a number of systemd unit files are used to
glue `systemd` and `pacman`.

Requirements
------------

There are the runtime dependencies:

* [pacman](https://archlinux.org/pacman/)
* [systemd](https://www.github.com/systemd/systemd)

Optional basic support for
[plymouth](https://www.freedesktop.org/wiki/Software/Plymouth/) is
integrated.

Usage
-----

A single command `pacman-offline` is used to prepare the offline update.
It accepts some arguments:

* *-c*: clean before download
* *-f*: force if other system-update is pending
* *-h*: show help
* *-r*: reboot and install immediately
* *-t*: start timer for nightly reboot
* *-y*: update sync databases

Configuration
-------------

A sinppet for inclusion in `/etc/pacman.conf` is shipped. To make use of
it add this line:

    Include = /etc/pacman.d/offline.conf

It will cause `pacman` to ignore linux packages and prevent breaking module
loading. These packages are not ignored on offline update.

Modify `/etc/pacman.d/offline.conf` to your needs by changing or adding
packages.

### Upstream

URL:
[GitHub.com](https://github.com/eworm-de/pacman-offline#pacman-offline)

Mirror:
[eworm.de](https://git.eworm.de/cgit.cgi/pacman-offline/)
[GitLab.com](https://gitlab.com/eworm-de/pacman-offline#pacman-offline)
