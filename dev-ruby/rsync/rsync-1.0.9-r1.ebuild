# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ipaddress/ipaddress-0.8.0.ebuild,v 1.2 2012/08/13 22:01:07 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ruby20 ruby21 ree18 jruby ruby22 ruby23 ruby24"

inherit ruby-fakegem

DESCRIPTION="A library that can syncronize files between remote hosts by wrapping a call to the rsync binary."
HOMEPAGE="https://github.com/jbussdieker/ruby-rsync"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/rsync"
