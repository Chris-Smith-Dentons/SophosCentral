function Set-SophosCentralEndpointSettingsWebControlLocalSites {
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
        [Parameter(Mandatory = $true, ParameterSetName = 'categoryId')]
        [int]$categoryId,

        [Parameter(Mandatory = $true, ParameterSetName = 'tags')]
        [array]$tags,

        [Parameter(Mandatory = $true, ParameterSetName = 'tags')]
        [Parameter(Mandatory = $true, ParameterSetName ='categoryId')]
        [string]$url,

        [Parameter(Mandatory = $false, ParameterSetName = 'tags')]
        [Parameter(Mandatory = $false, ParameterSetName ='categoryId')]
        [string]$comment="",

        [Parameter(Mandatory = $false, ParameterSetName = 'tags')]
        [Parameter(Mandatory = $false, ParameterSetName ='categoryId')]
        [string]$localSiteID


    )
    Test-SophosCentralConnected

    $uriChild = '/endpoint/v1/settings/web-control/local-sites'
    if (-not([string]::IsNullOrEmpty($localSiteID))) {
        $uriChild = "$($uriChild)/$($localSiteID)"
        $method='PATCH'
    } else {
        $method='POST'
    }
    $uri = [System.Uri]::New($SCRIPT:SophosCentral.RegionEndpoint + $uriChild)
    $body=@{}
    if ($PSCmdlet.ParameterSetName -eq "categoryId") {
        $body.categoryId=$categoryId
    }
    if ($PSCmdlet.ParameterSetName -eq "tags") {
        $body.tags=$tags
    }
    $body.url=$url
    $body.comment=$comment
    Invoke-SophosCentralWebRequest -Uri $uri -Method $method -Body $body

}