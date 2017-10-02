# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
DESCRIPTION="Pyspread is a cross-platform Python spreadsheet application. It is based on and written in the programming language Python."
HOMEPAGE="http://pyspread.sourceforge.net/"
SRC_URI="https://github.com/manns/pyspread/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DEPEND="
>=dev-python/numpy-1.1.0
>=dev-python/wxpython-2.8.10.1
>=dev-python/matplotlib-1.1.1
>=dev-python/pycairo-1.8.8
>=dev-python/xlrd-0.9.2
>=dev-python/xlwt-0.9.2
>=dev-python/jedi-0.8.0
"
RDEPEND=""

src_install() {
	rm -f ${WORKDIR}/pyspread-${PV}/{INSTALL,README,changelog,pyspread.bat,runtest.py,README.rst}
	rm -f ${WORKDIR}/pyspread-${PV}-python2_7/lib/{README,changelog,pyspread.bat,runtests.py}
	distutils-r1_src_install
}


