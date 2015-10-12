<#	
    .NOTES
    ===========================================================================
        Created on:   	04.10.2015
        Created by:   	David das Neves
        Version:        0.1
        Project:        PSGUI
        Filename:       Initialize-XAMLDialog.ps1
    ===========================================================================
    .DESCRIPTION
        Function from the PSGUI module.
#> 
function Initialize-XAMLDialog
{
    <#
        .Synopsis
        XAML-Loader
        .DESCRIPTION
        Loads the xaml file and sets global variables for all elements.
        .EXAMPLE
        Initialize-XAMLDialog "..\Dialogs\MyForm.xaml"
        .Notes
        - namespace-class removed and namespace added
        - absolute and relative paths
        - creating variables for each object
    #>
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$True, Position=1)]
        [string]$XAMLPath,

        #If enabled all objects will be named $Formname_Objectname
        #Example: $PSGUI_lbDialogs
        #If not it would look like
        #Example: $lbDialogs
        #By using namespaces the possibility that a variable will be overwritten is mitigated.
        [switch]
        $UseFormNameAsNamespace = $true
    )
    Begin
    { 
        #Add WPF assemblies
        try
        {
            Add-Type -AssemblyName PresentationCore,PresentationFramework
        } 
        catch 
        {
            Throw 'Failed to load Windows Presentation Framework assemblies.'
        }

        #Loads xml previously in container
        $preload = Get-Content -Path $XamlPath

        #Catch all relative paths
        $directory = (Get-Item $XAMLPath).Directory.FullName        
        $preload = $preload -replace '(=".\\)',$("=`"" + $directory + '\')

        #Catch all absolute paths        
        $matchesFile = [regex]::Matches($preload,'(=")[a-z,A-Z]{1}[:][a-z,A-Z,0-9 \\_.-]*["]')
        foreach ($matchF in $matchesFile)
        {
            $FileFullName= ($matchF.Value).Replace('"','').Replace('=','')
            if (-not (Test-Path $FileFullName))
            {
                $fileName=($FileFullName.Split('\'))[-1]
                $filesInDirectory = Get-ChildItem $directory -File -Filter "$fileName" -Recurse
                if ($filesInDirectory.Count -gt 0)
                {
                    #Replacing path with the actual one 
                    $preload = $preload.Replace($matchF.Value,$("=`"" + $filesInDirectory[0].FullName + "`""))
                }
            }            
        }

        #Xaml-file is load as xml.
        [xml]$Global:xmlWPF = $preload

        #Retrieve namespace
        $matchesFile = [regex]::Matches($preload,'(xmlns:)[a-z,A-Z,0-9]')

        if ($matchesFile.Count -eq 1)
        {
            $namespaceName = ($matchesFile.Value).Split(':')[-1]

            #Remove class attribute
            $xmlWPF.Window.RemoveAttribute($namespaceName + ':Class')
        } 
    }
    Process
    {       
        if (Test-Path -Path $XAMLPath)
        {
            #Retrieves the file- and dialogname by the filename of the xaml-file.
            #Therefore this name must be consistent at folder and file-level.
            $filename = ((Get-Item -Path $XAMLPath).Name).Split('.')[0]
 
            #Create the XAML reader using a new XML node reader
            Invoke-Expression -Command "`$Global:$filename = [Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader `$xmlWPF))"

            #Getting and setting the namespace of the xaml file
            $ns = New-Object System.Xml.XmlNamespaceManager($xmlWPF.NameTable)
            $ns.AddNamespace("$namespaceName", $xmlWPF.DocumentElement.NamespaceURI)

            #Retrieves the nodes.
            $nodes =$xmlWPF.SelectNodes('//*', $ns)

            #Create hooks to each named object in the XAML with using the namespace
            foreach ($nameOfNode in $nodes.Name)
            {
            
                #TODO do class instead of bunch of variables?
                #Compatiblity only with PS 5.0 >

                $valueOfItem = $null
                Invoke-Expression -Command "`$valueOfItem=`$$filename.FindName(`"`$nameOfNode`")"

                if ($valueOfItem -ne $null)
                {
                    if ($UseFormNameAsNamespace)
                    {
                        Invoke-Expression -Command "Set-Variable -Name `$(`$filename + `"_`" +`$nameOfNode) -Value `$(`$$filename.FindName(`"`$nameOfNode`")) -Scope Global"   
                    }
                    else 
                    {
                        Invoke-Expression -Command "Set-Variable -Name `$nameOfNode -Value `$(`$$filename.FindName(`"`$nameOfNode`")) -Scope Global"
                    }             
                }
            }
        }
        else
        {
            Throw ('"XAML-Path could not be resolved: ' + $XAMLPath)
        }
    }
    End
    {
    }
}