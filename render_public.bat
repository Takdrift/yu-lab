@ECHO # rendering public folder
cd %~dp0

:: delete public folder
:: del /q ..\public
rmdir /s/q ..\public

:: delay about 5 seconds
ping -n 5 127.0.0.1 >nul

:: generate public folder
hugo -b http://10.71.206.64/ -d ../public
