# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/eudev/eudev-9999.ebuild,v 1.64 2014/11/29 12:32:23 blueness Exp $

EAPI="5"

inherit eutils multilib

SRC_URI="
x86? ( http://dl.slic3r.org/linux/slic3r-linux-x86-${PV//\./-}-stable.tar.gz )
amd64? ( http://dl.slic3r.org/linux/slic3r-linux-x86_64-${PV//\./-}-stable.tar.gz )
"

KEYWORDS="~amd64 ~x86"

DESCRIPTION="A mesh slicer to generate gcode for 3D fused-filament-fabrication"
HOMEPAGE="http://slic3r.org"

LICENSE="LGPL-2.1 MIT GPL-2"
SLOT="0"
IUSE=""

S=${WORKDIR}

src_install() {
	insinto /usr/$(get_libdir)
	doins -r Slic3r
	exeinto /usr/$(get_libdir)/Slic3r/bin
	doexe Slic3r/bin/slic3r
	dosym /usr/$(get_libdir)/Slic3r/bin/slic3r /usr/bin/slic3r

        make_desktop_entry slic3r \
		Slic3r-bin \
		"/usr/$(get_libdir)/Slic3r/res/Slic3r_128px.png" \
		"Graphics;3DGraphics;Engineering;Development"
}
