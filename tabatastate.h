#pragma once

#include <QObject>
#include <QQmlEngine>

class TabataState : public QObject
{
	Q_OBJECT
public:
	enum class State
	{
		Preparation = 0,
		CycleWork = 1,
		CycleRelax = 2,
		TabataRelax = 3,
		TabataEnd = 4
	};
	Q_ENUM(State)

	static void init();
};
