; Includes
;----------
#include-once
#include <Array.au3>
#include <Timers.au3>
#include <WinAPIShPath.au3>



#cs
===============================================================================================================================
 Title ...............: _WaitForAppWindow (GitHub: https://github.com/htcfreek/AutoIt-Scripts)
 Version .............: 1.0
 License .............: GNU LGPLv3
 AutoIt Version ......: 3.3.14.5+
 Language ............: English
 Description .........: Waits until a process specified by name or path opened a new window.
 Author ..............: htcfreek (Heiko) - https://github.com/htcfreek [original]
 Modified ............:
 Required includes ...: Array.au3, Timers.au3, WinAPIShPath.au3
 Dll .................:
===============================================================================================================================

CHANGELOG:
	2022-12-25 (v1.0)
		New: Initial release

#ce



; Function
; ---------
Func _WaitForAppWindow($sAppExePath, $iTimeout = 0)
	; Name ...............: _WaitForAppWindow
	; Author .............: htcfreek (Heiko) - https://github.com/htcfreek
	; Input parameter ....: $sAppExePath = Path to the exe file or name of the program executable. (Example: "C:\Windows\Explorer.exe" or "Explorer.exe")
	;                       [$iTimeout = 0] = Maximal time to wait for the program window. (If not defined or zero, the code waits endlessly.)
	; Output parameter ...: True = A new window was found.
	;						False = Now new window was found and the timeout was reached.
	;						(None) = If no timeout is defined and now new window is opened by the app, the function runs endlessly.

	; Initialize function wide vars
	$iTimeout *= 1000
	Local Const $sProcessName = _WinAPI_PathFindFileName($sAppExePath)
	Local $aFoundWinListOld[1]
	Local $bReturnCode = True
	Local $hStarttime = _Timer_Init()


	; Waiting loop
	While 1
		; Variables for each loop
		Local $aProcessList = ProcessList($sProcessName)
		Local $aAllWinList = WinList()
		Local $aFoundWinList[1]

		; Identify the correct winwods in the list
		For $i = 1 To UBound($aAllWinList) - 1
			$hWin = $aAllWinList[$i][1]
			$iProcessID = WinGetProcess($hWin)
			$iWinState = WinGetState($hWin)
			If _ArraySearch($aProcessList, $iProcessID) > -1 Then
				; Save the window id in the array, if the window is visible
				If BitAND($iWinState, 2) Then
					_ArrayAdd($aFoundWinList, $hWin)
				EndIf
			EndIf
		Next
		; Sort the window list, assign temporary variables and remember window list for the next run
		_ArraySort($aFoundWinList)
		Local $sListOld = _ArrayToString($aFoundWinListOld)
		Local $sListNew = _ArrayToString($aFoundWinList)
		$aFoundWinListOld = $aFoundWinList
		; Check window lists and the timer / Exit from the loop
		If (_Timer_Diff($hStarttime) >= $iTimeout) And ($iTimeout > 0) Then
			$bReturnCode = False
			ExitLoop
		ElseIf (Not ($sListOld == $sListNew) And Not ($sListNew == "")) Then
			$bReturnCode = True
			ExitLoop
		EndIf
		; Wait 500 milliseconds to save CPU resources
		Sleep(500)
	WEnd

	Return $bReturnCode
EndFunc   ;==>_WaitAppWindow
