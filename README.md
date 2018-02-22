PowerShell DSC Examples
=======================

Push
----

### Push in Trusted Network

```powershell
& '.\01 BasicConfig\BasicConfig.ps1'
Start-DscConfiguration -Path .\Out MyServer
```

### Push Using SSL

```powershell
& '.\01 BasicConfig\BasicConfig.ps1'
$options = New-CimSessionOption -UseSsl
$session = New-CimSession -SessionOption $options -Credential administrator MyServer
Start-DscConfiguration -CimSession $session -Path .\Out
```

### Wait for Finish

```powershell
Start-DscConfiguration -CimSession $session -Path .\Out -Wait -Verbose
```

### Override Pending Configuration

```powershell
Start-DscConfiguration -CimSession $session -Wait -Verbose -Force
```

### Apply Existing Configuration

```powershell
Start-DscConfiguration -CimSession $session -UseExisting -Wait -Verbose
```

Diagnostics
-----------

### Get Status

```powershell
Get-DscConfigurationStatus -CimSession $session
Get-DscConfiguration -CimSession $session
```

### Get Configuration Manager Settings

```powershell
Get-DscLocalConfigurationManager -CimSession $session
```

### Get DSC Logs

```powershell
Get-WinEvent -LogName 'Microsoft-Windows-Dsc/Operational' -MaxEvents 100 | select TimeCreated, Message | Format-List
```
