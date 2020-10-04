Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# Add to only chosen repositories
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest-accepted -Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf

# Add to only one repository
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest-accepted -Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf

# Add to all repositories
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest' -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest-accepted'-Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf