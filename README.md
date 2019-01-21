# harbour-iban-check
SailfishOS app for a formal check of IBANs (International Bank Account Number)

Copyright (C) 2016 Robert Bienert

## Description
### Usage
You can either fill in a complete IBAN (copy & paste) or create it step-by-step by selecting country, checksum and bank account number. If the checksum is not filled in (or is set to either '00' or 'xx') it is calculated.

### Formal Check
The IBAN check is only done by checking the number against the given checksum using the algorithm described in ISO 13616-1:2007. The actual validity can only be checked by banks and finance institutes.

For details see e. g. [Wikipedia: IBAN](https://en.wikipedia.org/wiki/International_Bank_Account_Number).

### Testing Functions
As mentioned above, you can calculate the checksum by leaving the input empty or fill it with '00' or 'xx'.\nFor further testing without using real bank account numbers, there is also a example country 'XX' at the end of the long list of countries.

## License
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but **without any warranty**; without even the implied warranty of **merchantability** or **fitness for a particular purpose**.

See the [GNU General Public License](http://www.gnu.org/licenses/gpl-3.0) for more details.

## Publication

This app is published in binary format to

 * the Jolla harbour (access from the *Store* app on your mobile device)
 * [OpenRepos](https://openrepos.net/content/robbbienert/iban-checker)
