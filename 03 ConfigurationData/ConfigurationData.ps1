Configuration EnvironmentConfig
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node $AllNodes.NodeName
    {
        Environment AspNetCore
        {
            Name  = 'ASPNETCORE_ENVIRONMENT'
            Value = $Node.Environment
        }
    }
}

$data =
    @{
        AllNodes =
        @(
            @{ NodeName = 'StagingServer'; Environment = 'Staging' },
            @{ NodeName = 'ProdServer'; Environment = 'Production' }
        )
    }

EnvironmentConfig -ConfigurationData $data
