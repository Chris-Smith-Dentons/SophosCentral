function Set-SophosCentralAlertAction {
    <#
    .SYNOPSIS
        Update an alert in Sophos Central
    .DESCRIPTION
        Update an alert in Sophos Central
    .PARAMETER AlertID
        The ID of the alert. Use Get-SophosCentralAlerts to list them
    .PARAMETER Action
        The alert action to perform. To get the possible actions for an alert, check the results from Get-SophosCentralAlerts

        The action must be in the same capitalization as listed, otherwise it will fail

        Possible options: 'acknowledge', 'cleanPua', 'cleanVirus', 'authPua', 'clearThreat', 'clearHmpa', 'sendMsgPua', 'sendMsgThreat'
    .EXAMPLE
        Set-SophosCentralAlertAction. -AlertID "6d41e78e-0360-4de3-8669-bb7b797ee515" -Action "clearThreat"
    .LINK
        https://developer.sophos.com/docs/common-v1/1/routes/alerts/%7BalertId%7D/actions/post
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [Alias('ID')]
        [string[]]$AlertID,

        [Parameter(Mandatory = $true)]
        [ValidateSet('acknowledge', 'cleanPua', 'cleanVirus', 'authPua', 'clearThreat', 'clearHmpa', 'sendMsgPua', 'sendMsgThreat')]
        [string]$Action,

        [string]$Message
    )
    begin {
        $uriChild = '/common/v1/alerts/{0}/actions'
        $uriString = $GLOBAL:SophosCentral.RegionEndpoint + $uriChild
    }
    process {
        foreach ($alert in $AlertID) {
            $uri = [System.Uri]::New($uriString -f $alert)
            $body = @{
                action = $Action
            }
            Invoke-SophosCentralWebRequest -Uri $uri -Method Post -Body $body
        }
    }
}