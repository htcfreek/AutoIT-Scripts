; Includes
#include-once
#include <Array.au3>

#cs
===============================================================================================================================
 Title ...............: _GetDiskInfoFromWmi (GitHub: - https://github.com/htcfreek/AutoIt-Scripts)
 Version .............: 1.3
 License .............: GNU LGPLv3
 AutoIt Version ......: 3.3.14.5+
 Language ............: English
 Description .........: Get disk and partition informations from WMI.
 Author ..............: htcfreek (Heiko) - https://github.com/htcfreek [original]
 Modified ............: 
 Required includes ...: Array.au3
 Dll .................:
 ===============================================================================================================================

CHANGELOG:
	2021-07-04 (v1.3)
		Fixed: Typos
		Changed: Improved comments
		Changed: Disk property header renamed: WindowsRunningOnDisk (SystemRoot) -> WindowsRunningOnDisk (SystemDisk)
		Changed: Partition property header renamed: PartitionIsSystemRoot -> PartitionIsSystemDisk
		Add: Constants
		Add: Required includes

	2021-07-02 (v1.2)
		Added: Disk properties Manufacturer, Interfacetype, Mediatype, Serialnumber, Status
		Added: Partition property: Filesystem
		Changed: Disk property header renamed: SystemIsBootedFromDisk -> WindowsRunningOnDisk (SystemRoot)
		Changed: Partition property header renamed: SystemIsBootedFromPartition -> PartitionIsSystemRoot

	2021-07-02 (v1.0)
		Initial release

#ce



Func _GetDiskInfoFromWmi(ByRef $aDiskList, ByRef $aPartitionList, $bAddTableHeader = 1)
	; Name ...............: _GetDiskInfoFromWmi 
	; Author .............: htcfreek (Heiko) - https://github.com/htcfreek
	; Input parameter ....:	ByRef $aDiskList = Array var for list of disks.
	;						ByRef $aPrtitionList = Array var for list of partitions.
	;						[$bAddTableHeader = 1] = Should array tables have a header row.
	;						[]
	; Output parameter ...:	none
		
	
	; Initialize function wide vars
	Local $aDisks[0][12]
	Local $aPartitions[0][13]
	Local $iDiskArrayCount = 0 ; Initialize counter to write some disk data later in correct array row. 
	Local $iPartArrayCount = 0 ; Initialize counter to write partition data later in correct array row. 

	
	; Add Array header
	if ($bAddTableHeader =  1) Then
		$sDiskHeader = "DiskNum" & "||" & "DiskDeviceID" & "||" & "DiskManufacturer" & "||" & "DiskModel" & "||" & "DiskInterfacetype" & "||" & "DiskMediatype" & "||" & "DiskSerialnumber" & "||" & "DiskState" & "||" & "DiskSize" & "||" & "DiskInitType" & "||" & "DiskPartitionCount" & "||" & "WindowsRunningOnDisk (SystemDrive)"
		_ArrayAdd($aDisks, $sDiskHeader, 0, "||")
		$sPartitionHeader = "DiskNum" & "||" & "PartitionNum" & "||" & "PartitionID" & "||" & "PartitionType" & "||" & "PartitionIsPrimary" & "||" & "PartIsBootPartition" & "||" & "PartitionLetter" & "||" & "PartitionLabel" & "||" & "PartitionFilesystem" & "||" & "PartitionSizeTotal" & "||" & "PartitionSizeUsed" & "||" & "PartitionSizeFree" & "||" & "PartitionIsSystemDrive"
		_ArrayAdd($aPartitions, $sPartitionHeader, 0, "||")
		$iDiskArrayCount += 1
		$iPartArrayCount += 1
	EndIf

	; Get Information from WMI
	Local $oWmiInstance = ObjGet('winmgmts:\\' & @ComputerName & '\root\cimv2')
	If (IsObj($oWmiInstance)) And (Not @error) Then
		; Get Disks
		Local $oPhysicalDisks = $oWmiInstance.ExecQuery('Select * from Win32_DiskDrive')
		For $oDisk In $oPhysicalDisks
			; Add Disk data to Array
			Local $iDisk = $oDisk.Index
			Local $sNewDisk = $iDisk & "||" & $oDisk.DeviceID & "||" & $oDisk.Manufacturer & "||" & $oDisk.Model & "||" & $oDisk.Interfacetype & "||" & $oDisk.Mediatype & "||" & $oDisk.Serialnumber & "||" & $oDisk.Status & "||" & $oDisk.Size & "||" & "<DiskInitStyle>" & "||" & $oDisk.Partitions & "||" & False
			_ArrayAdd($aDisks, $sNewDisk, 0, "||")
			
			; Get Partitions
			Local $oPartitions = $oWmiInstance.ExecQuery("ASSOCIATORS OF {Win32_DiskDrive.DeviceID='" & $oDisk.DeviceID & "'} WHERE AssocClass = Win32_DiskDriveToDiskPartition")
			For $oPartition In $oPartitions
				; Add Partition data to Array
				Local $iPartition = $oPartition.Index
				Local $sNewPart = $iDisk & "||" & $iPartition & "||" & $oPartition.DeviceID & "||" & $oPartition.Type & "||" & $oPartition.PrimaryPartition & "||" & $oPartition.BootPartition & "||" & "" & "||" & "" & "||" & "" & "||" & $oPartition.Size & "||" & "" & "||" & "" & "||" & False
				_ArrayAdd($aPartitions, $sNewPart, 0, "||")
				
				; Set DiskInitStyle
				if StringRegExp ( $oPartition.Type, "^GPT.*") Then
					$aDisks[$iDiskArrayCount][9] = "GPT"
				Else 
					$aDisks[$iDiskArrayCount][9] = "MBR"
				EndIf
				
				; Get logical disks
				Local $oLogicalDisks = $oWmiInstance.ExecQuery("ASSOCIATORS OF {Win32_DiskPartition.DeviceID='" & $oPartition.DeviceID & "'} WHERE AssocClass = Win32_LogicalDiskToPartition")
				For $oLogicalDisk In $oLogicalDisks
					; Add logical disk data to array
					$aPartitions[$iPartArrayCount][6] = $oLogicalDisk.DeviceID
					$aPartitions[$iPartArrayCount][7] = $oLogicalDisk.VolumeName
					$aPartitions[$iPartArrayCount][8] = $oLogicalDisk.Filesystem
					$aPartitions[$iPartArrayCount][9] = $oLogicalDisk.Size ; Value of LogicalDisk.Size is different to Size of DiskPartition.Size!!
					$aPartitions[$iPartArrayCount][10] = ($oLogicalDisk.Size - $oLogicalDisk.FreeSpace)
					$aPartitions[$iPartArrayCount][11] = $oLogicalDisk.FreeSpace
					
					; Detect SystemBootDisk 
					if $oLogicalDisk.DeviceID = EnvGet("SystemDrive") Then
						$aDisks[$iDiskArrayCount][11] = True
						$aPartitions[$iPartArrayCount][12] = True
					EndIf
				Next
				
				; Array counter (Partitions) + 1
				$iPartArrayCount += 1
			Next
			
			; Array counter (Disks) + 1
			$iDiskArrayCount += 1
		Next
	EndIf
	
	; Return Data
	$aDiskList = $aDisks
	$aPartitionList =  $aPartitions
EndFunc   ;==>_GetDiskInfoFromWmi
