Import-Module $PSScriptRoot\..\PSHacktoberFest.psd1 -Force

# Add to only chosen repositories
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest -Color Harlequin -Verbose -WhatIf
#Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest-accepted -Color MountbattenPink -Verbose -WhatIf

Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest -Color Harlequin -Verbose #-WhatIf
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest-accepted -Color MountbattenPink -Verbose #-WhatIf
#Remove-GitHubLabel -Label 'hacktoberfest-accepted' -RepositoryName 'PSWriteHTML' -OwnerName 'EvotecIT' -Confirm:$false