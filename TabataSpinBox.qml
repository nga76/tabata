import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

SpinBox {
	Layout.alignment: Qt.AlignCenter
	font.pointSize: 24
	onFocusChanged: {
		this.focus = false
	}
}
