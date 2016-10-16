import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0

import "../common"

Pane {
	objectName: qsTr("Tabata")

	property int workTimeFrom: 4
	property int workTimeTo: 20
	property int tabatasCountFrom: 1
	property int tabatasCountTo: 10
	property int relaxTimeFrom: 0
	property int relaxTimeTo: 5

	ColumnLayout {
		anchors.fill: parent

		LayoutStretch {}

		Label {
			id: workTimeLabel;
			text: qsTr("Duration, min");
			Layout.alignment: Qt.AlignCenter;
			font.pointSize: fontSizeTitle
		}

		TabataSpinBox {
			id: workTimeValue;
			value: settings.workTime;
			from: workTimeFrom;
			to: workTimeTo;
			onValueChanged: settings.workTime = value
		}

		Label {
			id: tabatsCountLabel;
			text: qsTr("Tabata count");
			Layout.alignment: Qt.AlignCenter;
			font.pointSize: fontSizeTitle
		}

		TabataSpinBox {
			id: tabatsCountValue;
			value: settings.tabatasCount;
			from: tabatasCountFrom;
			to: tabatasCountTo;
			onValueChanged: settings.tabatasCount = value
		}

		Label {
			id: relaxTimeLabel;
			text: qsTr("Relax, min");
			Layout.alignment: Qt.AlignCenter;
			font.pointSize: fontSizeTitle
		}

		TabataSpinBox {
			id: relaxTimeValue
			value: settings.tabataRelaxTime;
			from: relaxTimeFrom;
			to: relaxTimeTo;
			onValueChanged: settings.tabataRelaxTime = value;
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
				appWindow.tabataRun();
			}
		}

		LayoutStretch {}
	}
}
