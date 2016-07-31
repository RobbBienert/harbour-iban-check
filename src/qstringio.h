/**
  iostream support for QString and related Qt classes

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#ifndef QSTRINGIO_H
#define QSTRINGIO_H

#include <iostream>
#include <QString>
#include <QUrl>

std::ostream& operator<<(std::ostream &o, const QString &s);

std::ostream& operator<<(std::ostream &o, const QUrl &u);

#endif // QSTRINGIO_H
