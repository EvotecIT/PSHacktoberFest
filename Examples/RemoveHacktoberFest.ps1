Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# Remove hacktoberfest from all repositories
Remove-HacktoberFest -OrganizationName 'EvotecIt' -Verbose -WhatIf

# Remove hacktoberfest topic from all private repositories (I've added those by accident)
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipPublic -Verbose -WhatIf

# Remove hacktoberfest topic from all archived repositories (I've added those by accident)
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipNotArchived -Verbose -WhatIf

# Remove hacktoberfest from only one repository
Remove-HacktoberFest -OrganizationName 'EvotecIt' -RepositoryName 'evotecit.github.io' -Verbose -WhatIf