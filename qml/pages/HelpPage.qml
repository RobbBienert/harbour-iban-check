/**
  help page

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
        contentHeight: column.height

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
                title: qsTr("IBAN Checker Help")
            }

            SailText {
                id: desc
                text: qsTr("This app helps you for a quick (but only formal!) check of your IBAN.")
            }
            SailText {
                id: usage
                text: qsTr("You can either fill in a complete IBAN (copy & paste) or create it step-by-step by selecting country, checksum and bank account number. If the checksum is not filled in (or is set to either '00' or 'xx') it is calculated.")
            }

            SailTextHeader {
                text: qsTr('Formal Check')
            }
            TextWithLink {
                id: warning
                text: qsTr("The IBAN check is only done by checking the number against the given checksum using the algorithm described in ISO 13616-1:2007. The actual validity can only be checked by banks and finance institutes.<br>For details see e. g.") + " <a href=\"" + qsTr("https://en.wikipedia.org/wiki/International_Bank_Account_Number") + "\"><font color=\"" + Theme.highlightColor + "\">" + qsTr("Wikipedia: IBAN") + "</font></a>."
            }

            SailTextHeader {
                text: qsTr('Testing Functions')
            }
            SailText {
                id: tests
                text: qsTr("As mentioned above, you can calculate the checksum by leaving the input empty or fill it with '00' or 'xx'.\nFor further testing without using real bank account numbers, there is also a example country 'XX' at the end of the long list of countries.")
            }
        }
        ScrollDecorator {}
    }
}

