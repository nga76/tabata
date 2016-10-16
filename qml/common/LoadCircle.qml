import QtQuick 2.0
import QtQuick.Controls.Material 2.0

Item {
	id: loadCircle;
	property color circleColor: "transparent"
	property color unprogressBorderColor:  Material.color(Material.LightBlue, Material.Shade50);
	property color progressBorderColor: Material.color(Material.Dark, Material.Shade500);
	property int borderWidth: 4;

	property int duration: 100;

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
		rotation: 270;
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

	ParallelAnimation {
		id: animation;
		PropertyAnimation {
			target: dot.parent;
			property: "rotation";
			to: -90;
			duration: loadCircle.duration;
		}
		SequentialAnimation {
			PropertyAnimation{
				target: leftCircleSide;
				property: "rotation";
				to: 0;
				duration: loadCircle.duration / 2;
			}
			PropertyAnimation {
				target: rightCircleSide;
				property: "rotation";
				to:0;
				duration: loadCircle.duration / 2;
			}
		}

		onRunningChanged: {
			if (!running) {
				dot.parent.rotation = 270;
				leftCircleSide.rotation = 180;
				rightCircleSide.rotation = 180;
			}
		}
	}

	Item {
		width: parent.width / 2;
		height: parent.height;
		clip: true;

		Item {
			id: leftCircleSide
			width: parent.width;
			height: parent.height;
			clip: true;
			rotation: 180;
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
			id: rightCircleSide
			width: parent.width;
			height: parent.height;
			clip: true;
			rotation: 180;
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

	function start(_duration) {
		animation.stop();
		duration = _duration;
		animation.start();
	}
}
