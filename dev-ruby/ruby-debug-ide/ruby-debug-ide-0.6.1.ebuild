# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

USE_RUBY="ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="An interface which glues ruby-debug to IDEs"
HOMEPAGE="https://github.com/ruby-debug/ruby-debug-ide"
RDEPEND="
	dev-ruby/rake
	dev-ruby/debase
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
