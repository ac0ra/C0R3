# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby21 ruby22 ruby23"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_RECIPE_DOC="rdoc"

RUBY_FAKEGEM_EXTRADOC="README.md CHANGELOG.md"

inherit ruby-fakegem

DESCRIPTION="Library of tools for working with Semantic Versions and module dependencies"
HOMEPAGE="https://github.com/puppetlabs/forge-ruby"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/gettext-setup-0.3
dev-ruby/multipart-post
dev-ruby/faraday
dev-ruby/faraday_middleware
dev-ruby/fast_gettext
dev-ruby/locale
dev-ruby/text
dev-ruby/ruby-gettext
dev-ruby/gettext-setup
dev-ruby/semantic_puppet
dev-ruby/archive-tar-minitar"
