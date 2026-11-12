@echo off
setlocal
pushd "%~dp0"
call gradlew.bat --console=plain :run
set "jogo_resultado=%errorlevel%"
if not "%jogo_resultado%"=="0" pause
popd
exit /b %jogo_resultado%
