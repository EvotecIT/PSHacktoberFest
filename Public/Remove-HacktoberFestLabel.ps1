function Remove-HacktoberFestLabel {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName,
        [Array] $ExcludeRepositoryName,
        [alias('Label')][parameter(Mandatory)][validateSet('hacktoberfest', 'hacktoberfest-accepted')][string] $Name
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
                Write-Warning "Remove-HacktoberFestLabel - $($Repository.full_name) is not public (visibility: $($Repository.visibility)). Skipping"
                continue
            }
            if ($Repository.archived -eq $true) {
                Write-Warning "Remove-HacktoberFestLabel - $($Repository.full_name) is archived. Skipping"
                continue
            }
            [Array] $Labels = Get-GitHubLabel -OwnerName $OrganizationName -RepositoryName $Repository.Name
            if ($Labels.Count -gt 1) {
                if ($Labels.Name -contains $Name) {
                    $CurrentLabels = $Labels.Name
                    if ($PSCmdlet.ShouldProcess($Repository.full_name, "Removing label $Name from labels ($($CurrentLabels -join ',')) count: $($CurrentLabels.Count)")) {
                        Remove-GitHubLabel -Label $Name -RepositoryName $Repository.Name -OwnerName $OrganizationName -Confirm:$false
                    }
                } else {
                    Write-Warning "Remove-HacktoberFestLabel - $($Repository.full_name) doesn't contain label $Name. Skipping."
                    continue
                }
            }

        }
    }
}