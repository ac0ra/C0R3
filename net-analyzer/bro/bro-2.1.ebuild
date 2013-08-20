# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit cmake-utils

DESCRIPTION="An advanced intrusion detection system"
HOMEPAGE="http://bro-ids.org/"
SRC_URI="http://www.bro-ids.org/downloads/release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug perftools +geoip +broctl +broaux +broccoli"

DEPEND="dev-libs/geoip
		dev-libs/openssl
		sys-apps/file
		sys-libs/zlib
		net-libs/libpcap
		dev-lang/swig
		app-shells/bash
		geoip? ( dev-libs/geoip )
		perftools? ( dev-util/google-perftools )"
RDEPEND="$DEPEND"

#src_prepare() {
#	epatch "${FILESDIR}/bro-config-root.patch"
#	epatch "${FILESDIR}/bro-userchanged.patch"
#	epatch "${FILESDIR}/bro-installpackageconfig.patch"
#}

src_configure() {
    mycmakeargs=(
        $(cmake-utils_use geoip USE_GEOIP)
        $(cmake-utils_use perftools USE_PERFTOOLS)
        $(cmake-utils_use broctl INSTALL_BROCTL)
        $(cmake-utils_use broaux INSTALL_AUX_TOOLS)
        $(cmake-utils_use broccoli INSTALL_BROCCOLI)
    )

	mylibchanges="aux/broccoli/src
				  aux/binpac/lib
				  aux/broctl
				  aux/broccoli/bindings/broccoli-ruby
				  aux/broccoli/bindings/broccoli-python
				  aux/broctl/aux/pysubnettree"

    for i in ${mylibchanges};
    do
		einfo "Apply sed changes to ${i}"
        sed -e "s#{CMAKE_INSTALL_PREFIX}/lib/#{CMAKE_INSTALL_PREFIX}/$(get_libdir)/#" \
		    -e "s#PY_MOD_INSTALL_DIR lib/#PY_MOD_INSTALL_DIR $(get_libdir)/#" \
		    -e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
            -i "${i}/CMakeLists.txt"
    done

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dosym "/var/spool/bro/broctl-config.sh" "/usr/share/broctl/scripts/broctl-config.sh"
	setcap cap_net_raw,cap_net_admin=eip "${D}/usr/bin/bro"
}
