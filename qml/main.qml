import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
	id: appWindow;
	visible: true;
	width: 480;
	height: 640;

	// FROM Google Material Design Guide

	// primary and accent properties:
	property variant primaryPalette: app.primaryPalette(settings.primaryPaletteIndex)
	property color primaryLightColor: primaryPalette[0]
	property color primaryColor: primaryPalette[1]
	property color primaryDarkColor: primaryPalette[2]
	property color textOnPrimaryLight: primaryPalette[3]
	property color textOnPrimary: primaryPalette[4]
	property color textOnPrimaryDark: primaryPalette[5]
	property string iconOnPrimaryLightFolder: primaryPalette[6]
	property string iconOnPrimaryFolder: primaryPalette[7]
	property string iconOnPrimaryDarkFolder: primaryPalette[8]
	property variant accentPalette: app.accentPalette(settings.accentPaletteIndex)
	property color accentColor: accentPalette[0]
	property color textOnAccent: accentPalette[1]
	property string iconOnAccentFolder: accentPalette[2]
	Material.primary: primaryColor
	Material.accent: accentColor
	// theme Dark vs Light properties:
	property variant themePalette: app.themePalette(settings.isDarkTheme)
	property color dividerColor: themePalette[0]
	property color cardAndDialogBackground: themePalette[1]
	property real primaryTextOpacity: themePalette[2]
	property real secondaryTextOpacity: themePalette[3]
	property real dividerOpacity: themePalette[4]
	property real iconActiveOpacity: themePalette[5]
	property real iconInactiveOpacity: themePalette[6]
	property string iconFolder: themePalette[7]
	property color flatButtonTextColor: themePalette[9]
	property color popupTextColor: themePalette[10]
	property real toolBarActiveOpacity: themePalette[11]
	property real toolBarInactiveOpacity: themePalette[12]
	property color toastColor: themePalette[13]
	property real toastOpacity: themePalette[14]
	property color dropShadow: Material.dropShadowColor

	// font sizes - defaults from Google Material Design Guide
	property int fontSizeDisplay4: 112
	property int fontSizeDisplay3: 56
	property int fontSizeDisplay2: 45
	property int fontSizeDisplay1: 34
	property int fontSizeHeadline: 24
	property int fontSizeTitle: 20
	property int fontSizeSubheading: 16
	property int fontSizeBodyAndButton: 14 // is Default
	property int fontSizeCaption: 12
	property int fontSizeActiveNavigationButton: 14
	property int fontSizeInactiveNavigationButton: 12

	// fonts are grouped into primary and secondary with different Opacity
	// to make it easier to get the right property,
	// here's the opacity per size:
	property real opacityDisplay4: secondaryTextOpacity
	property real opacityDisplay3: secondaryTextOpacity
	property real opacityDisplay2: secondaryTextOpacity
	property real opacityDisplay1: secondaryTextOpacity
	property real opacityHeadline: primaryTextOpacity
	property real opacityTitle: primaryTextOpacity
	property real opacitySubheading: primaryTextOpacity
	// body can be both: primary or secondary text
	property real opacityBodyAndButton: primaryTextOpacity
	property real opacityBodySecondary: secondaryTextOpacity
	property real opacityCaption: secondaryTextOpacity
	// using Icons as Toggle to recognize 'checked'
	property real opacityToggleInactive: 0.2
	property real opacityToggleActive: 1.0


	// application property
	property string currentTitle;

	header: TitleBar {
		id: titleBar;
	}

	DrawerNavigationBar {
		id: drawerNavigationBar;
	}

	StackView {
		id: stackView;
		anchors.fill: parent;
		anchors.margins: 10;
		initialItem: "qrc:/qml/pages/InitialTabataPage.qml";

		onCurrentItemChanged: {
			if (currentItem.objectName) {
				currentTitle = currentItem.objectName;
			}
		}
	}

	Settings {
		id: settings;
		category: "TabataSettings";
		property int workTime: 4;
		property int tabataCount: 1;
		property int tabataRelaxTime: 0;
		property int primaryPaletteIndex: 4;
		property int accentPaletteIndex: 2;
		property int isDarkTheme: Material.System === Material.Dark;
	}

	Material.theme: settings.isDarkTheme ? Material.Dark : Material.Light;

	function openNavigationBar() {
		drawerNavigationBar.open();
	}

	function openPage(page) {
		stackView.push(page);
	}

	function tabataRun() {
		openPage("qrc:/qml/pages/TabataRunPage.qml");
	}

	function popOnePage() {
		drawerNavigationBar.unselectPage(stackView.currentItem.objectName);
		return stackView.pop();
	}

	function switchPrimaryPalette(index) {
		settings.primaryPaletteIndex = index;
		primaryPalette = app.primaryPalette(index);
	}

	function switchAccentPalette(index) {
		settings.accentPaletteIndex = index;
		accentPalette = app.accentPalette(index);
	}

	onClosing: {
		close.accepted = !popOnePage();
	}

}
