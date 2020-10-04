function Remove-HacktoberFestLabel {
    [cmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(Mandatory)][string] $OrganizationName,
        [Array] $RepositoryName,
        [Array] $ExcludeRepositoryName,
        [parameter(Mandatory)][validateSet('hacktoberfest', 'hacktoberfest-accepted')][string] $Name
    )
}