# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=4

inherit cmake-utils

DESCRIPTION="A remote security scanner for Linux (openvas-scanner)"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/983/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-4
	!net-analyzer/openvas-plugins
	!net-analyzer/openvas-server"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

# Workaround for upstream bug, it doesn't like out-of-tree builds.
CMAKE_BUILD_DIR="${S}"

src_configure() {
	mycmakeargs="-DLOCALSTATEDIR=/var -DSYSCONFDIR=/etc -DOPENVAS_SYSCONF_DIR=/etc -DOPENVAS_STATE_DIR=/var"
        find ${S} -name "*.txt" -type f | xargs  sed -i "s/target_link_libraries (openvassd/target_link_libraries (openvassd openvas_misc openvas_nasl openvas_hg glib-2.0 openvas_base/g" || die "sed failed"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ChangeLog CHANGES README || die "dodoc failed"
	doinitd "${FILESDIR}"/openvassd || die
}

pkg_postinst() {
	elog "To use openvassd, you first need to:"
	elog "1. Call 'openvas-nvt-sync' to download/update plugins"
	elog "2. Call 'openvas-mkcert' to generate a server certificate"
	elog "3. Call 'openvas-adduser' to create a user"
}

