import QtQuick 2.0
import QtQuick.Controls.Material 2.0

Item {

	property color circleColor: "transparent"
	property color unprogressBorderColor:  Material.color(Material.LightBlue, Material.Shade50);
	property color progressBorderColor: Material.color(Material.Dark, Material.Shade500);
	property int borderWidth: 4;

	property int value: 0;
	property int to: 100;
	property int from: 0;

	Rectangle {
		id: circle;
		width: parent.width;
		height: parent.height;
		anchors.centerIn: parent;
		antialiasing: true

		radius: width / 2;
		border.color: unprogressBorderColor;
		border.width: borderWidth;
		color: circleColor;
	}

	Rectangle {
		anchors.centerIn: circle;
		rotation: 360 * (value / interval()) - 90;
		transformOrigin: Item.Left;

		Rectangle {
			id: dot;
			width: borderWidth * 3;
			height: borderWidth * 3;
			radius: width / 2;
			clip: true;
			x: circle.width / 2 - borderWidth * 2;
			color: progressBorderColor;
			antialiasing: true;
		}
	}

	Item {
		width: parent.width / 2;
		height: parent.height;
		clip: true;

		Item {
			width: parent.width;
			height: parent.height;
			clip: true;
			rotation: {
				if (value * 2 >= interval())
					360 * (value / interval()) - 180;
				else if (value != 0)
					0;
				else
					180;
			}
			transformOrigin: Item.Right;

			Rectangle{
				width: circle.width;
				height: circle.height;
				radius: circle.radius;
				color: circleColor;
				border.color: progressBorderColor;
				border.width: borderWidth;
				smooth: true;
				antialiasing: true;
			}
		}
	}

	Item {
		width: parent.width / 2;
		height: parent.height;
		clip: true;
		x: width;

		Item {
			width: parent.width;
			height: parent.height;
			clip: true;
			rotation: {
				if (value * 2 <= interval())
					360 * (value / interval());
				else
					180;
			}
			transformOrigin: Item.Left;

			Rectangle{
				width: circle.width;
				height: circle.height;
				radius: circle.radius;
				x: -radius;
				color: circleColor;
				border.color: progressBorderColor;
				border.width: borderWidth;
				antialiasing: true;
				smooth: true;
			}
		}
	}

	function interval() {
		return to - from;
	}
}
