# commands
INSTALL	:= install
LN	:= ln
MD	:= markdown
RM	:= rm
SED	:= sed

# this is just a fallback in case you do not
# use git but downloaded a release tarball...
VERSION := 0.3.2

all: README.html

%.html: %.md
	$(MD) $< > $@
	$(SED) -i 's/\(README[-[:alnum:]]*\).md/\1.html/g' $@

install: install-bin install-doc

install-bin:
	$(INSTALL) -D -m0755 bin/pacman-offline $(DESTDIR)/usr/bin/pacman-offline
	$(INSTALL) -D -m0644 config/offline.conf $(DESTDIR)/etc/pacman.d/offline.conf
	$(INSTALL) -D -m0644 hook/99-pacman-offline.hook $(DESTDIR)/usr/share/libalpm/hooks/99-pacman-offline.hook
	$(INSTALL) -D -m0644 polkit/pacman-offline.rules $(DESTDIR)/usr/share/polkit-1/rules.d/pacman-offline.rules
	$(INSTALL) -D -m0644 systemd/pacman-offline.service $(DESTDIR)/usr/lib/systemd/system/pacman-offline.service
	$(INSTALL) -D -m0755 systemd/pacman-offline $(DESTDIR)/usr/lib/systemd/scripts/pacman-offline
	$(INSTALL) -D -m0644 systemd/pacman-offline-prepare.service $(DESTDIR)/usr/lib/systemd/system/pacman-offline-prepare.service
	$(INSTALL) -D -m0644 systemd/pacman-offline-prepare.timer $(DESTDIR)/usr/lib/systemd/system/pacman-offline-prepare.timer
	$(INSTALL) -D -m0644 systemd/pacman-offline-reboot.service $(DESTDIR)/usr/lib/systemd/system/pacman-offline-reboot.service
	$(INSTALL) -D -m0644 systemd/pacman-offline-reboot.timer $(DESTDIR)/usr/lib/systemd/system/pacman-offline-reboot.timer
	$(INSTALL) -d -m0755 $(DESTDIR)/usr/lib/systemd/system/system-update.target.wants/
	$(LN) -s ../pacman-offline.service $(DESTDIR)/usr/lib/systemd/system/system-update.target.wants/pacman-offline.service

install-doc: README.html
	$(INSTALL) -D -m0644 README.md $(DESTDIR)/usr/share/doc/pacman-offline/README.md
	$(INSTALL) -D -m0644 README.html $(DESTDIR)/usr/share/doc/pacman-offline/README.html

clean:
	$(RM) -f README.html

release:
	git archive --format=tar.xz --prefix=pacman-offline-$(VERSION)/ $(VERSION) > pacman-offline-$(VERSION).tar.xz
	gpg --armor --detach-sign --comment pacman-offline-$(VERSION).tar.xz pacman-offline-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=pacman-offline-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign --comment pacman-offline-$(VERSION).tar | git hash-object -w --stdin) $(VERSION)
