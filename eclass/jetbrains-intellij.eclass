# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: jetbrains-intellij.eclass
# @MAINTAINER:
# Jan Chren (rindeal) <dev.rindeal+gentoo-overlay@gmail.com>
# @BLURB: Boilerplate for IntelliJ based IDEs
# @DESCRIPTION:

if [ -z "${_JETBRAINS_INTELLIJ_ECLASS}" ] ; then

case "${EAPI:-0}" in
	6) ;;
	*) die "Unsupported EAPI='${EAPI}' for '${ECLASS}'" ;;
esac

inherit eutils versionator xdg

HOMEPAGE="https://www.jetbrains.com/${PN}"
LICENSE="IDEA || ( IDEA_Academic IDEA_Classroom IDEA_OpenSource IDEA_Personal )"

SLOT="$(get_version_component_range 1-2)"
_JBIJ_PN_SLOTTED="${PN}${SLOT}"

# @ECLASS-VARIABLE: JBIJ_URI
: "${JBIJ_URI:="${PN}/${P}"}"

SRC_URI="https://download.jetbrains.com/${JBIJ_URI}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
IUSE="system-jre"
RESTRICT="mirror strip test"

RDEPEND="system-jre? ( >=virtual/jre-1.8 )"


# @ECLASS-VARIABLE: JBIJ_TAR_EXCLUDE

# @ECLASS-VARIABLE: JBIJ_PN_PRETTY
: "${JBIJ_PN_PRETTY:="${PN^}"}"


EXPORT_FUNCTIONS src_unpack src_prepare src_compile pkg_preinst src_install pkg_postinst pkg_postrm


jetbrains-intellij_src_unpack() {
	debug-print-function ${FUNCNAME}

	local A=( $A )
	[ ${#A[@]} -eq 1 ] || die "Your SRC_URI contains too many archives"
	local arch="${DISTDIR}/${A[0]}"

	mkdir -p "${S}" || die
	local tar=(
		tar --extract

		--no-same-owner --no-same-permissions
		--strip-components=1 # otherwise we'd have to specify excludes as `${P}/path`

		--file="${arch}"
		--directory="${S}"
	)

	local excludes=( 'license'  )
	use system-jre	 && excludes+=( 'jre' )
	use amd64	|| excludes+=( bin/{fsnotifier64,libbreakgen64.so,libyjpagent-linux64.so,LLDBFrontend} )
	use arm		|| excludes+=( bin/fsnotifier-arm )
	use x86		|| excludes+=( bin/{fsnotifier,libbreakgen.so,libyjpagent-linux.so} )

	excludes+=( "${JBIJ_TAR_EXCLUDE[@]}" )
	readonly JBIJ_TAR_EXCLUDE

	einfo "Unpacking '${arch}' to '${S}'"
	einfo "Excluding: $(printf "'%s' " "${excludes[@]}")"

	local e
	for e in "${excludes[@]}" ; do tar+=( --exclude="${e}" ) ; done
	einfo "Running: '${tar[@]}'"
	"${tar[@]}" || die
}


jetbrains-intellij_src_prepare() {
	debug-print-function ${FUNCNAME}
	xdg_src_prepare
}


jetbrains-intellij_src_compile() { : ; }


jetbrains-intellij_pkg_preinst() {
	debug-print-function ${FUNCNAME}
	xdg_pkg_preinst
}


# @ECLASS-VARIABLE: JBIJ_DESKTOP_CATEGORIES=()

# @ECLASS-VARIABLE: JBIJ_DESKTOP_EXTRAS=()

# @ECLASS-VARIABLE: JBIJ_INSTALL_DIR
: ${JBIJ_INSTALL_DIR:="/opt/${_JBIJ_PN_SLOTTED}"}

jetbrains-intellij_src_install() {
	debug-print-function ${FUNCNAME}

	insinto "${JBIJ_INSTALL_DIR}"
	doins -r *

	pushd "${ED}/${JBIJ_INSTALL_DIR}" >/dev/null || die
	{
		# globbing doesn't work with `fperms()`'
		chmod -v a+x bin/{${PN}.sh,fsnotifier*} || die
		use system-jre		|| { chmod -v a+x jre/jre/bin/*	|| die ;}

		[ -f "bin/${PN}.sh" ] || die
		dosym "${JBIJ_INSTALL_DIR}/bin/${PN}.sh" /usr/bin/${_JBIJ_PN_SLOTTED}

		eshopts_push -s nullglob
		local svg=( bin/*.svg ) png=( bin/*.png )
		if [ ${#svg[@]} -gt 0 ] ; then
			newicon -s scalable "${svg[0]}" "${_JBIJ_PN_SLOTTED}.svg"
		elif [ ${#png[@]} -gt 0 ] ; then
			# icons size is sometimes 128 and sometimes 256
			newicon -s 128 "${png[0]}" "${_JBIJ_PN_SLOTTED}.png"
		else
			einfo "No icon found"
		fi
		eshopts_pop
	}
	popd >/dev/null || die

	make_desktop_entry_args=(
		"${EPREFIX}/usr/bin/${_JBIJ_PN_SLOTTED} %U"	# exec
		"${JBIJ_PN_PRETTY} ${SLOT}"	# name
		"${_JBIJ_PN_SLOTTED}"		# icon
		"Development;IDE;Java;$(IFS=';'; echo "${JBIJ_DESKTOP_CATEGORIES[*]}")"	# categories
	)
	make_desktop_entry_extras=(
		"StartupWMClass=jetbrains-${PN}"
		"${JBIJ_DESKTOP_EXTRAS[@]}"
	)
	make_desktop_entry "${make_desktop_entry_args[@]}" \
		"$( printf '%s\n' "${make_desktop_entry_extras[@]}" )"

	# recommended by: https://confluence.jetbrains.com/display/IDEADEV/Inotify+Watches+Limit
	mkdir -p "${ED}"/etc/sysctl.d || die
	echo "fs.inotify.max_user_watches = 524288" \
		>"${ED}"/etc/sysctl.d/30-idea-inotify-watches.conf || die
}


jetbrains-intellij_pkg_postinst() {
	debug-print-function ${FUNCNAME}
	xdg_pkg_postinst
}


jetbrains-intellij_pkg_postrm() {
	debug-print-function ${FUNCNAME}
	xdg_pkg_postrm
}

_JETBRAINS_INTELLIJ_ECLASS=1
fi
