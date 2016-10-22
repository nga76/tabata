import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import "../common"

Page {
	id: runPage;
	objectName: qsTr("Work");

	property int timeMilliseconds: 0; /// In milliseconds
	property int cycleCount: 0;

	property int tabatasCount: 1;
	property int tabataRelaxTime: 0; /// In seconds

	readonly property int cycleWorkTime: 20; /// In seconds
	readonly property int cycleRelaxTime: 10; /// In seconds

	property bool running: false;

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

	Item {
		anchors {
			left: parent.left;
			right: parent.right;
			top: parent.top;
			bottom: progressBar.top;
		}

		Label {
			id: stateLabel
			font.pointSize: fontSizeHeadline
			anchors.centerIn: parent
		}
	}


	LoadCircle {
		id: progressBar
		Layout.alignment: Qt.AlignCenter
		anchors.centerIn: parent
		width: Math.min(appWindow.width, appWindow.height) / 2;
		height: width;

		onStopped: {
			if (runPage.running) {
				nextState();
				start(timeMilliseconds);
			}
		}
	}

	Item {
		anchors {
			left: parent.left;
			right: parent.right;
			top: progressBar.bottom;
			bottom: parent.bottom;
		}

		RoundColoredButton {
			id: pauseButton
			anchors.centerIn: parent;
			imageSource: progressBar.isPaused() ? "qrc:/images/play.png" : "qrc:/images/pause.png"
			radius: 30
			color: pauseButton.down ? Material.color(Material.Dark, Material.Shade300) :
									  Material.color(Material.Dark, Material.Shade400)
			onClicked: {
				if (progressBar.isPaused()) {
					progressBar.resume();
				}
				else {
				progressBar.pause();
				}
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
				}
			}
			PropertyChanges {
				target: stateLabel;
				text: qsTr("Preparation");
			}
			onCompleted: {
				runPage.running = true;
				progressBar.start(timeMilliseconds);
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
				running = false;
			}
		}
	]

	function nextState() {
		state = stateNames[stateNames.indexOf(state) + 1];
	}
}
