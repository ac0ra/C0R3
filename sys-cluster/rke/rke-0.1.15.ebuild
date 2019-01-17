# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit versionator

DESCRIPTION="Rancher Kubernetes Engine, (Kubernetes installer)"
HOMEPAGE="https://rancher.com"
if [[ ${PV} == *'_rc'* ]];then
MY_PV=$(replace_version_separator 3 '-')
else
MY_PV=${PV}
fi

SRC_URI="https://github.com/rancher/${PN}/releases/download/v${MY_PV}/${PN} -> rke-${MY_PV}"
#https://github.com/rancher/rke/releases/download/v0.1.12-rc5/rke
KEYWORDS="~amd64"
LICENSE="Apache-2.0"


SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	mkdir ${S}
	cp ${DISTDIR}/rke-${MY_PV} ${S}/rke
}


src_install() {
	dobin rke
}
