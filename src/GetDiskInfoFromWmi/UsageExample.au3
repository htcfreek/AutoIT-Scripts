#include "GetDiskInfoFromWmi.au3"


; Usage example
;------------------
Local $aOutputDisks
Local $aOutputPartitions
_GetDiskInfoFromWmi($aOutputDisks, $aOutputPartitions, $DiskInfoWmi_TableHeader_Yes, $DiskInfoWmi_DiskType_Fixed)

_ArrayDisplay($aOutputDisks, "Disks")
_ArrayDisplay($aOutputPartitions,  "Partitons")
