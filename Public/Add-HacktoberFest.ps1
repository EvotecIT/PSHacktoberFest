function Add-HacktoberFest {
    [cmdletBinding()]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName,
        [Array] $ExcludeRepositoryName
    )
    Begin {
        if ($RepositoryName.Count -eq 0 -or $RepositoryName.Count -gt 1) {
            $Repositories = Get-GitHubRepository -OrganizationName $OrganizationName
            if ($RepositoryName -and $ExcludeRepositoryName) {
                $Repositories = $Repositories | Where-Object { $RepositoryName -contains $_.Name -and $ExcludeRepositoryName -notcontains $_.Name }
            } elseif ($RepositoryName) {
                $Repositories = $Repositories | Where-Object { $RepositoryName -contains $_.Name }
            } elseif ($ExcludeRepositoryName) {
                $Repositories = $Repositories | Where-Object { $ExcludeRepositoryName -notcontains $_.Name }
            }
        } else {
            $Repositories = Get-GitHubRepository -OwnerName $OrganizationName -RepositoryName $RepositoryName[0]
        }
        # Lets build cache for it for easy use
        $RepositoryCache = [ordered] @{}
        foreach ($Repository in $Repositories) {
            $RepositoryCache[$Repository.full_name] = $Repository
        }
    }
    Process {
        foreach ($Repository in $Repositories) {
            if ($Repository.visibility -ne 'public') {
                Write-Warning "Add-HacktoberFest - $($Repository.full_name) is not public (visibility: $($Repository.visibility)). Skipping"
                continue
            }
            if ($Repository.archived -eq $true) {
                Write-Warning "Add-HacktoberFest - $($Repository.full_name) is archived. Skipping"
                continue
            }
            $FullName = $Repository.full_name
            if ($RepositoryCache[$FullName]) {
                if ($RepositoryCache[$FullName].topics -notcontains 'hacktoberfest') {
                    Write-Verbose "Add-HacktoberFest - $($Repository.full_name) adding hacktoberfest to topics of repository"
                    $Topics = @(
                        $RepositoryCache[$FullName].topics
                        'hacktoberfest'
                    )
                    Set-GitHubRepositoryTopic -RepositoryName $Repository.Name -OwnerName $OrganizationName -Topic $Topics
                } else {
                    Write-Warning "Add-HacktoberFest - $($Repository.full_name) is already part of hacktoberfest. Skipping"
                }
            }
        }
    }
}