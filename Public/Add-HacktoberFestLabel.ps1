function Add-HacktoberFestLabel {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName,
        [Array] $ExcludeRepositoryName,
        [alias('Label')][parameter(Mandatory)][validateSet('hacktoberfest', 'hacktoberfest-accepted')][string] $Name,
        [string] $Color = 'Blue',
        [string] $Description
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

        $ColorToSubmit = Convert-FromColor -Color $Color
        if (-not $ColorToSubmit) {
            # shouldn't happen but oh well, lets check
            Write-Warning "Add-HacktoberFestLabel - Needs a color. Skipping"
            return
        }
    }
    Process {
        foreach ($Repository in $Repositories) {
            if ($Repository.visibility -ne 'public') {
                Write-Warning "Add-HacktoberFestLabel - $($Repository.full_name) is not public (visibility: $($Repository.visibility)). Skipping"
                continue
            }
            if ($Repository.archived -eq $true) {
                Write-Warning "Add-HacktoberFestLabel - $($Repository.full_name) is archived. Skipping"
                continue
            }
            [Array] $Labels = Get-GitHubLabel -OwnerName $OrganizationName -RepositoryName $Repository.Name
            if ($Labels.Count -gt 1) {
                if ($Labels.Name -notcontains $Name) {
                    $CurrentLabels = $Labels.Name
                    if ($PSCmdlet.ShouldProcess($Repository.full_name, "Adding label $Name to other labels ($($CurrentLabels -join ',')) count: $($CurrentLabels.Count)")) {
                        if ($Description -eq '') {
                            $Description = $Name
                        }
                        $null = New-GitHubLabel -Label $Name -RepositoryName $Repository.Name -OwnerName $OrganizationName -Color $ColorToSubmit -Description $Description
                    }
                } else {
                    Write-Warning "Add-HacktoberFestLabel - $($Repository.full_name) already has label $Name. Skipping."
                    continue
                }
            } else {
                Write-Warning "Add-HacktoberFestLabel - $($Repository.full_name) doesn't seem to have any labels. That's unusual. Skipping."
                continue
            }
        }
    }
}
$ScriptBlockColors = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $Script:RGBColors.Keys | Where-Object { $_ -like "*$wordToComplete*" }
}

Register-ArgumentCompleter -CommandName 'Add-HacktoberFestLabel' -ParameterName Color -ScriptBlock $ScriptBlockColors -Verbose