function Connect-SophosCentralCustomerTenant {
    <#
    .SYNOPSIS
        Connect to a Customer tenant (for Sophos partners only)
    .DESCRIPTION
        Connect to a Customer tenant (for Sophos partners only). You must connect with "Connect-SophosCentral" first using a Partner service principal

        To find the customer tenant ID, use the "Get-SophosCentralCustomerTenants" function
    .PARAMETER CustomerTenantID
        The Customers tenant ID
    .PARAMETER CustomerNameSearch
        Search the tenants you have access to by their name in Sophos Central, use "*" as a wildcard. For example, if you want to connect to "Contoso Legal" `
        you could enter "Contoso*" here.
    .EXAMPLE
        Connect-SophosCentralCustomerTenant -CustomerTenantID "asdkjdfjkwetkjdfs"
    .EXAMPLE
        Connect-SophosCentralCustomerTenant -CustomerTenantID (Get-SophosCentralCustomerTenants | Where-Object {$_.Name -like "*Contoso*"}).ID
    .EXAMPLE
        Connect-SophosCentralCustomerTenant -CustomerNameSearch "Contoso*"
    .LINK
        https://developer.sophos.com/getting-started
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ByID'
        )]
        [string]$CustomerTenantID,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'BySearchString'
        )]
        [string]$CustomerNameSearch
    )
    if ($global:SophosCentral.IDType -ne 'partner') {
        throw 'You are not currently logged in using a Sophos Central Partner Service Principal'
    } else {
        Write-Verbose 'currently logged in using a Sophos Central Partner Service Principal'
    }

    if (-not($CustomerTenantID)) {
        $tenantInfo = Get-SophosCentralCustomerTenants | Where-Object {
            $_.Name -like $CustomerNameSearch
        }
        switch ($tenantInfo.count) {
            { $PSItem -eq 1 } { Write-Verbose "1 customer tenants returned: $($tenantInfo.Name)" }
            { $PSItem -gt 1 } { throw "$PSItem customer tenants returned: " + (($tenantInfo).name -join ';') }
            { $PSItem -lt 1 } { throw "$PSItem customer tenants returned" }
        }
    } else {
        $tenantInfo = Get-SophosCentralCustomerTenants | Where-Object {
            $_.ID -eq $CustomerTenantID
        }
    }

    if ($null -ne $tenantInfo) {
        $GLOBAL:SophosCentral.RegionEndpoint = $tenantInfo.apiHost
        if ($GLOBAL:SophosCentral.CustomerTenantID) {
            $GLOBAL:SophosCentral.CustomerTenantID = $tenantInfo.id
        } else {
            $GLOBAL:SophosCentral | Add-Member -MemberType NoteProperty -Name CustomerTenantID -Value $tenantInfo.id
        }
        if ($GLOBAL:SophosCentral.CustomerTenantName) {
            $GLOBAL:SophosCentral.CustomerTenantName = $tenantInfo.Name
        } else {
            $GLOBAL:SophosCentral | Add-Member -MemberType NoteProperty -Name CustomerTenantName -Value $tenantInfo.Name
        }
    }
}