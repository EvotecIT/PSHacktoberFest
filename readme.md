<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/v/PSHacktoberFest.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/v/PSHacktoberFest.svg?label=powershell%20gallery%20preview&colorB=yellow&include_prereleases"></a>
  <a href="https://github.com/EvotecIT/PSHacktoberFest"><img src="https://img.shields.io/github/license/EvotecIT/PSHacktoberFest.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/p/PSHacktoberFest.svg"></a>
  <a href="https://github.com/EvotecIT/PSHacktoberFest"><img src="https://img.shields.io/github/languages/top/evotecit/PSHacktoberFest.svg"></a>
  <a href="https://github.com/EvotecIT/PSHacktoberFest"><img src="https://img.shields.io/github/languages/code-size/evotecit/PSHacktoberFest.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/dt/PSHacktoberFest.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>

# PSHacktoberFest - PowerShell Module

Hacktoberfest® is open to everyone in our global community. Whether you’re a developer, student learning to code, event host, or company of any size, you can help drive growth of open source and make positive contributions to an ever-growing community. All backgrounds and skill levels are encouraged to complete the challenge.

- Hacktoberfest is a celebration open to everyone in our global community.
- Pull requests can be made in any GitHub-hosted repositories/projects.
- You can sign up anytime between October 1 and October 31.

HacktoberFest in 2020 is opt-in only:

- <https://twitter.com/hacktoberfest/status/1312221208667185153> - We’re making Hacktoberfest opt-in only for projects – which maintainers can do simply by adding the `hacktoberfest` topic to a repository! Thanks for your patience as we work on continually improving the Hacktoberfest experience.
- <https://twitter.com/digitalocean/status/1312220884665536512> - We heard you & made the biggest update yet. @Hacktoberfest 2020 is officially opt-in only for projects & maintainers! We’re excited to introduce these new measures to increase quality contributions & can’t wait to see what you build.

This means you need to tag your repository with `hacktoberfest` topic. As I am too lazy to do any of that (I do own 50+ repositories) I made little PowerShell module that does this for me.

For more details on `hacktoberfest` visit [HacktoberFest Digitalocean](https://hacktoberfest.digitalocean.com/)

## ChangeLog

- 0.0.3 - 2020.10.04
  - Added `Add-HacktoberFestLabel` and `Remove-HacktoberFestLabel`
- 0.0.2 - 2020.10.04
  - Added `WhatIf` support so you can check how things look before applying
- 0.0.1 - 2020.10.04
  - First release

## Installing PSHacktoberFest

```powershell
Install-Module PSHacktoberFest
```

Once you do that it will also install required PowerShell module `PowerShellGitHub`. It's actually the brains behind PSHacktoberFest as it allows to manage GitHub from powershell with ease.

## Configuring PSHacktoberFest

1. Create a new API token by going to <https://github.com/settings/tokens/new> (provide a description and check any appropriate scopes)
2. Call `Set-GitHubAuthentication`, enter anything as the username (the username is ignored but required by the dialog that pops up),
and paste in the API token as the password. That will be securely cached to disk and will persist across all future PowerShell sessions.
If you ever wish to clear it in the future, just call Clear-GitHubAuthentication).

So your workflow will be:

```powershell
Install-Module PSHacktoberFest
Set-GitHubAuthentication
# Use any commands below
```

I am not 100% sure which scopes are needed to manage topics for repositories

- [x] repo - Full control of private repositories
  - [ ]  repo:status - Access commit status
  - [ ]  repo_deployment - Access deployment status
  - [x]  public_repo - Access public repositories
  - [ ]  repo:invite - Access repository invitations
  - [ ]  security_events - Read and write security events

If that's not enough you may need to play with permissions a bit. Since I use `PowerShellGitHub` for other stuff I have almost everything checked.

## Adding hacktoberfest

### Add to only chosen repositories

If you have only handful of repositories to manage you can do things manually or if you're really into PowerShell using this command

```powershell
Add-HacktoberFest -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Verbose -WhatIf
```

### Tag all your repositories within organization

This will add `hacktoberfest` topic to all your repositories but it will skip `private` and `archived` repositories.

```powershell
Add-HacktoberFest -OrganizationName 'EvotecIT' -Verbose -WhatIf
```

Output:

```log
VERBOSE: Add-HacktoberFest - EvotecIT/evotecit.github.io adding hacktoberfest to topics of repository
What if: Performing the operation "Changing current topics: () count: (0) to topics: (hacktoberfest) count: 1" on target "EvotecIT/evotecit.github.io".
WARNING: Add-HacktoberFest - EvotecIT/PowerShellManager is already part of hacktoberfest. Skipping
WARNING: Add-HacktoberFest - EvotecIT/PSHomeBridge is not public (visibility: private). Skipping
WARNING: Add-HacktoberFest - EvotecIT/PSHacktoberFest is already part of hacktoberfest. Skipping
```

### Tag all your repositories within organization with Exclusions

This will add `hacktoberfest` topic to all your repositories but it will skip `private` and `archived` repositories, but you can also exclude repositories by name.

```powershell
Add-HacktoberFest -OrganizationName 'EvotecIT' -ExcludeRepositoryName 'evotecit.github.io'
```

## Removing hacktoberfest

### Remove hacktoberfest from all repositories

This will remove `hacktoberfest` topic from all your repositories.

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -Verbose -WhatIf
```

### Remove hacktoberfest topic from all private repositories

This will remove `hacktoberfest` topic from all your private repositories. I've made mistake where I've originally applied tag to everything. While not a big deal, I didn't want that. So here's a way to fix it.

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipPublic -Verbose -WhatIf
```

### Remove hacktoberfest topic from all archived repositories

This will remove `hacktoberfest` topic from all your archived repositories. I've made mistake where I've originally applied tag to everything. While not a big deal, I didn't want that. So here's a way to fix it.

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipNotArchived -Verbose -WhatIf
```

### Remove hacktoberfest from only one repository

This will remove `hacktoberfest` topic from number of your repositories.

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -RepositoryName 'evotecit.github.io' -Verbose -WhatIf
```

Output

```log
WARNING: Remove-HacktoberFest - EvotecIT/PSFilePermissions doesn't have any hacktoberfest topic. Skipping
VERBOSE: Remove-HacktoberFest - EvotecIT/PSWriteColor removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (color,hacktoberfest,powershell,wrapper,write-color,write-host,write-output) count: (7) to topics: (color,powershell,wrapper,write-color,write-host,write-output) count: 6" on target "EvotecIT/PSWriteColor".
VERBOSE: Remove-HacktoberFest - EvotecIT/PSEventViewer removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (activedirectory,events,hacktoberfest,monitoring,powershell,viewer,windows,wrapper) count: (8) to topics: (activedirectory,events,monitoring,powershell,viewer,windows,wrapper) count: 7" on target "EvotecIT/PSEventViewer".
VERBOSE: Remove-HacktoberFest - EvotecIT/PSBlackListChecker removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (blacklist,discord,exchange,hacktoberfest,microsoft-teams,monitoring,powershell,powershell-module,slack,verify) count: (10) to topics: (blacklist,discord,exchange,microsoft-teams,monitoring,powershell,powershell-module,slack,verify) count: 9" on target "EvotecIT/PSBlackListChecker".
VERBOSE: Remove-HacktoberFest - EvotecIT/PSPasswordExpiryNotifications removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (active-directory,hacktoberfest,html,powershell,powershell-module,scheduling-password-notifications) count: (6) to topics: (active-directory,html,powershell,powershell-module,scheduling-password-notifications) count: 5" on target "EvotecIT/PSPasswordExpiryNotifications".
VERBOSE: Remove-HacktoberFest - EvotecIT/PSWinReporting removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (activedirectory,hacktoberfest,powershell,powershell-module,reporting,windows) count: (6) to topics: (activedirectory,powershell,powershell-module,reporting,windows) count: 5" on target "EvotecIT/PSWinReporting".
VERBOSE: Remove-HacktoberFest - EvotecIT/PSWindowsUpdates removing hacktoberfest from topics of repository
What if: Performing the operation "Clearning current topics: (hacktoberfest) count: (1) to nothing!" on target "EvotecIT/PSWindowsUpdates".
WARNING: Remove-HacktoberFest - EvotecIT/PSManageService doesn't have any hacktoberfest topic. Skipping
VERBOSE: Remove-HacktoberFest - EvotecIT/PSPulsewayManager removing hacktoberfest from topics of repository
What if: Performing the operation "Changing current topics: (hacktoberfest,powershell,pulseway) count: (3) to topics: (powershell,pulseway) count: 2" on target "EvotecIT/PSPulsewayManager".
```

## Adding HacktoberFest Labels

Following commands allow you to easily add one or two hacktoberfest labels

### Add label to only chosen repositories

```powershell
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Label hacktoberfest-accepted -Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf
```

### Add label to only one repository

```powershell
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label hacktoberfest-accepted -Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf
```

### Add label to all repositories

```powershell
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest' -Color Harlequin -Description 'This issue is good for hacktoberfest' -Verbose -WhatIf
Add-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest-accepted'-Color MountbattenPink -Description 'Accept for hacktoberfest, will merge later' -Verbose -WhatIf
```

This is how it looks like:

```log
WARNING: Add-HacktoberFestLabel - EvotecIT/PSFilePermissions is archived. Skipping
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSWriteColor".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSEventViewer".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSBlackListChecker".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSPasswordExpiryNotifications".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,discussion,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 9" on target "EvotecIT/PSWinReporting".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSWindowsUpdates".
WARNING: Add-HacktoberFestLabel - EvotecIT/PSManageService is archived. Skipping
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSPulsewayManager".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,question,wontfix) count: 8" on target "EvotecIT/PSPublishModule".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,bug-in-dll-i-think,discussion,dll-doesnt-support-it,done,duplicate,enhancement,future,good first issue,help wanted,invalid,question,review waiting for author,up for grabs,wontfix) count: 15" on target "EvotecIT/PSWriteWord".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,bug in external module,duplicate,enhancement,good first issue,help wanted,invalid,performance,question,wontfix,workaround) count: 11" on target "EvotecIT/PSWinDocumentation".
What if: Performing the operation "Adding label hacktoberfest to other labels (bug,duplicate,enhancement,good first issue,help wanted,invalid,not possible,question,wontfix) count: 9" on target "EvotecIT/PSTeams".
```

### Removing HacktoberFest Labels

Following code removes label from one or multiple respositories

### Remove labels per repository

```powershell
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label 'hacktoberfest' -Verbose -WhatIf
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -RepositoryName 'PSHacktoberFest' -Label 'hacktoberfest-accepted' -Verbose -WhatIf
```

### Remove labels in all repositories

```powershell
Remove-HacktoberFestLabel -OrganizationName 'EvotecIT' -Label 'hacktoberfest-accepted' -Verbose -WhatIf
```
