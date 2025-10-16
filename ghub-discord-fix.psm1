function Set-DisableGHubDiscordIntegration {
  <#
    .SYNOPSIS
    Disables Discord integration in Logitech G Hub by modifying the configuration file.

    .DESCRIPTION
    This function locates the Logitech G Hub configuration file and sets the "enabled" settings to false, as well as the "instantiatedOnce" setting to true.

    It also sets the configuration file to read-only to prevent further changes.

    These changes will be overwritten if Logitech G Hub is reinstalled or updated. In that case, you may want to run this function again.

    .EXAMPLE
    Set-DisableGHubDiscordIntegration

    This command will disable Discord integration in Logitech G Hub.
  #>

  # Define the path to the G Hub configuration file
  $configPath = "$HOME\AppData\Local\LGHUB\integrations\applet_discord\config.json"

  # Check if the configuration file exists
  if (Test-Path -Path $configPath) {
    # Read the existing configuration
    $configContent = Get-Content -Path $configPath -Raw | ConvertFrom-Json

    # Disable Discord integration
    $configContent.enabled = $false
    $configContent.actionSdk.enabled = $false
    $configContent.actionSdk.instantiatedOnce = $true

    # Save the updated configuration back to the file
    $configContent | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath -Force

    Write-Output "Discord integration has been disabled in the Logitech G Hub configuration file."

    Set-ItemProperty -Path $configPath -Name IsReadOnly -Value $true

    Write-Output "The configuration file has been set to read-only."

  }
  else {
    Write-Output "Unable to locate the Logitech G Hub configuration file at $configPath."
  }
}