import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0

import "../common"

Pane {
	objectName: qsTr("Tabata")

	property int workTimeFrom: 4
	property int workTimeTo: 20
	property int tabataCountFrom: 1
	property int tabataCountTo: 10
	property int relaxTimeFrom: 0
	property int relaxTimeTo: 5

	ColumnLayout {
		anchors.fill: parent

		LayoutStretch {}

		LabelTitle {
			id: workTimeLabel;
			text: qsTr("Duration, min");
			Layout.alignment: Qt.AlignCenter;
			Layout.fillWidth: false
		}

		TabataSpinBox {
			id: workTimeValue;
			value: settings.workTime;
			from: workTimeFrom;
			to: workTimeTo;
			onValueChanged: settings.workTime = value
		}

		LabelTitle {
			id: tabatsCountLabel;
			text: qsTr("Tabata count");
			Layout.alignment: Qt.AlignCenter;
			Layout.fillWidth: false
		}

		TabataSpinBox {
			id: tabatsCountValue;
			value: settings.tabataCount;
			from: tabataCountFrom;
			to: tabataCountTo;
			onValueChanged: settings.tabataCount = value
		}

		LabelTitle {
			id: relaxTimeLabel;
			text: qsTr("Relax, min");
			Layout.alignment: Qt.AlignCenter;
			Layout.fillWidth: false
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
