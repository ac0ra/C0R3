# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JBIJ_PN_PRETTY='DataGrip'

inherit eutils readme.gentoo-r1

DESCRIPTION='DataGrip is a commercial multi-engine database environment'
HOMEPAGE="http://www.jetbrains.com/pycharm/"
SRC_URI="http://download.jetbrains.com/datagrip/datagrip-${PV}.tar.gz"

LICENSE="PyCharm_Academic PyCharm_Classroom PyCharm PyCharm_OpenSource PyCharm_Preview"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.8
	 dev-python/pip"
DEPEND=""

RESTRICT="mirror strip"

QA_PREBUILT="opt/${PN}/bin/fsnotifier
	opt/${PN}/bin/fsnotifier64
	opt/${PN}/bin/fsnotifier-arm
	opt/${PN}/bin/libyjpagent-linux.so
	opt/${PN}/bin/libyjpagent-linux64.so"

MY_PN=DataGrip
S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	default

	rm -rf jre || die
}

src_install() {
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/{datagrip.sh,fsnotifier{,64},inspect.sh}

	dosym /opt/${PN}/bin/datagrip.sh /usr/bin/${PN}
	newicon "bin/${PN}.png" ${PN}.png
	make_desktop_entry ${PN} "${PN}" "${PN}"

	#readme.gentoo_create_doc
}
