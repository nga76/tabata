import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import "../common"

Page {

	objectName: qsTr("Work");

	property int timeMilliseconds: 0; /// In milliseconds
	property int cycleCount: 0;

	property int tabatasCount: 1;
	property int tabataRelaxTime: 0; /// In seconds

	readonly property int cycleWorkTime: 20; /// In seconds
	readonly property int cycleRelaxTime: 10; /// In seconds

	property var stateNames: [
		"preparation",
		"tabata_begin",
		"cycle_begin",
		"cycle_relax",
		"cycle_end",
		"tabata_relax",
		"tabata_end",
		"end"
	]

	Timer {
		id: timer
		interval: 1000;
		running: false;
		repeat: true;
		onTriggered: {
			timeMilliseconds = timeMilliseconds - timer.interval
			if (timeMilliseconds <= 0)
			{
				state = stateNames[stateNames.indexOf(state) + 1];
				progressBar.start(timeMilliseconds);
				asdasd.stop();
				asdasd.start();
			}
			console.log(Qt.formatDateTime(new Date(), "mm:ss:zzz"));
		}
	}

	ColumnLayout {
		anchors.fill: parent;

		Label {
			id: stateLabel
			font.pointSize: fontSizeHeadline
			Layout.alignment: Qt.AlignCenter
			anchors.bottom: timeLabel.top;
			anchors.top: parent.top
		}

		Item {
			id: timeLabel
			anchors.centerIn: parent
			width: Math.min(appWindow.width, appWindow.height) / 2;
			height: width;

			Label {
				id:aaaa;
				anchors.centerIn: parent;
				text: Math.round(timeMilliseconds / 1000);
				font.pointSize: 80;
			}

			LoadCircle {
				id: progressBar
				anchors.fill: parent;
			}
		}
	}

	Component.onCompleted: {
		state = "preparation";
	}

	states: [
		State {
			name: "preparation";

			StateChangeScript {
				id: preparationChangeScript
				script: {
					tabatasCount = settings.tabatasCount;
					tabataRelaxTime = settings.tabataRelaxTime;

					timeMilliseconds = cycleRelaxTime * 1000;
					progressBar.start(timeMilliseconds);
					asdasd.start();
				}
			}
			PropertyChanges {
				target: stateLabel;
				text: qsTr("Preparation");
			}
			onCompleted: {
				timer.start();
			}
		},
		State {
			name: "tabata_begin";

			StateChangeScript {
				id: tabataBeginChangeScript
				script: {
					tabatasCount = tabatasCount - 1;
					cycleCount = settings.workTime * 2;
				}
			}

			onCompleted: {
				state = "cycle_begin";
			}
		},
		State {
			name: "cycle_begin";

			StateChangeScript {
				id: cycleBeginChangeScript
				script: {
					cycleCount = cycleCount - 1;
					timeMilliseconds = cycleWorkTime * 1000;
				}
			}
			PropertyChanges {
				target: stateLabel;
				text: qsTr("Cycle begin");
			}
		},
		State {
			name: "cycle_relax";

			StateChangeScript {
				id: cycleRelaxChangeScript
				script: {
					timeMilliseconds = cycleRelaxTime * 1000;
				}
			}
			PropertyChanges {
				target: stateLabel;
				text: qsTr("Cycle relax");
			}
		},
		State {
			name: "cycle_end";
			onCompleted: {
					state = cycleCount <= 0 ? "tabata_relax" : "cycle_begin";
			}
		},
		State {
			name: "tabata_relax";

			StateChangeScript {
				id: tabataRelaxChangeScript
				script: {
					timeMilliseconds = tabataRelaxTime * 1000 * 60;
				}
			}
			PropertyChanges {
				target: stateLabel;
				text: qsTr("Tabata relax");
			}

			onCompleted: {
				if (tabataRelaxTime == 0)
					state = "tabata_end";
			}
		},
		State {
			name: "tabata_end";

			onCompleted: {
					state = tabatasCount <= 0 ? "end" : "tabata_begin";
			}
		},
		State {
			name: "end";
			PropertyChanges {
				target: stateLabel;
				text: qsTr("End");
			}
			onCompleted: {
				timer.stop();
			}
		}

	]
}
