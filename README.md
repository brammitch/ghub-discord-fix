# ghub-discord-fix

## Stops Logitech G Hub from prompting you to integrate with Discord

This script disables the integration in the configuration file and marks the file as read-only so it will persist through restarts.

Note that this will not persist if G Hub is updated or reinstalled. In those situations, you must run this script again to re-disable the integration.

## Instructions

1. Clone the respository or download `ghub-discord-fix.psm1` to your computer
1. Open PowerShell and run:
    ```powershell
    Import-Module .\path\to\ghub-discord-fix.psm1
    ```
1. In the same PowerShell session, run:
    ```powershell
    Set-DisableGHubDiscordIntegration
    ```
1. You should see the following messages, indicating the script ran successfully:
    ```
    Discord integration has been disabled in the Logitech G Hub configuration file.
    The configuration file has been set to read-only.
    ```

## DIY

If you are uncomfortable running a script from a random person on the Internet, or just want a quick way to run this one time, here are the commands to do it yourself:
```powershell
# Define the path to the G Hub configuration file
$configPath = "$HOME\AppData\Local\LGHUB\integrations\applet_discord\config.json"

# Read the existing configuration
$configContent = Get-Content -Path $configPath -Raw | ConvertFrom-Json

# Disable Discord integration
$configContent.enabled = $false
$configContent.actionSdk.enabled = $false
$configContent.actionSdk.instantiatedOnce = $true

# Save the updated configuration back to the file
$configContent | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath -Force

# Set the configuration file to read-only
Set-ItemProperty -Path $configPath -Name IsReadOnly -Value $true
```