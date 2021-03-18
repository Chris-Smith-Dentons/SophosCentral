function Get-SophosCentralAuthHeader {
    [CmdletBinding()]
    param (
        [switch]$Initial,
        [switch]$PartnerInitial
    )

    if ($GLOBAL:SophosCentral) {
        $header = @{
            Authorization = 'Bearer ' + (Unprotect-Secret -Secret $GLOBAL:SophosCentral.access_token)
        }
        if (($Initial -ne $true) -and ($PartnerInitial -ne $true)) {
            switch ($GLOBAL:SophosCentral.IDType) {
                'partner' {
                    $header.Add('X-Tenant-ID', $GLOBAL:SophosCentral.CustomerTenantID)
                }
                'tenant' {
                    $header.Add('X-Tenant-ID', $GLOBAL:SophosCentral.TenantID)
                }
            }
        }
        if ($PartnerInitial) {
            $header.Add('X-Partner-ID', $GLOBAL:SophosCentral.TenantID)
        }
        $header
    }
}