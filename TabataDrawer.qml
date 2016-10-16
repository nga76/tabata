import QtQuick 2.7
import QtQuick.Controls 2.0

Drawer {
	id: drawer
	width: Math.min(window.width, window.height) / 3 * 2
	height: window.height

	ListView {
		id: listView
		currentIndex: -1
		anchors.fill: parent

		delegate: ItemDelegate {
			width: parent.width
			text: model.title
			highlighted: ListView.isCurrentItem
			onClicked: {
				if (listView.currentIndex != index) {
					listView.currentIndex = index;
					window.openPage(model.source);
				}
				drawer.close()
			}
		}

		model: ListModel {
			id: listModel
			ListElement { title: qsTr("Settings"); source: "qrc:/SettingsPage.qml" }
		}

		ScrollIndicator.vertical: ScrollIndicator { }
	}

	function unselectPage (pageName) {
		if (listView.currentIndex != -1 && listModel.get(listView.currentIndex).title === pageName) {
			listView.currentIndex = -1;
		}
	}
}