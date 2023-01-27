function Remove-SophosCentralEndpointSettingsWebControlLocalSites {
    <#
    .SYNOPSIS
        Get Web control local sites
    .DESCRIPTION
        Get Web control local sites
    .EXAMPLE
        Get-SophosCentralEndpointSettingsLocalSites


    .LINK
        https://developer.sophos.com/docs/endpoint-v1/1/routes/settings/web-control/local-sites/get
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseProcessBlockForPipelineCommand', 'All', Justification = 'We do not need to use the variable', Scope = 'Function')]
    param (

        [Parameter(Mandatory = $true)]
        [string]$localSiteID

    )
    Test-SophosCentralConnected

    $uriChild = '/endpoint/v1/settings/web-control/local-sites'
    $uriChild = "$($uriChild)/$($localSiteID)"
    $method='DELETE'
    $uri = [System.Uri]::New($SCRIPT:SophosCentral.RegionEndpoint + $uriChild)
    Invoke-SophosCentralWebRequest -Uri $uri -Method $method

}