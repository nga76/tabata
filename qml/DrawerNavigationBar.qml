import QtQuick 2.7
import QtQuick.Controls 2.0

Drawer {
	id: drawer
	width: Math.min(appWindow.width, appWindow.height) / 3 * 2
	height: appWindow.height

	ListView {
		id: listView
		currentIndex: -1
		anchors.fill: parent

		delegate: ItemDelegate {
			width: parent.width
			text: qsTr(model.title)
			highlighted: ListView.isCurrentItem
			onClicked: {
				if (listView.currentIndex != index) {
					listView.currentIndex = index;
					appWindow.openPage(model.source);
				}
				drawer.close()
			}
		}

		model: ListModel {
			id: listModel
			ListElement { title: qsTr("Settings"); source: "qrc:/qml/pages/SettingsPage.qml" }
		}

		ScrollIndicator.vertical: ScrollIndicator { }
	}

	function unselectPage (pageName) {
		if (listView.currentIndex != -1 && listModel.get(listView.currentIndex).title === pageName) {
			listView.currentIndex = -1;
		}
	}
}
