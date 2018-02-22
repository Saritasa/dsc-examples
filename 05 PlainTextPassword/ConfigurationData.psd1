@{
    AllNodes =
    @(
        @{
            NodeName    = 'WIN-U42BH7N5O4B'
            Role        = 'Web'
            Environment = 'Staging'
        }

        @{
            NodeName    = 'ProdServer'
            Role        = 'App'
            Environment = 'Production'
        }

        @{
            NodeName    = 'AnotherServer'
            Role        = 'App'
            Environment = 'Production'
        }
    )

    SiteName = 'example.com'
}