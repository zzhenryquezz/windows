
param (
    [string]$FilePath = "items.txt"
)

# Ensure the file exists
if (-not (Test-Path $FilePath)) {
    Write-Error "File '$FilePath' not found. Please provide a valid file path."
    return
}

# Read folder paths from the file
$folders = Get-Content $FilePath | Where-Object { $_ -and (Test-Path $_) }

if (-not $folders) {
    Write-Error "No valid folder paths found in the file."
    return
}

# Clear current Quick Access
try {
    $quickAccessShellFolder = New-Object -ComObject Shell.Application
    $quickAccessNamespace = $quickAccessShellFolder.Namespace("shell:::{679f85cb-0220-4080-b29b-5540cc05aab6}")
    $quickAccessItems = $quickAccessNamespace.Items()

    foreach ($item in $quickAccessItems) {
        $item.InvokeVerb("unpinfromhome")
    }
}
catch {
    Write-Error "Failed to clear Quick Access. Ensure you have sufficient permissions."
    return
}

# Add new folders to Quick Access
foreach ($folder in $folders) {
    try {
        $shellFolder = New-Object -ComObject Shell.Application
        $folderItem = $shellFolder.Namespace($folder).Self
        $folderItem.InvokeVerb("pintohome")
    }
    catch {
        Write-Warning "Failed to pin folder: $folder"
    }
}

# disable recent files
try {
    $registry = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey("SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer", $true)

    $registry.SetValue("ShowRecent", 1)

    $registry.Dispose()
}
catch {
    Write-Warning "Failed to disable recent files: $_" 
}


Write-Output "Quick Access updated successfully!"
