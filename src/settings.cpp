/**
  configuration file based settings

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#include "settings.h"
#include <QStandardPaths>
#include <QGuiApplication>
#include <iostream>
#include "qstringio.h"
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <cstring>
#include <string>
#include <fstream>

Settings::Settings(QObject *parent) : QObject(parent), m_saveOnSet(false)
{
    m_cfgdir = QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)
            + '/' + QGuiApplication::applicationName();

    int r = mkdir(m_cfgdir.toUtf8().data(), 0755);
    if (-1 == r && EEXIST != errno)
        std::cerr << "Cannot create directory " << m_cfgdir << ": "
                  << std::strerror(errno) << '\n';
}

const QString Settings::file() const {
    return m_file;
}

void Settings::setFile(const QString &newFile) {
    m_file = m_cfgdir + '/' + newFile;

    std::ifstream cfgFile(m_file.toUtf8().data());
    if (cfgFile) {
        std::string line;

        std::getline(cfgFile, line);

        while (cfgFile) {
            std::string::size_type d = line.find('=');
            if (d == std::string::npos) {
                std::clog << "line skipped: " << line << '\n';
            }
            else {
                m_data[QString::fromUtf8(line.substr(0, d).c_str())] = QString::fromUtf8(line.substr(d+1).c_str());
            }

            std::getline(cfgFile, line);
        }
    }
}

const bool Settings::saveOnSet() const {
    return m_saveOnSet;
}

void Settings::setSaveOnSet(const bool yesno) {
    m_saveOnSet = yesno;
}


const QString Settings::get(const QString &name) const {
    return m_data.at(name);
}

bool Settings::set(const QString &name, const QString &value) {
    m_data[name] = value;

    return m_saveOnSet ? store() : true;
}

bool Settings::store() {
    std::ofstream cfgFile(m_file.toUtf8().data());

    if (! cfgFile) return false;

    for (MemStore::iterator i = m_data.begin(); i != m_data.end(); ++i) {
        cfgFile << i->first << '=' << i->second << '\n';
    }

    return true;
}
