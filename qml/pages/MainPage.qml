/**
 * main page
 *
 * Project: harbour-iban-check
 * Copyright (C) 2016 - 2018 Robert Bienert
 * Contact: Robert Bienert <robertbienert@gmx.net>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.iban.check 1.0

import "../ibancheck.js" as IBANCheck


Page {
    id: page

    // object properties
    property bool manualCountry: false

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: qsTr("About …")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Help")
                onClicked: pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            spacing: Theme.paddingLarge
            x: spacing
            width: page.width - 2 *spacing
            PageHeader {
                title: qsTr("IBAN Checker")
            }

            TextField {
                id: ibanIn
                width: parent.width
                placeholderText: "XX00 0000 0000 0000 0000 …"
                label: qsTr("(Copy & Paste) IBAN")
                horizontalAlignment: Text.AlignLeft
                onTextChanged: {
                    manualCountry = false;
                }
                validator: RegExpValidator {
                    regExp: /^[a-zA-Z]{2}[\s0-9A-Za-z]*$/
                }

                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: ibanCheck()
            }

            Label {
                text: qsTr(" … or fill in the following fields:")
            }

            Row {
                id: ibanCountry
                width: parent.width
                spacing: Theme.paddingLarge

                ComboBox {
                    id: ibanCountryIn
                    width: parent.width / 2
                    label: qsTr("Country")
                    value: currentItem.text

                    menu: ContextMenu {
                        // https://lists.sailfishos.org/pipermail/devel/2013-June/000404.html
                        Repeater {
                            model: ListModel {
                                id: menuModel
                                Component.onCompleted: {
                                    for (var i = 0; i < IBANCheck.nCountries; ++i) {
                                        append({'name': IBANCheck.Countries[i]})
                                    }
                                }
                            }
                            MenuItem { text: model.name }
                        }
                        onActivated: {
                            manualCountry = true;
                            ibanCountryIn.currentIndex = index
                            var name = IBANCheck.Countries[index]
                            ibanCountryIn.value = name
                            ibanNumberIn.maximumLength = IBANCheck.Lengths[name].len - 4;
                        }
                    }
                    Component.onCompleted: {
                        var loc = settings.getLastCountry()
                        if ('' !== loc) {
                            currentIndex = IBANCheck.Lengths[loc].index
                            value = loc
                        }
                    }
                }

                TextField {
                    id: ibanCheckIn
                    width: parent.width / 2
                    placeholderText: "00"
                    label: qsTr("Checksum")
                    horizontalAlignment: Text.AlignLeft
                    inputMethodHints: Qt.ImhDigitsOnly
                    maximumLength: 2
                    EnterKey.enabled: ibanNumberIn.text.length > 0
                    EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                    EnterKey.onClicked: ibanCheck()
                }
            }

            TextField {
                id: ibanNumberIn
                width: parent.width
                placeholderText: "0000 0000 0000 0000 00"
                label: qsTr("Bank Account Number")
                horizontalAlignment: Text.AlignLeft
                inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhUppercaseOnly
                maximumLength: 18
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                EnterKey.onClicked: ibanCheck()
            }

			Row {
				width: parent.width
				spacing: Theme.paddingMedium

				Label {
					text: qsTr("Zero pad:")
				}

				Button {
					width: parent.width / 3 - parent.spacing
					text: qsTr("front")
					onClicked: {
						ibanNumberIn.text = IBANCheck.zeroS(ibanNumberIn.maximumLength - ibanNumberIn.length) + ibanNumberIn.text
					}
				}

				Button {
					width: parent.width / 3 - parent.spacing
					text: qsTr("back")
					onClicked: {
						ibanNumberIn.text += IBANCheck.zeroS(ibanNumberIn.maximumLength - ibanNumberIn.length)
					}
				}
			}

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Check")
                onClicked: ibanCheck()
            }

            Row {
                width: parent.width
                spacing: Theme.paddingMedium

                TextSwitch {
                    id: ibanOK
					width: parent.width * 0.4 - parent.spacing
                    text: qsTr("OK")
                    automaticCheck: false
                }

                TextSwitch {
                    id: ibanNotOK
					width: parent.width * 0.6 - parent.spacing
                    text: qsTr("incorrect")
                    automaticCheck: false
                }
            }
        }
    }

    function ibanCheck() {
        if (ibanIn.text.length > 0) {
            ibanIn.text = ibanIn.text.toUpperCase();
            var iban = ibanIn.text.replace(/\s/g, "");
            if (! manualCountry)
                ibanCountryIn.value = iban.substr(0, 2);
            ibanCheckIn.text    = iban.substr(2, 2);
            ibanNumberIn.text   = iban.substr(4);
        }
        if (0 == ibanCheckIn.text.length || '00' == ibanCheckIn.text
                || 'XX' == ibanCheckIn.text)
        {
            ibanCheckIn.text = IBANCheck.calcChecksum(ibanCountryIn.value,
                                                      ibanNumberIn.text);
        }
        var res = IBANCheck.checkIban(ibanCountryIn.value, ibanCheckIn.text, ibanNumberIn.text)
        if (res)
            ibanIn.text = ibanCountryIn.value + ibanCheckIn.text + ibanNumberIn.text;
        ibanOK.checked = res
        ibanNotOK.checked = !res

        settings.set(settings.LastCountry, ibanCountryIn.value)
    }

    Settings {
        id: settings
        file: 'iban-check.ini'
        saveOnSet: true
    }
}
