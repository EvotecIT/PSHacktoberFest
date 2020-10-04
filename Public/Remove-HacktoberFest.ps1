function Remove-HacktoberFest {
    [cmdletBinding()]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName,
        [switch] $SkipPublic,
        [switch] $SkipNotArchived
    )
    Begin {
        if ($RepositoryName.Count -eq 0 -or $RepositoryName.Count -gt 1) {
            $Repositories = Get-GitHubRepository -OrganizationName $OrganizationName
            if ($RepositoryName) {
                $Repositories = $Repositories | Where-Object { $RepositoryName -contains $_.Name }
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
            if ($SkipPublic -and $Repository.visibility -eq 'public') {
                Write-Warning "Remove-HacktoberFest - $($Repository.full_name) is public (visibility: $($Repository.visibility)). Skipping"
                continue
            }
            if ($SkipNotArchived -and $Repository.archived -eq $false) {
                Write-Warning "Remove-HacktoberFest - $($Repository.full_name) is not archived. Skipping"
                continue
            }
            $FullName = $Repository.full_name
            if ($RepositoryCache[$FullName]) {
                if ($RepositoryCache[$FullName].topics -contains 'hacktoberfest') {
                    Write-Verbose "Remove-HacktoberFest - $($Repository.full_name) removing hacktoberfest from topics of repository"
                    $Topics = @(
                        foreach ($Topic in $RepositoryCache[$FullName].topics) {
                            if ($Topic -ne 'hacktoberfest') {
                                $Topic
                            }
                        }
                    )
                    if ($Topics.Count -eq 0) {
                        Set-GitHubRepositoryTopic -RepositoryName $Repository.Name -OwnerName $OrganizationName -Clear
                    } else {
                        Set-GitHubRepositoryTopic -RepositoryName $Repository.Name -OwnerName $OrganizationName -Topic $Topics
                    }
                } else {
                    Write-Warning "Remove-HacktoberFest - $($Repository.full_name) doesn't have any hacktoberfest topic. Skipping"
                }
            }
        }
    }
}