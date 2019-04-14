@ECHO # deploy remote web pages

:: delete public folder
rmdir /s/q public

:: delay about 3 seconds
ping -n 3 127.0.0.1 >nul

:: generate public folder
hugo -b http://10.71.206.64/

pause