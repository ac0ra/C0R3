# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=(python2_{5,6,7})
PYTHON_REQ_USE="xml"

inherit versionator distutils-r1

DESCRIPTION="Pure-Python library for performing client operations using the WBEM CIM-XML protocol."
HOMEPAGE="http://pywbem.sf.net/"
SRC_URI="mirror://sourceforge/project/${PN}/${PN}/${PN}-$(get_version_component_range 1-2)/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="twisted"

DEPEND=""
RDEPEND="twisted? (
	dev-python/twisted
	dev-python/twisted-web
)
"
