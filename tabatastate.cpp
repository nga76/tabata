#include "tabatastate.h"

void TabataState::init()
{
	qRegisterMetaType<TabataState::State>("TabataState::State");
	qmlRegisterType<TabataState>("TabataStateModule", 1, 0, "TabataState");
}
