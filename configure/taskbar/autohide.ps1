# 03 = hide 
# 02 = show
$autohide = 02

# Define the registry path and value name
$registryPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"
$valueName = "Settings"

# Open the registry key
$registry = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey($registryPath, $true)

if ($null -eq $registry) {
    Write-Error "Registry key not found: $registryPath"
    return
}

# Read the existing binary data
$data = $registry.GetValue($valueName)

if ($null -eq $data) {
    Write-Error "Value not found: $valueName"
    return
}

$data[8] = $autohide

# Write the modified data back to the registry
$registry.SetValue($valueName, $data, [Microsoft.Win32.RegistryValueKind]::Binary)

# Dispose of the registry key
$registry.Dispose()

# Restart Explorer for changes to take effect
Stop-Process -Name explorer -Force

