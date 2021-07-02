;GetDiskInfoFromWmi.au3

#include <Array.au3>


Func _GetDiskInfoFromWmi(ByRef $aDiskList, ByRef $aPrtitionList, $bAddTableHeader = 1)
	; Name: _GetDiskInfoFromWmi
	; Author: htcfreek (Heiko) - https://github.com/htcfreek/AutoIt-Scripts
	; Version: 1.0
	; License: GNU LGPLv3
	; Input parameter: ByRef $aDiskList = Array var for list of disks.; ByRef $aPrtitionList = Array var for list of partitions.; [$bAddTableHeader = 1] = Should array tables have a header rowß
	; Output parameter: none
	; Required includes: <Array.au3>
	
	
	; Initialize function wide vars
	Local $aDisks[0][7]
	Local $aPartitions[0][12]
	Local $iDiskArrayCount = 0 ; Initialize counter to write some disk data later in correct array row. 
	Local $iPartArrayCount = 0 ; Initialize counter to write partition data later in correct array row. 

	
	; Add Array header
	if ($bAddTableHeader =  1) Then
		$sDiskHeader = "DiskNum" & "||" & "DiskDeviceID" & "||" & "DiskModel" & "||" & "DiskSize" & "||" & "DiskPartitionCount" & "||" & "DiskInitType" & "||" & "SystemIsBootedFromDisk"
		_ArrayAdd($aDisks, $sDiskHeader, 0, "||")
		$sPartitionHeader = "DiskNum" & "||" & "PartitionNum" & "||" & "PartitionID" & "||" & "PartitionType" & "||" & "PartitionIsPrimary" & "||" & "PartIsBootPartition" & "||" & "PartitionLetter" & "||" & "PartitionLabel" & "||" & "PartitionSizeTotal" & "||" & "PartitionSizeUsed" & "||" & "PartitionSizeFree" & "||" & "SystemIsBootedFromPartition"
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
			; Add Disk-Data to Array
			Local $iDisk = $oDisk.Index
			Local $sNewDisk = $iDisk & "||" & $oDisk.DeviceID & "||" & $oDisk.Model & "||" & $oDisk.Size & "||" & $oDisk.Partitions & "||" & "<DiskInitStyle>" & "||" & False
			_ArrayAdd($aDisks, $sNewDisk, 0, "||")
			
			;Get Partitions
			Local $oPartitions = $oWmiInstance.ExecQuery("ASSOCIATORS OF {Win32_DiskDrive.DeviceID='" & $oDisk.DeviceID & "'} WHERE AssocClass = Win32_DiskDriveToDiskPartition")
			For $oPartition In $oPartitions
				; Add Part data to Array
				Local $iPartition = $oPartition.Index
				Local $sNewPart = $iDisk & "||" & $iPartition & "||" & $oPartition.DeviceID & "||" & $oPartition.Type & "||" & $oPartition.PrimaryPartition & "||" & $oPartition.BootPartition & "||" & "" & "||" & "" & "||" & $oPartition.Size & "||" & "" & "||" & "" & "||" & False
				_ArrayAdd($aPartitions, $sNewPart, 0, "||")
				
				; Set DiskIniStyle
				if StringRegExp ( $oPartition.Type, "^GPT.*") Then
					$aDisks[$iDiskArrayCount][5] = "GPT"
				Else 
					$aDisks[$iDiskArrayCount][5] = "MBR"
				EndIf
				
				; Get LogicalDiks
				Local $oLogicalDisks = $oWmiInstance.ExecQuery("ASSOCIATORS OF {Win32_DiskPartition.DeviceID='" & $oPartition.DeviceID & "'} WHERE AssocClass = Win32_LogicalDiskToPartition")
				For $oLogicalDisk In $oLogicalDisks
					;Add logical disk data to array
					$aPartitions[$iPartArrayCount][6] = $oLogicalDisk.DeviceID
					$aPartitions[$iPartArrayCount][7] = $oLogicalDisk.VolumeName
					$aPartitions[$iPartArrayCount][8] = $oLogicalDisk.Size ; Value of LogicalDisk.Size is different to Size of DiskPartiton.Size!!
					$aPartitions[$iPartArrayCount][9] = ($oLogicalDisk.Size - $oLogicalDisk.FreeSpace)
					$aPartitions[$iPartArrayCount][10] = $oLogicalDisk.FreeSpace
					
					;Detect SystemBootDisk 
					if $oLogicalDisk.DeviceID = Envget("SystemDrive") Then
						$aDisks[$iDiskArrayCount][6] = True
						$aPartitions[$iPartArrayCount][11] = True
					EndIf
				Next
				
				; ArrayCounter + 1
				$iPartArrayCount += 1
			Next
			
			; ArrayCounter + 1
			$iDiskArrayCount += 1
		Next
	EndIf
	
	;Return Data
	$aDiskList = $aDisks
	$aPrtitionList =  $aPartitions
EndFunc   ;==>_GetDiskInfoFromWmi



; Example Usage
;------------------
Local $aOutputDisks
Local $aOutputPartitions
_GetDiskInfoFromWmi($aOutputDisks, $aOutputPartitions, 1)

_ArrayDisplay($aOutputDisks, "Disks")
_ArrayDisplay($aOutputPartitions,  "Partitons")
