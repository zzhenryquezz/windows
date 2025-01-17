# Define the path to the packages list file
$packageListPath = "packages.txt"

# Check if the packages list file exists
if (-not (Test-Path $packageListPath)) {
    Write-Host "The packages list file '$packageListPath' does not exist."
    exit 1
}

# Read the list of packages from the file
$packages = Get-Content -Path $packageListPath

# Loop through each package in the list and install it
foreach ($entry in $packages) {
    if (-not [string]::IsNullOrWhiteSpace($entry)) {
        # Check if the entry contains a version (e.g., package=version)
        $splitEntry = $entry -split "@"
        $packageName = $splitEntry[0].Trim()
        $packageVersion = if ($splitEntry.Length -gt 1) { $splitEntry[1].Trim() } else { $null }

        if ($packageVersion) {
            choco install $packageName --version $packageVersion -y
        } else {
            choco install $packageName -y
        }
    }
}

