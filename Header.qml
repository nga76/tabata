import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ToolBar {
	property string titleValue: qsTr("Tabata")
	RowLayout {
		spacing: 20
		anchors.fill: parent

		ToolButton {
			contentItem: Image {
				fillMode: Image.Pad
				horizontalAlignment: Image.AlignHCenter
				verticalAlignment: Image.AlignVCenter
				source: "qrc:/images/drawer.png"
			}
			onClicked: window.drawerOpen()
		}

		Label {
			id: titleLabel
			text: titleValue
			font.pointSize: fontSizeTitle
			elide: Label.ElideRight
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignVCenter
			Layout.fillWidth: true
		}

		ToolButton {
			contentItem: Image {
				fillMode: Image.Pad
				horizontalAlignment: Image.AlignHCenter
				verticalAlignment: Image.AlignVCenter
				source: "qrc:/images/menu.png"
			}
			onClicked: optionsMenu.open()

			Menu {
				id: optionsMenu
			}
		}
	}
}
