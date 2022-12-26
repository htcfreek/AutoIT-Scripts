*********************************************************************
* Name: _WaitForAppWindow                                           *
* Description: Waits until a process opened a new window.           *
* Author: htcfreek (Heiko) - https://github.com/htcfreek [original] *
*********************************************************************

Detailed description:
---------------------
This function waits until an application defined by parameter (exe name or exe path) opens a new window.
You can specify a timeout to stop waiting after that time. Without timeout the function waits endless.

Function:
---------
_WaitForAppWindow ( $sAppExePath [, $iTimeout = 0] )

Parameters:
-----------
1. $sAppExePath : Path to the exe file or name of the program executable. (Example: "C:\Windows\Explorer.exe" or "Explorer.exe")                 
2. $iTimeout (Optional, Default value = 0) : Maximal time to wait for the program window. (If not defined or zero, the code waits endlessly.)

Output:
-------
A boolean value: True if a new window was being found within the timeout and False if the timeout is reached.
(If no timeout is defined and now new windows is found, the function keeps running.)

Usage example:
--------------
See the file 'UsageExample.au3' in this directory.