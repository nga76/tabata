#include <QtCore/QDebug>
#include <QtCore/QFileSelector>
#include <QtCore/QTranslator>

#include <QtGui/QGuiApplication>

#include <QtQml/QQmlApplicationEngine>
#include <QtQml/QQmlContext>
#include <QtQml/QQmlFileSelector>
#include <QtQuickControls2/QQuickStyle>

#include "application.h"

int main(int argc, char* argv[])
{
	QGuiApplication::setApplicationName("Tabata");
	QGuiApplication::setOrganizationName("FCompany");
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);
	QQuickStyle::setStyle("material");

	QLocale::setDefault(QLocale(QLocale::Russian, QLocale::Russia));
	QTranslator translator;
	if (translator.load(QLocale(), QLatin1String("tabata"), QLatin1String("_"),
			QLatin1String(":/translations"))) {
		app.installTranslator(&translator);
	} else {
		qDebug() << "cannot load translator " << QLocale().name()
				 << " check content of translations.qrc";
	}

	Application application;

	QQmlApplicationEngine engine;

	// from QML we have access to ApplicationUI as myApp
	QQmlContext* context = engine.rootContext();
	context->setContextProperty("app", &application);

	engine.load(QUrl("qrc:/qml/main.qml"));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
