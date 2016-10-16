#include "application.h"

namespace constants {

/*
 * P R I M A R Y colors
 * from Google Material Style Guide:
 * http://www.google.com/design/spec/style/color.html#color-color-palette
 * selected colors for primary light - primary - primary dark:
 * light: 100 - primary: 500 - dark: 700
 * from Qt 5.7 Material Style:
 * http://doc-snapshots.qt.io/qt5-5.7/qtquickcontrols2-material.html#pre-defined-colors
 *
 * QStringList contains:
 * {primaryLightColor, primaryColor, primaryDarkColor
 *     textOnPrimaryLight, textOnPrimary, textOnPrimaryDark
 *     iconOnPrimaryLightFolder, iconOnPrimaryFolder, iconOnPrimaryDarkFolder}
 *
 * In Qt 5.7 there are more ways tp get access to Material colors:
 * http://code.qt.io/cgit/qt/qtquickcontrols2.git/tree/src/imports/controls/material/qquickmaterialstyle_p.h?h=5.7#n235
 * to get access from QML:
 * import QtQuick 2.5
 * import QtQuick.Controls 2.0
 * import QtQuick.Controls.Material 2.0
 * color: Material.color(Material.Purple, Material.Shade900
 *
 * ekke (Ekkehard Gentz) @ekkescorner
*/
static const QStringList materialColors[19] = {
	{ "#FFCDD2", "#F44336", "#D32F2F", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialRed
	{ "#F8BBD0", "#E91E63", "#C2185B", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialPink
	{ "#E1BEE7", "#9C27B0", "#7B1FA2", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialPurple
	{ "#D1C4E9", "#673AB7", "#512DA8", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialDeepPurple
	{ "#C5CAE9", "#3F51B5", "#303F9F", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialIndigo
	{ "#BBDEFB", "#2196F3", "#1976D2", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialBlue
	{ "#B3E5FC", "#03A9F4", "#0288D1", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialdarkBlue
	{ "#B2EBF2", "#00BCD4", "#0097A7", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialCyan
	{ "#B2DFDB", "#009688", "#00796B", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialTeal
	{ "#C8E6C9", "#4CAF50", "#388E3C", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialGreen
	{ "#DCEDC8", "#8BC34A", "#689F38", "#000000", "#000000", "#000000", "lightTheme", "lightTheme", "lightTheme" }, // materialdarkGreen
	{ "#F0F4C3", "#CDDC39", "#AFB42B", "#000000", "#000000", "#000000", "lightTheme", "lightTheme", "lightTheme" }, // materialLime
	{ "#FFF9C4", "#FFEB3B", "#FBC02D", "#000000", "#000000", "#000000", "lightTheme", "lightTheme", "lightTheme" }, // materialYellow
	{ "#FFECB3", "#FFC107", "#FFA000", "#000000", "#000000", "#000000", "lightTheme", "lightTheme", "lightTheme" }, // materialAmber
	{ "#FFE0B2", "#FF9800", "#F57C00", "#000000", "#000000", "#000000", "lightTheme", "lightTheme", "lightTheme" }, // materialOrange
	{ "#FFCCBC", "#FF5722", "#E64A19", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialDeepOrange
	{ "#D7CCC8", "#795548", "#5D4037", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }, // materialBrown
	{ "#F5F5F5", "#9E9E9E", "#616161", "#000000", "#000000", "#FFFFFF", "lightTheme", "lightTheme", "darkTheme" }, // materialGrey
	{ "#CFD8DC", "#607D8B", "#455A64", "#000000", "#FFFFFF", "#FFFFFF", "lightTheme", "darkTheme", "darkTheme" }	 // materialBlueGrey
};

/*
 * T H E M E  Light and Dark  ---  Default: Light
 * Colors, Opacity from Google Material Style Guide
 *
 * QStringList contains:
 * {dividerColor, cardAndDialogBackground, primaryTextOpacity, secondaryTextOpacity, dividerOpacity,
 *    iconActiveOpacity, iconInactiveOpacity, iconFolder, isDark, flatButtonTextColor, popupTextColor,
 *    toolBarActiveOpacity, toolBarInactiveOpacity, toastColor, toastOpacity}
 *
 * ekke (Ekkehard Gentz) @ekkescorner
*/
static const QStringList darkPalette{ "#FFFFFF", "#424242", "1.0", "0.70", "0.12", "1.0", "0.3", "darkTheme", "1", "#FFFFFF", "#FFFFFF", "1.0", "0.7", "Darkgrey", "0.9" };
static const QStringList lightPalette{ "#000000", "#FFFFFF", "0.87", "0.54", "0.12", "0.54", "0.26", "lightTheme", "0", "#424242", "#424242", "1.0", "0.7", "#323232", "0.75" };
}

Application::Application(QObject* parent)
	: QObject(parent)
{
}

QStringList Application::primaryPalette(const int paletteIndex) const
{
	if (paletteIndex < static_cast<int>(sizeof(constants::materialColors) / sizeof(QStringList)) && (paletteIndex >= 0)) {
		return constants::materialColors[paletteIndex];
	}
	return constants::materialColors[0];
}

QStringList Application::accentPalette(const int paletteIndex) const
{
	QStringList palette = primaryPalette(paletteIndex);
	// we need: primaryColor, textOnPrimary, iconOnPrimaryFolder
	return QStringList{palette.at(1), palette.at(4), palette.at(7)};
}

QStringList Application::themePalette(bool isDark) const
{
	return !isDark ? constants::lightPalette : constants::darkPalette;
}
