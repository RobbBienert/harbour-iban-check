/**
  iostream support for QString and related Qt classes

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

#include "qstringio.h"

std::ostream& operator<<(std::ostream &o, const QString &s) {
    o << s.toUtf8().data();
    return o;
}

std::ostream& operator<<(std::ostream &o, const QUrl &u) {
    o << u.toString();
    return o;
}
