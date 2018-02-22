Configuration UserConfig
{
    param
    (
        [Parameter(Mandatory=$true)]
        [PSCredential] $Credential
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    Node WIN-U42BH7N5O4B
    {
        User NewUser
        {
            UserName = 'john'
            Password = $Credential
        }
    }
}

UserConfig -ConfigurationData .\ConfigurationData.psd1 -OutputPath Out
