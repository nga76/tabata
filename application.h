#ifndef APPLICATION_H
#define APPLICATION_H

#include <QtCore/QObject>

class Application : public QObject {
	Q_OBJECT
public:
	explicit Application(QObject* parent = 0);

	Q_INVOKABLE
	QStringList primaryPalette(const int paletteIndex) const;

	Q_INVOKABLE
	QStringList accentPalette(const int paletteIndex) const;

	Q_INVOKABLE
	QStringList themePalette(const bool isDark) const;
};

#endif // APPLICATION_H
