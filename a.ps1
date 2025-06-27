# Çalışma dizinini al (script'in bulunduğu klasör)
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Bulunduğu klasördeki tüm .ps1 dosyalarını sırayla çalıştır
Get-ChildItem -Path $scriptDir -Filter "*.ps1" | Sort-Object Name | ForEach-Object {
    powershell.exe -ExecutionPolicy Bypass -File $_.FullName
}
