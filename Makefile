# commands
INSTALL	:= install
LN	:= ln
MD	:= markdown
RM	:= rm
SED	:= sed

# this is just a fallback in case you do not
# use git but downloaded a release tarball...
VERSION := 0.0.4

all: README.html

%.html: %.md
	$(MD) $< > $@
	$(SED) -i 's/\(README[-[:alnum:]]*\).md/\1.html/g' $@

install:
	$(INSTALL) -D -m0755 bin/pacman-offline $(DESTDIR)/usr/bin/pacman-offline
	$(INSTALL) -D -m0644 systemd/pacman-offline.service $(DESTDIR)/usr/lib/systemd/system/pacman-offline.service
	$(INSTALL) -D -m0755 systemd/pacman-offline $(DESTDIR)/usr/lib/systemd/scripts/pacman-offline
	$(INSTALL) -D -m0644 systemd/pacman-offline-prepare.service $(DESTDIR)/usr/lib/systemd/system/pacman-offline-prepare.service
	$(INSTALL) -D -m0644 systemd/pacman-offline-prepare.timer $(DESTDIR)/usr/lib/systemd/system/pacman-offline-prepare.timer
	$(INSTALL) -d -m0755 $(DESTDIR)/usr/lib/systemd/system/system-update.target.wants/
	$(LN) -s ../pacman-offline.service $(DESTDIR)/usr/lib/systemd/system/system-update.target.wants/pacman-offline.service

clean:
	$(RM) -f README.html

release:
	git archive --format=tar.xz --prefix=pacman-offline-$(VERSION)/ $(VERSION) > pacman-offline-$(VERSION).tar.xz
	gpg -ab pacman-offline-$(VERSION).tar.xz
