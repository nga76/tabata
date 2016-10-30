import QtQuick 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.0

Item {
	id: loadCircle;
	property color circleColor: "transparent"
	property color unprogressBorderColor:  Material.color(Material.LightBlue, Material.Shade50);
	property color progressBorderColor: Material.color(Material.Dark, Material.Shade500);
	property int borderWidth: 4;
	property int duration: 100;
	signal stopped();

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

	Label {
		id:timeLabel;
		property int time;
		anchors.centerIn: parent;
		text: (time / 1000).toFixed(0)
		font.pointSize: 80;
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
			x: circle.width / 2 - borderWidth * 2;
			color: progressBorderColor;
		}
	}

	ParallelAnimation {
		id: animation;
		RotationAnimation {
			target: dot.parent;
			from: 270;
			to: -90;
			duration: loadCircle.duration;
		}

		NumberAnimation {
			target: timeLabel;
			property: "time";
			from: loadCircle.duration;
			to: 0;
			duration: loadCircle.duration;
			easing.type: Easing.Linear;
		}
		SequentialAnimation {
			RotationAnimation {
				target: leftCircleSide;
				from: 180;
				to: 0;
				duration: loadCircle.duration / 2;
			}
			RotationAnimation {
				target: rightCircleSide;
				from: 180;
				to:0;
				duration: loadCircle.duration / 2;
			}
		}

		onStopped: {
			console.log(Qt.formatDateTime(new Date(), "hh:mm:ss:zzz"));
			leftCircleSide.rotation = 180;
			rightCircleSide.rotation = 180;
			loadCircle.stopped();
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
			}
		}
	}

	function start(_duration) {
		duration = _duration;
		animation.start();
	}

	function pause() {
		animation.pause();
	}

	function resume() {
		animation.resume();
	}

	function isPaused() {
		return animation.paused;
	}
}
