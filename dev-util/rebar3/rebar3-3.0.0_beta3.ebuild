# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 versionator bash-completion-r1

# 3.0.0_beta3 -> 3.0.0-beta.3
MY_PV=$(replace_version_separator 3 '-')
MY_PV="${MY_PV/beta/beta.}"

EGIT_REPO_URI="https://github.com/rebar/${PN}"
EGIT_COMMIT=$MY_PV

DESCRIPTION="A sophisticated build-tool for Erlang projects that follows OTP principles"
HOMEPAGE="https://github.com/rebar/rebar3"
SRC_URI=""

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/erlang"
DEPEND="${RDEPEND}"

src_compile() {
	./bootstrap
}

src_install() {
	dobin rebar3
	dodoc rebar.config.sample THANKS

	dobashcomp priv/shell-completion/bash/${PN}

	insinto /usr/share/zsh/site-functions
	doins priv/shell-completion/zsh/_${PN}
}
