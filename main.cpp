#include <QDebug>
#include <QFileSelector>
#include <QQmlFileSelector>
#include <QTranslator>
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>

#include <QtQuickControls2/QQuickStyle>

int main(int argc, char* argv[])
{
	QGuiApplication::setApplicationName("Tabata");
	QGuiApplication::setOrganizationName("FCompany");
	QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);
	QQuickStyle::setStyle("material");

	QTranslator translator;
	if (translator.load(QLocale(), QLatin1String("tabata"), QLatin1String("_"),
			QLatin1String(":/translations"))) {
		app.installTranslator(&translator);
	} else {
		qDebug() << "cannot load translator " << QLocale::system().name()
				 << " check content of translations.qrc";
	}

	QQmlApplicationEngine engine;
	engine.load(QUrl("qrc:/qml/main.qml"));
	if (engine.rootObjects().isEmpty())
		return -1;

	return app.exec();
}
