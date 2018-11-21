# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit versionator

DESCRIPTION="The Rancher Command Line Interface (CLI)"
HOMEPAGE="https://rancher.com"
if [[ ${PV} == *'_rc'* ]];then
MY_PV=$(replace_version_separator 3 '-')
else
MY_PV=${PV}
fi
S="${WORKDIR}/rancher-v${MY_PV}"

SRC_URI="https://github.com/rancher/cli/releases/download/v${MY_PV}/rancher-linux-amd64-v${MY_PV}.tar.xz"
KEYWORDS="~amd64"
LICENSE="Apache-2.0"


SLOT="0"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""


src_install() {
	dobin ${S}/rancher
}
