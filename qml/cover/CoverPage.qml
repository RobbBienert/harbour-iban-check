/**
  cover page for the application dock

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Column {
        anchors.centerIn: parent
        spacing: Theme.paddingLarge

        // The optimal image width and height regarding the spacing
        // and the label.height.
        property int imgWidth: parent.width - 2 * spacing
        property int imgHeight: parent.height - label.height - 2 * spacing

        Label {
            id: label
            text: qsTr("IBAN Checker")
        }

        Image {
            // I don't know how to refer directly to one of the app icons,
            // so we hardlink the 128×128 version into the qml/cover folder.
            source: Qt.resolvedUrl(".") + "iban-check.png"
            width: parent.imgWidth > 128 ? 128 : parent.imgWidth
            height: parent.imgHeight > 128 ? 128 : parent.imgHeight

            // The image is centered inside the column:
            x: (parent.width - width) / 2
        }
    }
}
