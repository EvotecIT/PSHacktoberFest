<p align="center">
  <a href="https://dev.azure.com/evotecpl/PSHacktoberFest/_build/latest?definitionId=3"><img src="https://dev.azure.com/evotecpl/PSHacktoberFest/_apis/build/status/EvotecIT.PSHacktoberFest"></a>
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/v/PSHacktoberFest.svg"></a>
  <a href="https://www.powershellgallery.com/packages/PSHacktoberFest"><img src="https://img.shields.io/powershellgallery/vpre/PSHacktoberFest.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
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

- [x] repo Full control of private repositories
  - [ ]  repo:status Access commit status
  - [ ]  repo_deployment Access deployment status
  - [x]  public_repo Access public repositories
  - [ ]  repo:invite Access repository invitations
  - [ ]  security_events Read and write security events

## Adding hacktoberfest

### Add to only chosen repositories

```powershell
Add-HacktoberFest -OrganizationName 'EvotecIT' -RepositoryName 'PSBlackListChecker', 'PSWriteHTML' -Verbose
```

### Tag all your repositories within organization

This will add `hacktoberfest` topic to all your repositories but it will skip `private` and `archived` repositories

```powershell
Add-HacktoberFest -OrganizationName 'EvotecIT' -Verbose
```

## Removing hacktoberfest

### Remove hacktoberfest from all repositories

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -Verbose
```

### Remove hacktoberfest topic from all private repositories (I've added those by accident)

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipPublic -Verbose
```

### Remove hacktoberfest topic from all archived repositories (I've added those by accident)

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -SkipNotArchived -Verbose
```

### Remove hacktoberfest from only one repository

```powershell
Remove-HacktoberFest -OrganizationName 'EvotecIt' -RepositoryName 'evotecit.github.io' -Verbose
```
