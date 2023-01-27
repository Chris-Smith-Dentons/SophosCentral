function Get-SophosCentralEndpointPolicies {
    <#
    .SYNOPSIS
        Get Policies
    .DESCRIPTION
        Get Policies
    .EXAMPLE
        Get-SophosCentralEndpointPolicy -All

        Get all policies
    .EXAMPLE
        Get-SophosCentralEndpointPolicy -BasePolicy

        Get base policies
    .LINK
        https://developer.sophos.com/docs/endpoint-v1/1/routes/policies/get
        https://developer.sophos.com/docs/endpoint-v1/1/routes/policies/%7BpolicyId%7D/get
    #>
    [CmdletBinding()]
    [Alias('Get-SophosCentralEndpointPolicies')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('UseProcessBlockForPipelineCommand', 'All', Justification = 'We do not need to use the variable', Scope = 'Function')]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ID')]
        [Alias('ID')]
        [string]$PolicyId,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'Base')]
        [switch]$BasePolicy,

        [Parameter(Mandatory = $false, ParameterSetName = 'PolicyType')]
        [Parameter(Mandatory = $false, ParameterSetName = 'Base')]
        [Parameter(Mandatory = $false, ParameterSetName = 'ID')]
        [string]$fields,
        
        [Parameter(Mandatory = $true, ParameterSetName = 'PolicyType')]
        [string]$policyType
    )
    Test-SophosCentralConnected

    if ($BasePolicy) {
        $PolicyId = 'base'
    }

    $uriChild = '/endpoint/v1/policies'
    if (-not([string]::IsNullOrEmpty($PolicyId))) {
        $uriChild = "$($uriChild)/$($PolicyId)"
    }

    $uritemp = [System.Uri]::New($SCRIPT:SophosCentral.RegionEndpoint + $uriChild)
    if ($PSCmdlet.ParameterSetName -eq 'PolicyType') {
        $uri = New-UriWithQuery -Uri $uritemp -OriginalPsBoundParameters $PsBoundParameters
    } else {
        $uri=$uritemp
    }
    Invoke-SophosCentralWebRequest -Uri $uri
}