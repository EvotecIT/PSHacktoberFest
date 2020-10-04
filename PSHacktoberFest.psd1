@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Module that helps maintaining hacktoberfest'
    FunctionsToExport    = @('Add-HacktoberFest', 'Get-HacktoberFest', 'Remove-HacktoberFest')
    GUID                 = '9672d48d-6b9b-4ae8-89ba-8f447c6a928b'
    ModuleVersion        = '0.0.2'
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
        }, 'Microsoft.PowerShell.Utility')
    RootModule           = 'PSHacktoberFest.psm1'
}