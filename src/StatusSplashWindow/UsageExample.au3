#include "StatusSplashWindow.au3"


; Usage example
;--------------
MsgBox(0, "StatusSplashWindow Example", "Create progress :")
_StatusSplashWindow($StatusSplashWindow_Action_Show, "Description of the task currently running.", $StatusSplashWindow_ProgressType_Green, 50, "My nice splash progress")
MsgBox(0, "StatusSplashWindow Example", "Update description :")
_StatusSplashWindow($StatusSplashWindow_Action_Update, "Second task is running.")
MsgBox(0, "StatusSplashWindow Example", "Change to marquee :")
_StatusSplashWindow($StatusSplashWindow_Action_Update, "", $StatusSplashWindow_ProgressType_Marquee)
MsgBox(0, "StatusSplashWindow Example", "Change to red progress with 75 :")
_StatusSplashWindow($StatusSplashWindow_Action_Update, "", $StatusSplashWindow_ProgressType_Red, 75)
MsgBox(0, "StatusSplashWindow Example", "Hide progress bar :")
_StatusSplashWindow($StatusSplashWindow_Action_HideBar)
MsgBox(0, "StatusSplashWindow Example", "Show progress bar again:")
_StatusSplashWindow($StatusSplashWindow_Action_Show)
MsgBox(0, "StatusSplashWindow Example", "Change to yellow and 20 percent :")
_StatusSplashWindow($StatusSplashWindow_Action_Update, "", $StatusSplashWindow_ProgressType_Yellow, 20)
MsgBox(0, "StatusSplashWindow Example", "Exit and delete window?")
_StatusSplashWindow($StatusSplashWindow_Action_DeleteWindow)
