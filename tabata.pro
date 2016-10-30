QT += qml quick quickcontrols2

CONFIG += c++11

SOURCES += main.cpp \
    application.cpp

RESOURCES += qml.qrc \
    images.qrc \
    translations.qrc \
    music.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

lupdate_only {
    SOURCES += \
	qml/* \
	qml/common/* \
	qml/pages/* \
}

TRANSLATIONS += translations/tabata_ru_RU.ts

HEADERS += \
    application.h
