# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )
DISTUTILS_SINGLE_IMPL=1

inherit git-r3 distutils-r1

DESCRIPTION="pip script installer"
HOMEPAGE="https://github.com/mitsuhiko/pipsi"
SRC_URI=""
EGIT_REPO_URI="https://github.com/mitsuhiko/pipsi.git"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="${PYTHON_DEPS}
>=dev-python/click-6.6[${PYTHON_USEDEP}]
>=dev-python/virtualenv-15.1.0[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

