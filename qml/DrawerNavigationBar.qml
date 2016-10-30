import QtQuick 2.7
import QtQuick.Controls 2.0

Drawer {
	id: drawer
	width: Math.min(appWindow.width, appWindow.height) / 3 * 2
	height: appWindow.height

	enter: Transition { SmoothedAnimation { velocity: 3 } }
	exit: Transition { SmoothedAnimation { velocity: 3 } }

	ListView {
		id: listView
		currentIndex: -1
		anchors.fill: parent

		delegate: ItemDelegate {
			width: parent.width;
			Row {
				anchors.verticalCenter: parent.verticalCenter;
				spacing: 10;
				leftPadding: 10;
				Image {
					id: delegateIcon;
					anchors.verticalCenter: parent.verticalCenter;
					source: "qrc:/images/"+iconFolder+"/" + model.icon;
					height: delegateText.height;
					width: height;
				}
				Text {
					id: delegateText;
					anchors.verticalCenter: parent.verticalCenter;
					text: qsTr(model.title)
					font.pointSize: fontSizeTitle;
				}
			}
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
			ListElement { title: qsTr("Settings"); source: "qrc:/qml/pages/SettingsPage.qml"; icon: "settings.png"; }
			ListElement { title: qsTr("About tabata"); source: "qrc:/qml/pages/AboutTabataPage.qml"; icon: "about.png"; }
		}
	}

	function unselectPage (pageName) {
		if (listView.currentIndex != -1 && listModel.get(listView.currentIndex).title === pageName) {
			listView.currentIndex = -1;
		}
	}
}
