********************************************************************************************************
* Name: _StatusSplashWindow											                                   *
* Description: Shows a custom status window with progress, description and some nice control features. *
* Author: htcfreek (Heiko) - https://github.com/htcfreek [original]	                                   *
********************************************************************************************************

Detailed description:
---------------------
Shows a custom status window with progress, description and some nice control features.
You can call the function again to update the window or to close it.

Function:
---------
_StatusSplashWindow ( $iAction [, $sTxtMain = "" [, $iProgressType = "" [, $iProgressPercent = "" [, $sSplashWindowTitle = "" [, $iWindowPosition = $StatusSplashWindow_WindowPos_Top]]]]] )

Parameters:
-----------
1. $iAction : Action to do with the window or its controls. (Possible values: $StatusSplashWindow_Action_Show|$StatusSplashWindow_Action_Update|$StatusSplashWindow_Action_HideBar|$StatusSplashWindow_Action_DeleteWindow)
2. $sTxtMain (Optional, Default value = "") : Information / description text shown to the user.
3. $iProgressType (Optional, Default value = "") : Type of the progress bar. (Possible values: $StatusSplashWindow_ProgressType_Green|$StatusSplashWindow_ProgressType_Red|$StatusSplashWindow_ProgressType_Yellow|$StatusSplashWindow_ProgressType_Marquee)
4. $sSplashWindowTitle (Optional, Default value = "") : Titel of the window. (Required when calling the function for the first time.)
5. $iWindowPosition (Optional, Default value = $StatusSplashWindow_WindowPos_Top) : Position of the window. (Required when calling the function for the first time.; Possible values: $StatusSplashWindow_WindowPos_Center|$StatusSplashWindow_WindowPos_Top)

Output:
-------
The function has no return value or output.

Usage example:
--------------
See the file 'UsageExample.au3' in this directory.