#include <Array.au3>
#include "GetDiskInfoFromWmi.au3"



; Usage example
;------------------
Local $aOutputDisks
Local $aOutputPartitions
_GetDiskInfoFromWmi($aOutputDisks, $aOutputPartitions, 1)

_ArrayDisplay($aOutputDisks, "Disks")
_ArrayDisplay($aOutputPartitions,  "Partitons")
