import QtQuick 2.0
import Sailfish.Silica 1.0

/**
  Sailfish.Silica.Label formatted as some kind of heading

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

Label {
    x: Theme.paddingLarge
    width: parent.width - 2*Theme.paddingLarge
    wrapMode: Text.WordWrap
    color: Theme.secondaryHighlightColor
}
