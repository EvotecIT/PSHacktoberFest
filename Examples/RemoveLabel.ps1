Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# One by one
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label 'hacktoberfest' -Verbose -WhatIf
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label 'hacktoberfest-accepted' -Verbose -WhatIf

# all of it
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest-accepted' -Verbose -WhatIf