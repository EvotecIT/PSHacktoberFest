Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# Add to only chosen repositories
Add-HacktoberFest -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Verbose

# Tag all your repositories within organization, it skips Private/Archived by default
Add-HacktoberFest -OrganizationName 'EvotecIT' -Verbose

# Tag all your repositories within organization, it skips Private/Archived by default, excluding the ones you don't want
Add-HacktoberFest -OrganizationName 'EvotecIT' -ExcludeRepositoryName 'evotecit.github.io' -Verbose