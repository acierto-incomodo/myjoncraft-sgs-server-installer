@echo off
setlocal
title Forge Server Reinstall

echo ==========================================
echo       FORGE SERVER REINSTALL
echo ==========================================
echo.
echo Este proceso eliminara:
echo.
echo   - logs\
echo   - libraries\
echo   - forge-1.20.1-47.4.18-installer.jar.log
echo   - run.bat
echo   - run.sh
echo   - user_jvm_args.txt
echo.
echo El servidor se volvera a instalar.
echo.

choice /C SN /N /M "Quieres continuar? [S/N]: "

if errorlevel 2 (
    echo.
    echo Reinstalacion cancelada.
    pause
    exit /b 0
)

echo.
echo ==========================================
echo Eliminando archivos...
echo ==========================================
echo.

REM Eliminar carpeta logs
if exist "logs\" (
    echo Eliminando logs...
    rmdir /S /Q "logs"
) else (
    echo [INFO] logs no existe.
)

REM Eliminar carpeta libraries
if exist "libraries\" (
    echo Eliminando libraries...
    rmdir /S /Q "libraries"
) else (
    echo [INFO] libraries no existe.
)

REM Eliminar log del instalador
if exist "forge-1.20.1-47.4.18-installer.jar.log" (
    echo Eliminando forge-1.20.1-47.4.18-installer.jar.log...
    del /Q "forge-1.20.1-47.4.18-installer.jar.log"
) else (
    echo [INFO] Log del instalador no existe.
)

REM Eliminar run.bat
if exist "run.bat" (
    echo Eliminando run.bat...
    del /Q "run.bat"
) else (
    echo [INFO] run.bat no existe.
)

REM Eliminar run.sh
if exist "run.sh" (
    echo Eliminando run.sh...
    del /Q "run.sh"
) else (
    echo [INFO] run.sh no existe.
)

REM Eliminar user_jvm_args.txt
if exist "user_jvm_args.txt" (
    echo Eliminando user_jvm_args.txt...
    del /Q "user_jvm_args.txt"
) else (
    echo [INFO] user_jvm_args.txt no existe.
)

REM Eliminar installer.log
if exist "installer.log" (
    echo Eliminando installer.log...
    del /Q "installer.log"
) else (
    echo [INFO] installer.log no existe.
)

echo.
echo ==========================================
echo Limpieza completada.
echo ==========================================
echo.

REM Comprobar que install-server.bat existe
if not exist "install-server.bat" (
    echo [ERROR] No se encuentra install-server.bat
    echo.
    echo Coloca reinstall.bat junto a install-server.bat.
    echo.
    pause
    exit /b 1
)

echo Iniciando instalacion de Forge...
echo.

call "install-server.bat"

exit /b