pacman-offline
==============

**Run offline system update with pacman.**

The offline system update with pacman is achieved by integrating into
[offline updates in systemd](https://www.freedesktop.org/software/systemd/man/systemd.offline-updates.html).
In fact only two scripts and a number of systemd unit files are used to
glue `systemd` and `pacman`.

Requirements
------------

There are the runtime dependencies:

* [pacman](https://archlinux.org/pacman/)
* [systemd](https://www.github.com/systemd/systemd)

And there's an optional dependency to support elevating privileges:

* [polkit](https://github.com/polkit-org/polkit)

Optional basic support for
[plymouth](https://www.freedesktop.org/wiki/Software/Plymouth/) is
integrated.

Usage
-----

A single command `pacman-offline` is used to prepare the offline update.
It accepts some arguments:

* *-a*: abort pending system-update
* *-c*: clean before download
* *-f*: force if other system-update is pending
* *-h*: show help
* *-p*: reboot, install and poweroff immediately
* *-r*: reboot and install immediately
* *-t*: start timer for nightly reboot
* *-y*: update sync databases

### Elevating privileges

The privileges are elevated automatically if `polkit` is installed. This works
with no authentication if your user is member of the group `wheel`. To add your
user to that group run:

    usermod --append --groups wheel user

If your user is not member of that group you will be asked for a password.

### Timer for preparation

You can enable a timer to prepare the offline update automatically.

    systemctl enable pacman-offline-prepare.timer

This will trigger several minutes after boot, then ever day. The databases
are synced, then packages are downloaded. The updates are installed when
ever the system reboots.

### Timer for nightly reboot

You can enable a timer for nightly reboot:

    systemctl enable pacman-offline-reboot.timer

This will trigger at night, if updates are pending and prepared.

Configuration
-------------

A sinppet for inclusion in `/etc/pacman.conf` is shipped. To make use of
it add this line:

    Include = /etc/pacman.d/offline.conf

It will cause `pacman` to ignore linux packages and prevent breaking module
loading. These packages are not ignored on offline update.

Modify `/etc/pacman.d/offline.conf` to your needs by changing or adding
packages.

License and warranty
--------------------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
[GNU General Public License](COPYING.md) for more details.

### Upstream

URL:
[GitHub.com](https://github.com/eworm-de/pacman-offline#pacman-offline)

Mirror:
[eworm.de](https://git.eworm.de/cgit.cgi/pacman-offline/)
[GitLab.com](https://gitlab.com/eworm-de/pacman-offline#pacman-offline)
