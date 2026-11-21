@echo off
set /p "IP=Enter the Pi's IP address: "
set "W=%TEMP%\n64"
rmdir /s /q "%W%" 2>nul & mkdir "%W%" & cd /d "%W%"
for /f "tokens=1,* delims=|" %%A in ('powershell -NoProfile -Command "$h=(Invoke-WebRequest -UseBasicParsing 'https://drive.google.com/embeddedfolderview?id=1OKCkXr030jaP0gbF2LIshLd0rBDzyklq').Content; foreach($m in [regex]::Matches($h,'(?s)id=.entry-([\w-]+).*?flip-entry-title.>(.*?)<')){ $n=[Net.WebUtility]::HtmlDecode($m.Groups[2].Value); if($n -like '*.z64'){ $m.Groups[1].Value+'|'+$n } }"') do echo Downloading %%B & curl -sL -o "%%B" "https://drive.usercontent.google.com/download?id=%%A&export=download&confirm=t"
echo Password is: linux
scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=NUL *.z64 root@%IP%:/userdata/roms/n64
cd /d "%TEMP%" & rmdir /s /q "%W%"
pause
