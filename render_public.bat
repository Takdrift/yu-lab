@ECHO # rendering public folder
cd %~dp0

:: delete public folder
:: del /q ..\public
rmdir /s/q ..\public

:: delay about 10 seconds
ping -n 10 127.0.0.1 >nul

:: generate public folder
hugo -b http://10.71.206.64/ -d ../public

:: delay about 30 seconds
:: ping -n 30 127.0.0.1 >nul

:: @echo %date:~0,10% %time:~0,5%

