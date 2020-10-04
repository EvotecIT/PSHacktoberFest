Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# Add to only chosen repositories
Add-HacktoberFest -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Verbose
# Tag all your repositories within organization
Add-HacktoberFest -OrganizationName 'EvotecIT' -Verbose