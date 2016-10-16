import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0

import "../common"

Flickable {
	objectName: qsTr("Settings");
	contentHeight: root.implicitHeight;
	clip: true;

	Page {
		id: root;
		anchors.fill: parent

		ColumnLayout {
			anchors {right: parent.right; left: parent.left; }

			/// theme selection
			LabelTitle {
				topPadding: 6
				text: qsTr("Theme")
				color: primaryColor
			}
			RowLayout {
				LabelSubheading {
					topPadding: 6
					leftPadding: 10
					wrapMode: Text.WordWrap
					text: qsTr("Dark Theme")
				}
				Switch {
					topPadding: 6
					anchors.right: parent.right
					focusPolicy: Qt.NoFocus
					checked: settings.isDarkTheme
					onCheckedChanged: {
							settings.isDarkTheme = checked;
							appWindow.Material.theme = checked ? Material.Dark : Material.Light;
					}
				}
			}

			/// colors selection
			LabelTitle {
				topPadding: 6
				text: qsTr("Colors")
				color: primaryColor
			}
			RowLayout {
				LabelSubheading {
					id: labelPrimary
					topPadding: 6
					leftPadding: 10
					wrapMode: Text.WordWrap
					text: qsTr("Primary Color:\nTap on Color Rectangle to edit")
				}
				Rectangle {
					anchors.verticalCenter: labelPrimary.verticalCenter
					anchors.right: parent.right
					width: 100
					height: 40
					color: Material.primaryColor
					MouseArea {
						anchors.fill: parent
						onClicked: {
							appWindow.openPage("qrc:/qml/pages/PrimaryColorPage.qml");
						}
					}
				}
			}
			Item {
				height: 6
			}
			RowLayout {
				LabelSubheading {
					id: labelAccent
					topPadding: 6
					leftPadding: 10
					wrapMode: Text.WordWrap
					text: qsTr("Accent Color:\nTap on Color Rectangle to edit")
				}
				Rectangle {
					anchors.verticalCenter: labelAccent.verticalCenter
					anchors.right: parent.right
					width: 100
					height: 40
					color: accentColor
					MouseArea {
						anchors.fill: parent
						onClicked: {
							appWindow.openPage("qrc:/qml/pages/AccentColorPage.qml");
						}
					}
				}
			}
		}
	}
}
