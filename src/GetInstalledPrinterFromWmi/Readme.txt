**********************************************************************************************
* Name: _GetInstalledPrinterFromWmi                                                          *
* Description: Returns a list of installed printers for the current user as array or string. *
* Author: htcfreek (Heiko) - https://github.com/htcfreek [original]                          *
**********************************************************************************************

Detailed description:
---------------------
This function returns a list of printers installed for the current user.
You can choose the return type (array or string), filter the list by printer name and change the delimiter sign used for the returned string list.
TIP: Even if you choose array as return type, it can help to change the String delimiter sign if you have problems with printers using that sign.

Function:
---------
_GetInstalledPrinterFromWmi ( [$sReturnType = $InstalledPrinterWmi_ReturnType_String [, $sPrinterName = "*" [, $sStringSplitSign = ","]]] )

Parameters:
-----------
1. $sReturnType (Optional, Default value = $InstalledPrinterWmi_ReturnType_String) : The return type: Array or String (Possible values: $InstalledPrinterWmi_ReturnType_Array|$InstalledPrinterWmi_ReturnType_String)
2. $sPrinterName (Optional, Default value = "*") : A string (Example: "HP*") to filter the printers by name. (You can use * as wildcard character.)
3. $sStringSplitSign (Optional, Default value = ",") : A sign used as delimiter when returning a string.


Output:
-------
The list of installed printers in the specified type or nothing.

Usage example:
--------------
See the file 'UsageExample.au3' in this directory.