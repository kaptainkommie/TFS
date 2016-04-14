# Author: Miodrag Milic <miodrag.milic@gmail.com>
# Last Change: 11-Apr-2016.

<#
.SYNOPSIS
    Create/import build definition

.NOTE
    Build definition property "revision" must point to the latest one in order for import to succeed.
#>
function New-TFSBuildDefinition {
    [CmdletBinding()]
    param (
        [string] $JsonFile
    )
    check_credential

    if (!(Test-Path $JsonFile)) {throw "File doesn't exist: $JsonFile" }

    $uri = "$proj_uri/_apis/build/definitions?api-version=" + $global:tfs.api_version
    Write-Verbose "URI: $uri"

    $body = gc $JsonFile -Raw -ea Stop
    $r = Invoke-RestMethod -Uri $uri -Method Post -Credential $global:tfs.credential -Body $body -ContentType 'application/json'
    $r
}