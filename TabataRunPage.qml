import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import TabataStateModule 1.0

Pane {

	Settings {
		id: settings
		category: "TabataSettings"
		property int workTime
		property int tabatasCount
		property int tabataRelaxTime
	}

	property int currentState: -1
	property int timeSeconds: 0
	property int cycleCount: -1

	property int defaultCycleCount: -1
	property int tabatasCount: -1
	property int tabataRelaxTime: -1

	readonly property int cycleWorkTime: 20
	readonly property int cycleRelaxTime: 10

	Timer {
		id: timer
		interval: 1000; running: false; repeat: true
		onTriggered: {
			timeSeconds = timeSeconds - 1
			if (timeSeconds <= 0)
			{
				nextState();
			}
		}
	}

	function nextState() {
		switch (currentState) {
		case TabataState.CycleWork:
			currentState = TabataState.CycleRelax
			break;
		case TabataState.CycleRelax:
			if (cycleCount > 0) {
				currentState = TabataState.CycleWork
			}
			else {
				currentState = TabataState.TabataRelax
			}
			break;
		case TabataState.TabataRelax:
			if (tabatasCount > 0) {
				currentState = TabataState.CycleWork
			}
			else {
				currentState = TabataState.TabataEnd;
			}
			break;
		case TabataState.Preparation:
			currentState = TabataState.CycleWork;
			break;
		}
	}

	onCurrentStateChanged: {
		switch (currentState) {
		case TabataState.CycleWork:
			console.log("cycle count", cycleCount, "tabatas count", tabatasCount)
			cycleCount = cycleCount - 1
			timeSeconds = cycleWorkTime
			break;
		case TabataState.CycleRelax:
			timeSeconds = cycleRelaxTime
			break;
		case TabataState.TabataRelax:
			cycleCount = defaultCycleCount
			tabatasCount = tabatasCount - 1
			timeSeconds = tabatasCount <= 0 ? 0 : tabataRelaxTime * 60
			if (timeSeconds <= 0) {
				nextState()
			}
			break;
		case TabataState.TabataEnd:
			timer.stop()
			busy.running = false
			break
		case TabataState.Preparation:
			cycleCount = defaultCycleCount
			timeSeconds = cycleRelaxTime
			break
		}
	}

	Item {
		anchors.top: parent.top
		anchors.bottom: timeLabel.bottom
		anchors.horizontalCenter: parent.horizontalCenter

		Label {
			id: stateLabel
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.verticalCenter: parent.verticalCenter
			Layout.alignment: Qt.AlignCenter
			Layout.fillWidth: true

			text: {
				switch (currentState) {
				case TabataState.CycleWork:
					return "Работа"
				case TabataState.CycleRelax:
					return "Отдых"
				case TabataState.TabataRelax:
					return "Передышка"
				case TabataState.TabataEnd:
					return "Конец"
				case TabataState.Preparation:
					return "Подготовка"
				}
				return "";
			}
			font.pointSize: 24
		}
	}

	Item {
		id: timeLabel
		anchors.centerIn: parent

		implicitWidth: Math.max(busy ? busy.implicitWidth + leftPadding + rightPadding : 0,
									   contentItem.implicitWidth + leftPadding + rightPadding)
		implicitHeight: Math.max(busy ? busy.implicitHeight + topPadding + bottomPadding: 0,
										contentItem.implicitHeight + topPadding + bottomPadding)
		baselineOffset: contentItem.y + contentItem.baselineOffset

		Label {
			text: timeSeconds
			font.pointSize: 36
			anchors.centerIn: parent
		}

		BusyIndicator {
			id: busy
			running: true
			anchors.centerIn: parent
			width: 100
			height: 100
		}
	}

	Component.onCompleted:
	{
		defaultCycleCount = settings.workTime * 2
		tabatasCount = settings.tabatasCount
		tabataRelaxTime = settings.tabataRelaxTime
		currentState = TabataState.Preparation
		timer.start()
	}
}
