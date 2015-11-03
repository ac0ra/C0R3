# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 eutils perl-module

EGIT_REPO_URI="https://github.com/alexrj/Slic3r.git"
DESCRIPTION="A mesh slicer to generate gcode for 3D fused-filament-fabrication"
HOMEPAGE="http://www.slic3r.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+gui minimal test"

RDEPEND="
	>=dev-perl/Encode-Locale-1.50.0
	dev-perl/IO-stringy
	>=dev-perl/Math-PlanePath-53.0.0
	>=dev-perl/Moo-1.3.1
	virtual/perl-Carp
	virtual/perl-File-Spec
	virtual/perl-Getopt-Long
	virtual/perl-parent
	virtual/perl-Scalar-List-Utils
	virtual/perl-Thread-Semaphore
	>=virtual/perl-threads-1.960.0
	virtual/perl-Time-HiRes
	virtual/perl-XSLoader
	gui? (
		dev-perl/Class-Accessor
		virtual/perl-Math-Complex
		>=dev-perl/wxperl-0.991.800
		dev-perl/Module-Pluggable
		>=virtual/perl-Socket-2.16.0
	)
	!minimal? (
		dev-perl/libwww-perl
		dev-perl/XML-SAX
		dev-perl/XML-SAX-Base
		gui? (
			dev-perl/Net-Bonjour
			dev-perl/OpenGL
			dev-perl/Wx-GLCanvas
		)
	)
"

DEPEND="${RDEPEND}
	>=dev-perl/ExtUtils-CppGuess-0.70.0
	>=dev-perl/ExtUtils-Typemaps-Default-1.50.0
	>=dev-perl/ExtUtils-XSpp-0.170.0
	>=dev-perl/Module-Build-WithXSpp-0.140.0
	>=virtual/perl-ExtUtils-ParseXS-3.220.0
	>=dev-perl/Module-Build-0.380.0
	test? (
		virtual/perl-Test-Harness
		virtual/perl-Test-Simple
	)
	"

# Optional but not yet packaged:
#		gui? (
#			dev-perl/Growl-GNTP
#				note, needs dev-perl/Net-DBus too
#		)

SRC_TEST="do"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.9-adjust_var_path.patch

	pushd xs &>/dev/null
	perl-module_src_prepare
	popd &>/dev/null
}

src_configure() {
	# This should provide info on possible missing deps but it doesnt work properly
	#SLIC3R_NO_AUTO=1 perl Build.PL --gui

	pushd xs &>/dev/null
	perl-module_src_configure
	popd &>/dev/null
}

src_compile() {
	pushd xs &>/dev/null
	perl-module_src_compile
	popd &>/dev/null
}

src_test() {
	#prove -Ixs/blib/arch -Ixs/blib/lib/ xs/t/ || die "Tests failed on Slic3r::XS"

	pushd xs &>/dev/null
	perl-module_src_test
	popd &>/dev/null

	prove -Ixs/blib/arch -Ixs/blib/lib/ t/ || die "Tests failed on Slic3r"
}

src_install() {
	pushd xs &>/dev/null
	perl-module_src_install
	popd &>/dev/null

	insinto "${VENDOR_LIB}"
	doins -r lib/Slic3r.pm lib/Slic3r

	insinto "${VENDOR_LIB}"/Slic3r
	doins -r var

	exeinto "${VENDOR_LIB}"/Slic3r
	doexe slic3r.pl

	dosym "${VENDOR_LIB}"/Slic3r/slic3r.pl /usr/bin/slic3r.pl

	make_desktop_entry slic3r.pl \
		Slic3r \
		"${VENDOR_LIB}/Slic3r/var/Slic3r_128px.png" \
		"Graphics;3DGraphics;Engineering;Development"
}
