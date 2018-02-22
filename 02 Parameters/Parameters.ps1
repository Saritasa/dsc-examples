Configuration EnvironmentConfig
{
    param
    (
        [Parameter(Mandatory=$true)]
        [string[]] $Servers,
        [Parameter(Mandatory=$true)]
        [string] $Environment
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $Servers
    {
        Environment AspNetCore
        {
            Name  = 'ASPNETCORE_ENVIRONMENT'
            Value = $Environment
        }
    }
}

EnvironmentConfig -Servers Server1, Server2 -Environment Production
