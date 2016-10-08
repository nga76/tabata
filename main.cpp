#include "tabatastate.h"

#include <QDebug>
#include <QFileSelector>
#include <QQmlFileSelector>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtQuickControls2/QQuickStyle>

int main(int argc, char *argv[])
{
	QGuiApplication::setApplicationName("Tabata");
	QGuiApplication::setOrganizationName("FCompany");
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);
	QQuickStyle::setStyle("material");

	TabataState::init();
	QQmlApplicationEngine engine;
	engine.load(QUrl("qrc:/tabata.qml"));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
