.pragma library

/**
 * Utility Library for harbour-iban-checker
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

function modulo(num, op) {
    num = num.toString();
    var theEnd = num.length;

    var j = String(op).length + 1;
    var stack = num.substring(0, j);
    var mod = String(parseInt(stack) % 97);

    var s, e;

    for (var i = 0; i < theEnd; ++i) {
        s = j + i;
        e = s + 1;
        if (s === theEnd) break;
        stack = mod + num.substring(s, e);
        mod = String(parseInt(stack) % 97);
    }

    return parseInt(mod);
}

function prepareIBan(country, check, number) {
    var cc = countryCode(country);

	var num = letterCode(number.replace(' ', '')) + cc + check.toString();

	return modulo(num, 97);
}

function checkIban(country, check, number) {
    return prepareIBan(country, check, number) === 1;
}

function calcChecksum(country, number) {
    var r = 98 - prepareIBan(country, '00', number);
    return r < 10 ? '0'+r : r;
}

var CA = 'A'.charCodeAt(0)
var Shift = CA - 10;
var CZ = 'Z'.charCodeAt(0)
var C0 = '0'.charCodeAt(0)
var C9 = '9'.charCodeAt(0)

// converting A-Z letter to digit
function letterCode(numstr) {
    var num = ""
    var strl = numstr.length
    var cc;

    for (var i = 0; i < strl; ++i) {
        cc = numstr.charCodeAt(i)
        if (cc >= C0 && cc <= C9)
            num += numstr[i]
        else if (cc >= CA && cc <= CZ)
            num += (cc - Shift).toString()
    }

    return num
}

function zeroS(length) {
	var a = Array(length);

	for (var i = 0; i < length; ++i)
		a[i] = '0';

	return a.join('');
}

/* calculates the countrys numerical code from a given letter code
 */
function countryCode(cc) {
    if (cc.length !== 2)
        return 0;

    return letterCode(cc)
}

function Country(ibanLength) {
	this.len = ibanLength
	this.index = -1
}

//--Countries

var Lengths = {
	"EG": new Country(27),	// Ägypten 
	"AL": new Country(28),	// Albanien 
	"DZ": new Country(24),	// Algerien 
	"AD": new Country(24),	// Andorra 
	"AO": new Country(25),	// Angola 
	"AZ": new Country(28),	// Aserbaidschan 
	"BH": new Country(22),	// Bahrain 
	"BE": new Country(16),	// Belgien 
	"BJ": new Country(28),	// Benin 
	"BA": new Country(20),	// Bosnien und Herzegowina 
	"BR": new Country(29),	// Brasilien 
	"VG": new Country(24),	// Britische Jungferninseln 
	"BG": new Country(22),	// Bulgarien 
	"BF": new Country(27),	// Burkina Faso 
	"BI": new Country(16),	// Burundi 
	"CR": new Country(21),	// Costa Rica 
	"CI": new Country(28),	// Côte d'Ivoire (Elfenbeinküste) 
	"DK": new Country(18),	// Dänemark 
	"DE": new Country(22),	// Deutschland 
	"DO": new Country(28),	// Dominikanische Republik 
	"EE": new Country(20),	// Estland 
	"FO": new Country(18),	// Färöer 
	"FI": new Country(18),	// Finnland 
	"FR": new Country(27),	// Frankreich
	"GA": new Country(27),	// Gabun 
	"GE": new Country(22),	// Georgien 
	"GI": new Country(23),	// Gibraltar 
	"GR": new Country(27),	// Griechenland 
	"GL": new Country(18),	// Grönland 
	"GT": new Country(28),	// Guatemala 
	"IR": new Country(26),	// Iran 
	"IE": new Country(22),	// Irland 
	"IS": new Country(26),	// Island 
	"IL": new Country(23),	// Israel 
	"IT": new Country(27),	// Italien 
	"JO": new Country(30),	// Jordanien 
	"CM": new Country(27),	// Kamerun 
	"CV": new Country(25),	// Kap Verde 
	"KZ": new Country(20),	// Kasachstan 
	"QA": new Country(29),	// Katar 
	"CG": new Country(27),	// Kongo (Brazzaville) 
	"XK": new Country(20),	// Kosovo 
	"HR": new Country(21),	// Kroatien 
	"KW": new Country(30),	// Kuwait 
	"LV": new Country(21),	// Lettland 
	"LB": new Country(28),	// Libanon 
	"LI": new Country(21),	// Liechtenstein 
	"LT": new Country(20),	// Litauen 
	"LU": new Country(20),	// Luxemburg 
	"MG": new Country(27),	// Madagaskar 
	"ML": new Country(28),	// Mali 
	"MT": new Country(31),	// Malta 
	"MR": new Country(27),	// Mauretanien 
	"MU": new Country(30),	// Mauritius 
	"MK": new Country(19),	// Mazedonien 
	"MD": new Country(24),	// Moldawien 
	"MC": new Country(27),	// Monaco 
	"ME": new Country(22),	// Montenegro 
	"MZ": new Country(25),	// Mosambik 
	"NL": new Country(18),	// Niederlande 
	"NO": new Country(15),	// Norwegen 
	"AT": new Country(20),	// Österreich 
	"TL": new Country(23),	// Osttimor 
	"PK": new Country(24),	// Pakistan 
	"PS": new Country(29),	// Palästinensische Autonomiegebiete 
	"PL": new Country(28),	// Polen 
	"PT": new Country(25),	// Portugal 
	"RO": new Country(24),	// Rumänien 
	"SM": new Country(27),	// San Marino 
	"ST": new Country(25),	// São Tomé und Príncipe 
	"SA": new Country(24),	// Saudi-Arabien 
	"SE": new Country(24),	// Schweden 
	"CH": new Country(21),	// Schweiz 
	"SN": new Country(28),	// Senegal 
	"RS": new Country(22),	// Serbien 
	"SC": new Country(31),	// Seychellen 
	"SK": new Country(24),	// Slowakei 
	"SI": new Country(19),	// Slowenien 
	"ES": new Country(24),	// Spanien 
	"CZ": new Country(24),	// Tschechien 
	"TN": new Country(24),	// Tunesien 
	"TR": new Country(26),	// Türkei 
	"UA": new Country(29),	// Ukraine 
	"HU": new Country(28),	// Ungarn 
	"AE": new Country(23),	// Vereinigte Arabische Emirate 
	"GB": new Country(22),	// Vereinigtes Königreich
	"CY": new Country(28),	// Zypern 
	"CF": new Country(27),	// Zentralafrikanische Republik 
	"XX": new Country(16),	// *** example *** 
}
//--Countries

// http://wiki.selfhtml.org/wiki/JavaScript/Objekte/Object/keys
var Countries = Object.keys(Lengths);
var nCountries = Countries.length;

for (var i = 0; i < nCountries; ++i) {
	Lengths[Countries[i]].index = i
}

