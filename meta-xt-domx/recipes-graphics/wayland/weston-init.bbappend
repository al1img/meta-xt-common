
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

do_install_append() {
    if echo "${DISTRO_FEATURES}" | grep -q "ivi-shell"; then
        sed -i '/\[core\]/c\\[core\]\nmodules=ivi-controller.so' \
            ${D}/${sysconfdir}/xdg/weston/weston.ini
        sed -e '$a\\' \
            -e '$a\[ivi-shell]' \
            -e '$a\ivi-module=ivi-controller.so' \
            -e '$a\ivi-input-module=ivi-input-controller.so' \
            -e '$a\ivi-id-agent-module=ivi-id-agent.so' \
            -e '$a\transition-duration=300' \
            -e '$a\cursor-theme=default' \
            -i ${D}/${sysconfdir}/xdg/weston/weston.ini
        sed -e '$a\\' \
            -e '$a\[desktop-app-default]' \
            -e '$a\default-surface-id=2000000' \
            -e '$a\default-surface-id-max=2001000' \
            -i ${D}/${sysconfdir}/xdg/weston/weston.ini
        sed -i '/repaint-window=*/c\repaint-window=8' \
            ${D}/${sysconfdir}/xdg/weston/weston.ini
    fi
}
