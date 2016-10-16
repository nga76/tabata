import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

Pane {
	objectName: qsTr("Tabata")

	ColumnLayout {
		anchors.fill: parent

		LayoutStretch {}

		Label {
			id: workTimeLabel;
			text: "Длительность";
			font.pointSize: 20;
			Layout.alignment: Qt.AlignCenter;
		}

		TabataSpinBox {
			id: workTimeValue;
			value: settings.workTime;
			from: 4;
			to: 20;
			onValueChanged: settings.workTime = value
		}

		Label {
			id: tabatsCountLabel;
			text: "Табаты";
			font.pointSize: 20;
			Layout.alignment: Qt.AlignCenter;
		}

		TabataSpinBox {
			id: tabatsCountValue;
			value: settings.tabatasCount;
			from: 1;
			to: 10;
			onValueChanged: settings.tabatasCount = value
		}

		Label {
			id: relaxTimeLabel;
			text: "Передышка";
			font.pointSize: 20;
			Layout.alignment: Qt.AlignCenter;
		}

		TabataSpinBox {
			id: relaxTimeValue
			value: settings.tabataRelaxTime;
			from: 0;
			to: 5
			onValueChanged: settings.tabataRelaxTime = value
		}

		LayoutStretch {}

		RoundColoredButton {
			Layout.alignment: Qt.AlignCenter
			id: startButton
			imageSource: "qrc:/images/play.png"
			radius: 30
			color: startButton.down ? Material.color(Material.Dark, Material.Shade300) :
									  Material.color(Material.Dark, Material.Shade400)
			onClicked: {
				console.log("click")
				window.tabataRun();
			}
		}

		LayoutStretch {}
	}
}
