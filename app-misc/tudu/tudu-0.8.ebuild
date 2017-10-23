# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="3"

inherit eutils

DESCRIPTION="Command line interface to manage hierarchical todos"
HOMEPAGE="http://code.meskio.net/tudu/"
SRC_URI="http://code.meskio.net/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses[unicode]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_install() {
	emake \
		DESTDIR="${D}" \
		INSTALL_PROGRAM='/usr/bin/install -m 755' \
		install || die
	dodoc AUTHORS README ChangeLog CONTRIBUTORS || die
}
