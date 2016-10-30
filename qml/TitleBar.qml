import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

ToolBar {
	RowLayout {
		focus: false
		spacing: 6
		anchors.fill: parent
		Item {
			width: 4
		}

		ToolButton {
			visible: !backButton.visible;
			focusPolicy: Qt.NoFocus;
			Image {
				anchors.centerIn: parent;
				source: "qrc:/images/" + iconOnPrimaryFolder + "/drawer.png";
			}
			onClicked: {
				appWindow.openNavigationBar();
			}
		}
		ToolButton {
			id: backButton;
			focusPolicy: Qt.NoFocus;
			visible: stackView.depth > 1;
			Image {
				anchors.centerIn: parent;
				source: "qrc:/images/"+iconOnPrimaryFolder+"/arrow_back.png";
			}
			onClicked: {
				appWindow.popOnePage();
			}
		} // backButton

		Label {
			id: titleLabel
			text: currentTitle
			leftPadding: 6
			rightPadding: 6
			font.pointSize: fontSizeTitle
			elide: Label.ElideRight
			horizontalAlignment: Qt.AlignHCenter
			verticalAlignment: Qt.AlignVCenter
			Layout.fillWidth: true
			color: textOnPrimary
		}

		ToolButton {
			id: optionsButton;
			focusPolicy: Qt.NoFocus
			Image {
				anchors.centerIn: parent
				source: "qrc:/images/"+iconOnPrimaryFolder+"/menu.png"
			}
			onClicked: {
				optionsMenu.open()
			}

			Menu {
				id: optionsMenu
				x: parent.width - width
				transformOrigin: Menu.TopRight
			}
		}
	}
}
