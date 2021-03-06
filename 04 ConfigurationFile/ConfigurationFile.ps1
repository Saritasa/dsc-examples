Configuration FileConfig
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
    }
}

$indexContent = Get-Content 'index.html' | Out-String

FileConfig -ConfigurationData .\ConfigurationData.psd1 `
    -IndexContent $indexContent -OutputPath Out
