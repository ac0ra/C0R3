# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-administrator)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/987/${P}.tar.gz"

SLOT="4"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="app-crypt/gpgme
	>=dev-libs/glib-2
	net-libs/gnutls
	net-libs/libpcap
	net-analyzer/openvas-libraries"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs=(-OPENVAS_LOCALSTATE_DIR=/var -OPENVAS_SYSCONF_DIR=/etc -DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	find ${S} -name "*.txt" -type f | xargs  sed -i "s/target_link_libraries (openvasad/target_link_libraries (openvasad glib-2.0 openvas_base/g" || die "sed failed"
	cmake-utils_src_configure || die
}

src_compile() {
	mycmakeargs=(-OPENVAS_LOCALSTATE_DIR=/var -OPENVAS_SYSCONF_DIR=/etc -DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc)
	cmake-utils_src_compile || die
}

src_install() {
	cmake-utils_src_install || die
	doinitd "${FILESDIR}"/openvasad || die
}
