import QtQuick 2.0

/**
  SailText implementing hyperlinks

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

SailText {
    textFormat: Text.StyledText
    onLinkActivated: Qt.openUrlExternally(link)
}

