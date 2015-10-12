<#	
    .NOTES
    ============================================================================
        Created on:   	06.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        LogExt
        Filename:       LogExt.ps1
    ============================================================================
    .DESCRIPTION
    Simple Logging extensions.
#> 

#    INPUT
#    ============================================================================
        Set-Variable WriteLogFilePath -Value "c:\temp\standard.log" -Scope Global
#    ============================================================================


function Write-Host
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Host "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}

function Write-Output
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Output "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}

function Write-Warning
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Warning "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}

function Write-Verbose
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Verbose "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}

function Write-Debug
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Debug "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}

function Write-Error
{
    <#
    .Synopsis
       Simple Logging extension.
    .EXAMPLE
       Write-Error "logging message"
    #>
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
    [string]$Message
)
    Write-WithLog($MyInvocation.MyCommand.Name)
}


function Write-WithLog
{
[cmdletbinding()]
Param(
        [Parameter(Mandatory=$true)]
    [string]$FunctionName
)
    if($WriteLogFilePath)
    {
        Add-Content -Path $WriteLogFilePath -Value ('{0} [{1}]: {2}' -f `
        (Get-Date -Format G), ($FunctionName.Split('-')[1]), "$Message$newLine")
    }
    Invoke-Expression "Microsoft.PowerShell.Utility\$FunctionName `$Message"
}