Configuration IisConfig
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string] $SiteName
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Import-DscResource -ModuleName xWebAdministration

    WindowsFeature IIS
    {
        Ensure = 'Present'
        Name   = 'Web-Server'
    }

    xWebsite RemoveDefaultSite
    {
        Name         = 'Default Web Site'
        Ensure       = 'Absent'
        DependsOn    = '[WindowsFeature]IIS'
    }

    xWebsite Site
    {
        Name         = 'MyWebSite'
        State        = 'Started'
        PhysicalPath = "C:\$SiteName"
        DependsOn    = '[xWebsite]RemoveDefaultSite'
    }
}

Configuration WebApplication
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string] $IndexContent
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.Where{ $_.Role -eq 'Web' }.NodeName
    {
        Environment AspNetCore
        {
            Name  = 'ASPNETCORE_ENVIRONMENT'
            Value = $Node.Environment
        }

        File SiteRoot
        {
            DestinationPath = "C:\$($ConfigurationData.SiteName)"
            Type            = 'Directory'
        }

        File IndexFile
        {
            DestinationPath = "C:\$($ConfigurationData.SiteName)\index.html"
            Contents        = $IndexContent
            DependsOn       = '[File]SiteRoot'
        }

        IisConfig Iis
        {
            SiteName    = $ConfigurationData.SiteName
            DependsOn   = '[File]IndexFile'
        }
    }
}

$indexContent = Get-Content 'index.html' | Out-String

WebApplication -ConfigurationData .\ConfigurationData.psd1 `
    -IndexContent $indexContent -OutputPath Out
