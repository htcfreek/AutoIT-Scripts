; Includes
;----------
#include-once
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>
#include <SendMessage.au3>



#cs
===============================================================================================================================
 Title ...............: _StatusSplashWindow (GitHub: https://github.com/htcfreek/AutoIt-Scripts)
 Version .............: 1.0
 License .............: GNU LGPLv3
 AutoIt Version ......: 3.3.14.5+
 Language ............: English
 Description .........: Shows a custom status window with progress, desctiprion and some nice control features.
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
Global Const $StatusSplashWindow_Action_Show = 0
Global Const $StatusSplashWindow_Action_Update = 1
Global Const $StatusSplashWindow_Action_HideBar = 2
Global Const $StatusSplashWindow_Action_DeleteWindow = -1

Global Const $StatusSplashWindow_ProgressType_Green = 1
Global Const $StatusSplashWindow_ProgressType_Red = 2
Global Const $StatusSplashWindow_ProgressType_Yellow = 3
Global Const $StatusSplashWindow_ProgressType_Marquee = 4

Global Const $StatusSplashWindow_WindowPos_Center = -1
Global Const $StatusSplashWindow_WindowPos_Top = 0



; Function
; ---------
Func _StatusSplashWindow($iAction, $sTxtMain = "", $iProgressType = "", $iProgressPercent = "", $sSplashWindowTitle = "", $iWindowPosition = $StatusSplashWindow_WindowPos_Top)
	; Name ...............: _CustomMarqueeProgressWindow
	; Author .............: htcfreek (Heiko) - https://github.com/htcfreek
	; Input parameter ....: $iAction = Action to do with the window or its controls. (Possible values: $StatusSplashWindow_Action_Show|$StatusSplashWindow_Action_Update|$StatusSplashWindow_Action_HideBar|$StatusSplashWindow_Action_DeleteWindow)
	;					    [$sTxtMain = ""] = Information / description text shown to the user.
	;                       [$iProgressType = ""] = Type of the progress bar. (Possible values: $StatusSplashWindow_ProgressType_Green|$StatusSplashWindow_ProgressType_Red|$StatusSplashWindow_ProgressType_Yellow|$StatusSplashWindow_ProgressType_Marquee)
	;					    [$sSplashWindowTitle = ""] = Titel of the window. (Required when calling the function for the first time.)
	;                       [$iWindowPosition = $StatusSplashWindow_WindowPos_Top] = Position of the window. (Required when calling the function for the first time.; Possible values: $StatusSplashWindow_WindowPos_Center|$StatusSplashWindow_WindowPos_Top)
	; Output .............: none


	; Static Gui variables
	Static $hProgressWindow
	Static $idProgress
	Static $idLabel


	; Create Gui
	If Not ($hProgressWindow) Then
		$hProgressWindow = GUICreate($sSplashWindowTitle, 400, 80, -1, $iWindowPosition, BitOR($WS_POPUP, $WS_CAPTION, $WS_DISABLED), BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
		GUISetFont(11, 400, 0, "Arial")
		;--
		$idLabel = GUICtrlCreateLabel($sTxtMain, 20, 10, 360, 40, $SS_CENTER)
		;--
		if ($iProgressType = "" OR $iProgressType = $StatusSplashWindow_ProgressType_Marquee) Then
			$idProgress = GUICtrlCreateProgress(20, 50, 360, 20, $PBS_MARQUEE, -1)
			GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 1, 50) ; Send the message $PBM_SETMARQUEE and wParam of 1 to start the scrolling marquee.
		Else
			$idProgress = GUICtrlCreateProgress(20, 50, 360, 20, 1, -1)
			GUICtrlSetData($idProgress, $iProgressPercent)
		EndIf
	EndIf

	;Show/Change/Delete Gui
	Switch $iAction
		Case -1
			; Delet Gui
			GUIDelete($hProgressWindow)
			$hProgressWindow = Null
		Case 0 To 2
			; Show Gui
			GUISetState(@SW_SHOW)
			Switch $iAction
				Case 0
					; Show progress
					GUICtrlSetState($idProgress, $GUI_SHOW)
				Case 1
					; Update properties
					if ($sTxtMain <> "") Then 
						; Set text
						GUICtrlSetData($idLabel, $sTxtMain)
					EndIf
					if ($iProgressType = $StatusSplashWindow_ProgressType_Green AND $iProgressPercent >= 0) Then
						; Set green progress bar
						GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 0, 0)
						GUICtrlSetStyle($idProgress, -1)
						_SendMessage(GUICtrlGetHandle($idProgress), $PBM_SETSTATE, 1, 0)
						GUICtrlSetData($idProgress, $iProgressPercent)
					ElseIf ($iProgressType = $StatusSplashWindow_ProgressType_Marquee) Then
						; Set marquee progress
						_SendMessage(GUICtrlGetHandle($idProgress), $PBM_SETSTATE, 1, 0)
						GUICtrlSetStyle($idProgress, $PBS_MARQUEE)
						GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 1, 50)
					ElseIf ($iProgressType <> "" AND $iProgressPercent >= 0) Then
						; Set colored progress
						GUICtrlSendMsg($idProgress, $PBM_SETMARQUEE, 0, 50)
						GUICtrlSetStyle($idProgress, 1)
						_SendMessage(GUICtrlGetHandle($idProgress), $PBM_SETSTATE, 1, 0)
						GUICtrlSetData($idProgress, $iProgressPercent)
						_SendMessage(GUICtrlGetHandle($idProgress), $PBM_SETSTATE, $iProgressType, 0)
					EndIf
				Case 2
					; Hide progress
					GUICtrlSetState($idProgress, $GUI_HIDE)
			EndSwitch
	EndSwitch
EndFunc   ;==>_CustomMarqueeProgressWindow
