import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Material 2.0

Rectangle {
	id: currentSetLabel;
	width: 70;
	height: 60;
	radius: 5;
	color: Material.color(Material.Grey, Material.Shade700);

	property string text;
	property int setsCount: 0;
	property int currentSet: 0;

	ColumnLayout {
		anchors.fill: parent
		spacing: 2
		Label {
			id: tabataHeaderLabel
			text: currentSetLabel.text;
			Layout.alignment: Qt.AlignCenter
			font.pointSize: fontSizeBodyAndButton;
		}

		LabelTitle {
			id: tabataCountLabel
			text: currentSet + " / " + setsCount;
			Layout.alignment: Qt.AlignCenter
			Layout.fillWidth: false
		}
	}
}
