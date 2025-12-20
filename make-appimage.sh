#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q mousai | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.seadve.Mousai.svg
export DESKTOP=/usr/share/applications/io.github.seadve.Mousai.desktop
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1
export DEPLOY_GSTREAMER=1
export STARTUPWMCLASS=io.github.seadve.Mousai # Default to Wayland's wmclass. For X11, GTK_CLASS_FIX will force the wmclass to be the Wayland one.
export GTK_CLASS_FIX=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/mousai \
             /usr/lib/gio/modules/libgiognutls.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage
