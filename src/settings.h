/**
  configuration file based settings

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QString>
#include <map>
#include <string>

// Inside the Settings class we use a map as store:
typedef std::map<QString,QString> MemStore;

class Settings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString file READ file WRITE setFile)
    /* This property holds the name of the ini file. By setting it the
     * file name is expanded to a full path pointing in the users
     * .config directory.
     */

    Q_PROPERTY(bool saveOnSet READ saveOnSet WRITE setSaveOnSet)
    /* The class can be configured that it automatically saves the
     * settings to the file everytime they are updated.
     */

public:
    explicit Settings(QObject *parent = 0);

    const QString file() const;
    void setFile(const QString &newFile);

    const bool saveOnSet() const;
    void setSaveOnSet(const bool yesno);

    // public interface
    Q_INVOKABLE const QString get(const QString &name) const;
    /* This method returns the configuration setting stored under the key
     * "name". If there is no such value, an std::out_of_range exception
     * is thrown.
     */

    Q_INVOKABLE bool set(const QString &name, const QString &value);

    Q_INVOKABLE bool store();

signals:

public slots:

private:
    MemStore m_data;
    QString m_cfgdir;
    QString m_file;
    bool m_saveOnSet;
};

#endif // SETTINGS_H
