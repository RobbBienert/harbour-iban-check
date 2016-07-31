/**
  concrete Settings class for this app

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#ifndef APPSETTINGS_H
#define APPSETTINGS_H

#include "settings.h"
#include <QString>

class AppSettings : public Settings
{
    Q_OBJECT
    Q_PROPERTY(QString LastCountry READ LastCountry)

public:
    AppSettings();

    const QString LastCountry() const;

    Q_INVOKABLE const QString getLastCountry() const;

private:
    QString m_LastCountry;
};

#endif // APPSETTINGS_H
