function Get-SophosCentralEndpointSettingsWebControlCategories {
    <#
    .SYNOPSIS
        Get Web control categories
    .DESCRIPTION
        Get Web control categories
    .EXAMPLE
        https://developer.sophos.com/docs/endpoint-v1/1/routes/settings/web-control/categories/get


    .LINK
        https://developer.sophos.com/docs/endpoint-v1/1/routes/settings/web-control/categories/get
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseProcessBlockForPipelineCommand', 'All', Justification = 'We do not need to use the variable', Scope = 'Function')]
    param (
    )
    Test-SophosCentralConnected

    $uriChild = '/endpoint/v1/settings/web-control/categories'
    $uri = [System.Uri]::New($SCRIPT:SophosCentral.RegionEndpoint + $uriChild)
    Invoke-SophosCentralWebRequest -Uri $uri 
}