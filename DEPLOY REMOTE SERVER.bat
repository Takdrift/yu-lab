@ECHO # deploy remote web pages

:: delete public folder
rmdir /s/q public

:: generate public folder
hugo -b http://10.71.206.64/

pause