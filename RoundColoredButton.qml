import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

Button {
	property int radius: 30
	property string imageSource: ""
	property color color: "#000000"

	implicitWidth: Math.max(background ? background.implicitWidth : 0,
										 contentItem.implicitWidth + leftPadding + rightPadding)
	implicitHeight: Math.max(background ? background.implicitHeight : 0,
										  contentItem.implicitHeight + topPadding + bottomPadding)
	baselineOffset: contentItem.y + contentItem.baselineOffset

	Image {
		id: roundButtonImage
		source: imageSource
		anchors.centerIn: parent
	}

	background: Rectangle {
		id: background
		anchors.centerIn: parent
		implicitWidth: parent.radius * 2
		implicitHeight: parent.radius * 2
		radius: parent.radius
		color: parent.color
	}
}
