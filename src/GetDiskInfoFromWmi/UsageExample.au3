#include "GetDiskInfoFromWmi.au3"


; Usage example
;------------------
Local $aOutputDisks
Local $aOutputPartitions
_GetDiskInfoFromWmi($aOutputDisks, $aOutputPartitions, $DiskInfoWmi_TableHeader_Yes, $DiskInfoWmi_DiskType_Fixed)
If @error Then MsgBox(16, @ScriptName, "Something went wrong!")

_ArrayDisplay($aOutputDisks, "Disks")
_ArrayDisplay($aOutputPartitions, "Partitions")
