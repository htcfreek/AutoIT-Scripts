#include "WaitForAppWindow.au3"


; Usage example 1
;------------------
MsgBox(0, "Example 1", "Wait for cmd.exe with a timeout of 60 seconds:")
Run("cmd.exe /c pause")
Local $r1 = _WaitForAppWindow("cmd.exe", 60)
MsgBox(0, "Example 1", "A new window was found: " & ($r1))

; Usage example 2
;------------------
MsgBox(0, "Example 2", "Wait for C:\MyApp\MyApp.exe with a timeout of 5 seconds:")
Run("C:\MyApp\MyApp.exe")
Local $r2 = _WaitForAppWindow("C:\MyApp\MyApp.exe", 5)
MsgBox(0, "Example 2", "Timeout of 5 seconds reached. A new windows was found: " & $r2)

; Usage example 3
;------------------
MsgBox(0, "Example 3", "Wait for C:\MyApp\MyApp.exe without timeout:")
Run("C:\MyApp\MyApp.exe")
Local $r3 = _WaitForAppWindow("C:\MyApp\MyApp.exe", 0)
MsgBox(0, "Example 3", "This MsgBox will never appear, because the funtion waits endless.")