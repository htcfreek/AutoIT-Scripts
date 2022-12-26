; Includes
;----------
#include-once



#cs
===============================================================================================================================
 Title ...............: _GetInstalledPrinterFromWmi (GitHub: https://github.com/htcfreek/AutoIt-Scripts)
 Version .............: 1.0
 License .............: GNU LGPLv3
 AutoIt Version ......: 3.3.14.5+
 Language ............: English
 Description .........: Returns a list of installed printers for the current user as array or string. You can filter the list of printers.
 Author ..............: htcfreek (Heiko) - https://github.com/htcfreek [original]
 Modified ............:
 Required includes ...: 
 Dll .................:
===============================================================================================================================

CHANGELOG:
	2022-12-26 (v1.0)
		New: Initial release

#ce



; Global constants
; -----------------
Global Const $InstalledPrinterWmi_ReturnType_Array = "A"
Global Const $InstalledPrinterWmi_ReturnType_String = "S"



; Function
; ---------
Func _GetInstalledPrinterFromWmi($sReturnType = $InstalledPrinterWmi_ReturnType_String, $sPrinterName = "*", $sStringSplitSign = ",")
	; Name ...............: _GetInstalledPrinterFromWmi
	; Author .............: htcfreek (Heiko) - https://github.com/htcfreek
	; Input parameter ....: [$sReturnType = $InstalledPrinterWmi_ReturnType_String] = The return type: Array or String (Possible values: $InstalledPrinterWmi_ReturnType_Array|$InstalledPrinterWmi_ReturnType_String)
	;                       [$sPrinterName = "*"] = A string (Example: "HP*") to filter the printers by name. (You can use * as wildcard character.)
	;                       [$sStringSplitSign = ","] = A sign used as delimiter when returning a string.
	; Output .............: Printer list as array or string. If no printer was found, nothing is returned.
	; On WMI-Error .......: @error = 1
	; Tip ................: Even if you choose array as return type, it can help to change the String delimiter sign if you have problems with printers using that sign.


    ; Initialize function wide vars
	Local $wbemFlagReturnImmediately = 0x10
	Local $wbemFlagForwardOnly = 0x20
	Local $sPrinterString
	
	; WMI query and returning the results
	Local $sFilter = StringReplace(" Where Name like '" & $sPrinterName & "'", "*", "%")
	Local $oWMIService = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	If IsObj($oWMIService) And (Not @error) Then
		Local $oPrinters = $oWMIService.ExecQuery("Select Name from Win32_Printer" & $sFilter, "WQL", $wbemFlagReturnImmediately + $wbemFlagForwardOnly)
		If Not IsObj($oPrinters) Then Return
		For $oPrinter In $oPrinters
			$sPrinterString = $oPrinter.Name & $sStringSplitSign & $sPrinterString
		Next
		Switch $sReturnType
			Case "A"
				; Return array
				Local $aPrinterArray = StringSplit(StringTrimRight($sPrinterString, 1), $sStringSplitSign, 2)
				Return $aPrinterArray
			Case "S"
				; Return string
				Return StringTrimRight($sPrinterString, 1)
		EndSwitch
	Else
		; If WMI-Error then set @error
		SetError(1)
	EndIf
EndFunc   ;==>_GetInstalledPrinterFromWmi

