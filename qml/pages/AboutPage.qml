/**
  about page

  Project: harbour-iban-check
  Copyright (C) 2016 Robert Bienert
  Contact: Robert Bienert <robertbienert@gmx.net>
  */

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../types"

Page {
    id: page

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge

        Column {
            id: column
            width: parent.width
            height: totalHeight()
            anchors.leftMargin: Theme.paddingMedium
            anchors.rightMargin: Theme.paddingMedium
            spacing: Theme.paddingMedium

            function totalHeight() {
                var h = 0
                var l = column.children.length

                for (var i = 0; i < l; ++i)
                    h += column.children[i].height

                return h + l * column.spacing
            }

            PageHeader {
                id: header
                title: qsTr("About IBAN Checker")
            }
            SailText {
                id: about
                text: qsTr("formal check for IBANs (International Bank Account Number)")
            }
            SailText {
                id: copyright
                text: "Version 1.1\nCopyright © 2016 Robert Bienert"
            }
            TextWithLink {
                id: link
                text: '<a href="https://github.com/RobbBienert/harbour-iban-check">Git Repository &amp; Wiki</a>'
            }

            SailTextHeader {
                text: qsTr("Credits")
            }
            TextWithLink {
                id: credits
                text: "· Français: <a href=\"https://github.com/Quent-in\">Quent-in</a><br>· Svenska: <a href=\"https://github.com/eson57\">eson57</a>"
            }

            SailTextHeader {
                text: qsTr("License")
            }

            TextWithLink {
                id: license
                text: qsTr("This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.<br>This program is distributed in the hope that it will be useful, but <strong>without any warranty</strong>; without even the implied warranty of <strong>merchantability</strong> or <strong>fitness for a particular purpose</strong>.") +  ' <a href="http://www.gnu.org/licenses/gpl-3.0">' + qsTr("See the GNU General Public License for more details.") + "</a>"
            }
        }
        ScrollDecorator {}
    }
}
