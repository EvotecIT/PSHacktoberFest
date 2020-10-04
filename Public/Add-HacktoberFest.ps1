function Add-HacktoberFest {
    [cmdletBinding()]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName
    )
    Begin {
        if ($RepositoryName.Count -eq 0 -or $RepositoryName.Count -gt 1) {
            $Repositories = Get-GitHubRepository -OrganizationName $OrganizationName
            $Repositories = $Repositories | Where-Object { $RepositoryName -contains $_.Name }
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
            $FullName = $Repository.full_name
            if ($RepositoryCache[$FullName]) {
                if ($RepositoryCache[$FullName].topics -notcontains 'hacktoberfest') {
                    Write-Verbose "Add-HacktoberFest - $($Repository.fullName) adding hacktoberfest to topics of repository"
                    $Topics = @(
                        $RepositoryCache[$FullName].topics
                        'hacktoberfest'
                    )
                    Set-GitHubRepositoryTopic -RepositoryName $Repository.Name -OwnerName $OrganizationName -Topic $Topics
                } else {
                    Write-Warning "Add-HacktoberFest - $($Repository.Name) is already part of hacktoberfest. Skipping"
                }
            }
        }
    }
}