# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit toolchain-funcs

DESCRIPTION="Converts Apple DMG files to standard HFS+ images"
HOMEPAGE="http://vu1tur.eu.org/tools"
SRC_URI="http://vu1tur.eu.org/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-libs/openssl:0=
	app-arch/bzip2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_prepare() {
	eapply -p1 "${FILESDIR}"/openssl11_compat.patch
	sed -i -e 's:-s:$(LDFLAGS):g' Makefile || die "sed failed"
	eapply_user
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dobin dmg2img vfdecrypt
	dodoc README
	doman vfdecrypt.1
}
