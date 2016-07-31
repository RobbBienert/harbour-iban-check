# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-iban-check

CONFIG += sailfishapp

SOURCES += src/iban-check.cpp \
    src/settings.cpp \
    src/qstringio.cpp \
    src/appsettings.cpp

OTHER_FILES += qml/harbour-iban-check.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-iban-check.changes.in \
    rpm/harbour-iban-check.spec \
    rpm/harbour-iban-check.yaml \
    translations/*.ts \
    harbour-iban-check.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-iban-check-de.ts

DISTFILES += \
    qml/pages/AboutPage.qml \
    qml/ibancheck.js \
    qml/pages/MainPage.qml \
    qml/cover/iban-check.png \
    qml/pages/HelpPage.qml \
    qml/types/SailText.qml \
    qml/types/SailTextHeader.qml \
    qml/types/TextWithLink.qml \
    data/ibans.txt \
    data/tojs.py

HEADERS += \
    src/settings.h \
    src/qstringio.h \
    src/appsettings.h

