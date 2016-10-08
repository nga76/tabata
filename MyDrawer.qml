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
					listView.currentIndex = index
				}
				drawer.close()
			}
		}

		model: ListModel {
			ListElement { title: "Element1"; }
		}

		ScrollIndicator.vertical: ScrollIndicator { }
	}
}
