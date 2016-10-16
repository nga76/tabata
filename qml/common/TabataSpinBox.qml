import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

SpinBox {
	font.pointSize: 24
	Layout.alignment: Qt.AlignCenter

	onFocusChanged: {
		this.focus = false
	}
}
