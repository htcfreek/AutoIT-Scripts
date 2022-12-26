#include "GetInstalledPrinterFromWmi.au3"
#include "Array.au3"


; Usage example 1
;-----------------
MsgBox (0, "Example 1", "No filter and return a string:")
$r1 = _GetInstalledPrinterFromWmi()
MsgBox (0, "Example 1 - Result", $r1)

; Usage example 2
;-----------------
MsgBox (0, "Example 2", "No filter and return a string with ; as delimiter:")
$r2 = _GetInstalledPrinterFromWmi($InstalledPrinterWmi_ReturnType_String,"*",";")
MsgBox (0, "Example 2 - Result", $r2)

; Usage example 3
;-----------------
MsgBox (0, "Example 3", "With filter 'Microsoft*' and return a string:")
$r3 = _GetInstalledPrinterFromWmi($InstalledPrinterWmi_ReturnType_String, "Microsoft*")
MsgBox (0, "Example 3 - Result", $r3)

; Usage example 4
;-----------------
MsgBox (0, "Example 4", "No filter and return an array:")
$r4 = _GetInstalledPrinterFromWmi($InstalledPrinterWmi_ReturnType_Array)
_ArrayDisplay ($r4, "Example 4 - Result")

; Usage example 5
;-----------------
MsgBox (0, "Example 5", "With filter '*Mi*' and return an array:")
$r5 = _GetInstalledPrinterFromWmi($InstalledPrinterWmi_ReturnType_Array, "*Mi*")
_ArrayDisplay ($r5, "Example 5 - Result")
