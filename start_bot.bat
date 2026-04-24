@echo off
title VaultBot AutoStart

:start
@echo off
setlocal

set PATH=%cd%;%PATH%

:start

echo ================================
echo   Iniciando VaultBot...
echo ================================

cd /d %~dp0

echo.
echo [1/4] Activando entorno virtual...

IF NOT EXIST venv (
    python -m venv venv
)

call venv\Scripts\activate

echo.
echo [2/4] Actualizando pip e instalando dependencias...

python -m pip install --upgrade pip >nul

pip install -U discord.py[voice] yt-dlp python-dotenv pynacl davey --force-reinstall >nul

echo.
echo [3/4] Verificando FFmpeg...

ffmpeg -version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ❌ FFmpeg no detectado. Instálalo o agrégalo al PATH.
    pause
)

echo.
echo [4/4] Iniciando bot...

python bot.py

echo.
echo ❌ El bot se ha cerrado.
echo 🔄 Reiniciando en 5 segundos...

timeout /t 5 >nul
goto start