QT += qml quick quickcontrols2

CONFIG += c++11

SOURCES += main.cpp \
    tabatastate.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    tabata.qml \
    TabataRunPage.qml \
    Header.qml \
    LayoutStretch.qml \
    MyDrawer.qml \
    RoundColoredButton.qml \
    TabataSpinBox.qml \
    InitialTabataPage.qml \

HEADERS += \
    tabatastate.h
