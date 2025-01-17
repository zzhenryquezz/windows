# Show taskbar only on the primary monitor
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "MMTaskbarEnabled" -Value 0
    Write-Host "Taskbar set to primary monitor only."
} catch {
    Write-Host "Failed to configure taskbar monitor setting: $($_)" -ForegroundColor Yellow
}
