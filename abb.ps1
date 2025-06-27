$folderPath = "C:\Users\Enes\Desktop\ab\test1"
Get-ChildItem -Path $folderPath -Filter *.ps1 | ForEach-Object {
    Write-Host "Çalıştırılıyor: $($_.FullName)"
    & $_.FullName
}
