function Get-HacktoberFest {
    [cmdletBinding()]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [switch] $All
    )
    Begin {
        $Repositories = Get-GitHubRepository -OrganizationName $OrganizationName
    }
    Process {
        foreach ($Repository in $Repositories) {
            if ($Repository.topics -contains 'hacktoberfest' -or $All) {
                [PSCustomObject] @{
                    Name            = $Repository.Name
                    Organization    = $Repository.Owner.login
                    FullName        = $Repository.full_name
                    IsHacktoberFest = $Repository.topics -contains 'hacktoberfest'
                    Topics          = $Repository.topics
                    Description     = $Repository.Description
                }
            }
        }
    }
}