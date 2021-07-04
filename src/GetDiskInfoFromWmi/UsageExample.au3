#include "GetDiskInfoFromWmi.au3"


; Usage example
;------------------
Local $aOutputDisks
Local $aOutputPartitions
_GetDiskInfoFromWmi($aOutputDisks, $aOutputPartitions, $DiskInfoWmi_TableHeader_Yes, $DiskInfoWmi_DiskType_Fixed)
If @error Then MSGBOX(16, @ScriptName, "Somethig goes wrong!")

_ArrayDisplay($aOutputDisks, "Disks")
_ArrayDisplay($aOutputPartitions,  "Partitons")
