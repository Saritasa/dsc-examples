Configuration EnvironmentConfig
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node StagingServer
    {
        Environment AspNetCore
        {
            Name  = 'ASPNETCORE_ENVIRONMENT'
            Value = 'Staging'
        }
    }

    Node ProdServer
    {
        Environment AspNetCore
        {
            Name  = 'ASPNETCORE_ENVIRONMENT'
            Value = 'Production'
        }
    }
}

EnvironmentConfig
