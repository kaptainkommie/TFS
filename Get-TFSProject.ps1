# Author: Miodrag Milic <miodrag.milic@gmail.com>
# Last Change: 14-Apr-2016.

<#
.SYNOPSIS
    Get the TFS project details
#>
function Get-TFSProject {
    [CmdletBinding()]
    param(
        #Id (length = 36) or name of the project
        [string]$Id
    )
    check_credential

    if ($Id.length -ne 36) { $Id = Get-TFSProjects -Raw | ? name -eq $Id | select -Expand id }
    if ($Id -eq $null) { throw "Can't find project with that name or id" }
    Write-Verbose "Project id: $Id"

    $uri = "$collection_uri/_apis/projects/$($Id)?includeCapabilities=true&api-version=" + $global:tfs.api_version
    Write-Verbose "URI: $uri"

    $params = @{ Uri = $uri; Method = 'Get'}
    invoke_rest $params
}
