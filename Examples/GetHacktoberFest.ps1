Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

Get-HacktoberFest -OrganizationName 'EvotecIt' | Format-Table