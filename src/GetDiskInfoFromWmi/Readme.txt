**********************************************************************
* Name: _GetDiskInfoFromWmi                                          *
* Description: Returns disk and partition information from WMI.      *
* Author: htcfreek (Heiko) - https://github.com/htcfreek [original]  *
**********************************************************************

Detailed description:
---------------------
This function generates two arrays conatining the list of all disks on this computer and all partitions on this computer. The arrays are returned using the output parameters of the function.
There are two more fucntion parameters you can use to control the output: One to decide if the array tables should have a header line and one to control which types of disks are returned.

Function:
---------
_GetDiskInfoFromWmi ( ByRef $aDiskList , ByRef $aPartitionList [, $bAddTableHeader = $DiskInfoWmi_TableHeader_Yes [, $sFilterDiskType = $DiskInfoWmi_DiskType_All]] )

Parameters:
-----------
1. ByRef $aDiskList : Array variable for list of disks returned.
2. ByRef $aPartitionList : Array variable for list of partitions returned.
3. $bAddTableHeader (Optional, Default value = $DiskInfoWmi_TableHeader_Yes) : Should array tables have a header row. (Values: 0|1 or $DiskInfoWmi_TableHeader_Yes|$DiskInfoWmi_TableHeader_No)
4. $sFilterDiskType (Optional, Default value = $DiskInfoWmi_DiskType_All) : Which type of disk should be included in the result. (Values: $DiskInfoWmi_DiskType_All|$DiskInfoWmi_DiskType_External|$DiskInfoWmi_DiskType_Removable|$DiskInfoWmi_DiskType_Fixed|$DiskInfoWmi_DiskType_Unknown)

Output:
-------
Two array lists. One contains the disk information and one contains the partition information.

Usage example:
--------------
See the file 'UsageExample.au3' in this directory.