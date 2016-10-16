import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

ApplicationWindow {
	id: window;
	visible: true;
	width: 480;
	height: 640;

	property int fontSizeHeadline: 24
	property int fontSizeTitle: 20
	property int fontSizeSubheading: 16

	/// Material settings
	property color primaryColor: Material.primary;
	property color accentColor: Material.accent;

	property bool isDarkTheme: Material.theme == Material.Dark;

	Material.theme: Material.Dark;
	Material.primary: Material.color(Material.Grey, Material.Shade900);

	header: Header {
		id: header
	}

	TabataDrawer {
		id: drawer;
	}

	StackView {
		id: stackView;
		anchors.fill: parent;
		initialItem: "qrc:/qml/pages/InitialTabataPage.qml"
	}

	Settings {
		id: settings;
		category: "TabataSettings";
		property int workTime;
		property int tabatasCount;
		property int tabataRelaxTime;
	}

	function drawerOpen() {
		drawer.open();
	}

	function openPage(page) {
		stackView.push(page);
		header.titleValue = stackView.currentItem.objectName;
	}

	function tabataRun() {
		openPage("qrc:/qml/pages/TabataRunPage.qml");
	}

	function popOnePage() {
		drawer.unselectPage(stackView.currentItem.objectName);
		if (stackView.pop()) {
			header.titleValue = stackView.currentItem.objectName;
		}
	}

	onClosing: {
		drawer.unselectPage(stackView.currentItem.objectName);
		if (stackView.pop()) {
			header.titleValue = stackView.currentItem.objectName;
			close.accepted = false;
		}
	}

}
