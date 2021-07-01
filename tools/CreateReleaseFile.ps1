# Copyright (c) 2021 htcfreek (Heiko)
# See the LICENSE file in the project root for more information.

# Name: CreateReleaseFile.ps1
# Version: 1.0
# Description: Script to create the release file.
# Author: htcfreek (Heiko) - https://github.com/htcfreek
# Parameter: [String]$ReleaseName, [String]$ReleaseVersion, [[Switch]$NoHashCalculation=$False]



# Parameter
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)][String]$ReleaseName,
    [Parameter(Mandatory=$true)][String]$ReleaseVersion,
    [Parameter(Mandatory=$false)][Switch]$NoHashCalculation=$false
)


# Settings
[String]$RepoDir=Resolve-Path -LiteralPath "..\"
[String]$SrcDir="\src"
[String]$ReleaseDir="\release"
[String]$OutFileName="$($ReleaseName)_v$($ReleaseVersion).zip"
[String[]]$CompressFiles = @(
    "$($RepoDir)$($SrcDir)\*.*",
    "$($RepoDir)\LICENSE.md",
    "$($RepoDir)\DISCLAIMER.md"
)
[String]$HashFile="$($RepoDir)$($ReleaseDir)\$($OutFileName).sha256"


# Create Zip
if (-Not (Test-Path -Path "$($RepoDir)$($SrcDir)" -ErrorAction SilentlyContinue) -AND -NOT (Test-Path -Path "$($RepoDir)$($ReleaseDir)" -ErrorAction SilentlyContinue)) {
    Write-Error "Source path and or release folder not available."
    Break
}

if (Test-Path -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName)" -ErrorAction SilentlyContinue) {
    Write-Error "Release-File already existing."
    Break
}

Compress-Archive -Path $CompressFiles -DestinationPath "$($RepoDir)$($ReleaseDir)\$($OutFileName)"


# Calc. Hash
if (-Not $NoHashCalculation) {
    [String]$hash = (Get-FileHash -Path "$($RepoDir)$($ReleaseDir)\$($OutFileName)" -Algorithm SHA256).Hash
    "$hash *$OutFileName" | Out-File -FilePath $HashFile -Append
}
