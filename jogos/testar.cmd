@echo off
setlocal
pushd "%~dp0"
call gradlew.bat --console=plain test
set "teste_resultado=%errorlevel%"
echo.
pause
popd
exit /b %teste_resultado%
