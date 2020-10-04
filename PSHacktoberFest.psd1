@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Module that helps maintaining hacktoberfest'
    FunctionsToExport    = @('Add-HacktoberFest', 'Add-HacktoberFestLabel', 'Get-HacktoberFest', 'Remove-HacktoberFest', 'Remove-HacktoberFestLabel')
    GUID                 = '9672d48d-6b9b-4ae8-89ba-8f447c6a928b'
    ModuleVersion        = '0.0.3'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Windows', 'MacOS', 'Linux', 'HacktoberFest')
            ExternalModuleDependencies = @('Microsoft.PowerShell.Utility')
        }
    }
    RequiredModules      = @(@{
            ModuleVersion = '0.15.1'
            ModuleName    = 'PowerShellForGitHub'
            Guid          = '9e8dfd44-f782-445a-883c-70614f71519c'
        }, @{
            ModuleVersion = '0.0.181'
            ModuleName    = 'PSSharedGoods'
            Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
        }, 'Microsoft.PowerShell.Utility')
    RootModule           = 'PSHacktoberFest.psm1'
}