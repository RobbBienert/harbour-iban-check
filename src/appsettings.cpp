/**
  concrete Settings class for this app

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#include "appsettings.h"
#include <stdexcept>
#include <cstdlib>
#include <cstring>

AppSettings::AppSettings() : m_LastCountry("LastCountry")
{

}

const QString AppSettings::LastCountry() const {
    return m_LastCountry;
}

const QString AppSettings::getLastCountry() const {
    try {
        // We already stored a key …
        return get(m_LastCountry);
    }
    catch (std::out_of_range) {
        // … otherwise try to guess the country code from the current locale:
        char *lang = std::getenv("LANG");

        if (NULL == lang || ('C' == lang[0] && '\0' == lang[1]))
            return QString();

        QString la(lang);

        return la.size() < 5 ? la.left(2).toUpper() : la.mid(3, 2);
    }
}
