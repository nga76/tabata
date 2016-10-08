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

	Material.theme: Material.Dark
	Material.primary: Material.color(Material.Grey, Material.Shade900)

	header: Header {
	}

	MyDrawer {
	}

	StackView {
		id: stackView
		anchors.fill: parent
		initialItem: InitialTabataPage {}
	}

	Settings {
		id: settings
		category: "TabataSettings"
		property int workTime
		property int tabatasCount
		property int tabataRelaxTime
	}

	function tabataRun() {
		stackView.push("qrc:/TabataRunPage.qml")
	}

}
