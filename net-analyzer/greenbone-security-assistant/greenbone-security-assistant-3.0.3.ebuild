# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

inherit cmake-utils

DESCRIPTION="Greenbone Security Assistant for openvas"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/1158/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=net-analyzer/openvas-libraries-5
	dev-libs/libxslt
	net-libs/libmicrohttpd"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ChangeLog CHANGES README"

CMAKE_IN_SOURCE_BUILD=1

src_prepare() {
	sed -i \
		-e 's:-Werror::g' \
		CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	doinitd "${FILESDIR}"/gsad
}
