# Check if Chocolatey is already installed
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    # Download and install Chocolatey

    Write-Host "Installing Chocolatey..."

    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

    Write-Host "Chocolatey installation complete."
} else {
    Write-Host "Chocolatey is already installed."
}
