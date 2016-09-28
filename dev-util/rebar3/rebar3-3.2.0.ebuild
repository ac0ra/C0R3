# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit bash-completion-r1

DESCRIPTION="A sophisticated build-tool for Erlang projects that follows OTP principles"
HOMEPAGE="https://github.com/erlang/rebar3"
SRC_URI="https://github.com/erlang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
DOCS=( "rebar.config.sample" "THANKS" ) 

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND=">=dev-lang/erlang-15.2.3"
DEPEND="${RDEPEND}"

src_compile() {
	./bootstrap
}

src_install() {
	default

	dobin rebar3

	dobashcomp priv/shell-completion/bash/$PN

	insinto /usr/share/zsh/site-functions
	doins priv/shell-completion/zsh/_$PN
}
