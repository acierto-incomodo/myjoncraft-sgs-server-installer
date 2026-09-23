@echo off
setlocal EnableExtensions
title Forge Server - Full Reinstall

echo ==========================================
echo       FORGE SERVER FULL REINSTALL
echo ==========================================
echo.
echo ATENCION:
echo.
echo Se eliminara TODO el contenido de esta
echo carpeta excepto:
echo.
echo   - forge-1.20.1-47.4.18-installer.jar
echo   - install-server.bat
echo   - reinstall.bat
echo   - reinstall-all.bat
echo   - eliminar-todo.bat
echo.
echo Esto incluye:
echo   - world
echo   - mods
echo   - config
echo   - libraries
echo   - logs
echo   - eula.txt
echo   - server.properties
echo   - user_jvm_args.txt
echo   - run.bat
echo   - run.sh
echo   - cualquier otro archivo
echo.

choice /C SN /N /M "Estas seguro de continuar? [S/N]: "

if errorlevel 2 (
    echo.
    echo Reinstalacion cancelada.
    pause
    exit /b
)

echo.
echo ==========================================
echo ELIMINANDO ARCHIVOS
echo ==========================================
echo.

REM --------------------------------------------------
REM Eliminar archivos excepto los permitidos
REM --------------------------------------------------

for %%F in (*) do call :DeleteFile "%%~nxF"

echo.
echo ==========================================
echo ELIMINANDO CARPETAS
echo ==========================================
echo.

REM --------------------------------------------------
REM Eliminar TODAS las carpetas
REM --------------------------------------------------

for /D %%D in (*) do (
    echo Eliminando carpeta: %%D
    rmdir /S /Q "%%D"
)

echo.
echo ==========================================
echo LIMPIEZA COMPLETADA
echo ==========================================
echo.

exit /b


REM ==================================================
REM FUNCION PARA ELIMINAR ARCHIVOS
REM ==================================================

:DeleteFile

set "FILE=%~1"

REM Conservar install-server.bat
if /I "%FILE%"=="install-server.bat" exit /b

REM Conservar reinstall.bat
if /I "%FILE%"=="reinstall.bat" exit /b

REM Conservar reinstall-all.bat
if /I "%FILE%"=="reinstall-all.bat" exit /b

REM Conservar eliminar-todo.bat
if /I "%FILE%"=="eliminar-todo.bat" exit /b

REM Conservar instalador Forge
if /I "%FILE%"=="forge-1.20.1-47.4.18-installer.jar" exit /b

REM Eliminar cualquier otro archivo
echo Eliminando archivo: %FILE%
del /F /Q "%FILE%"

exit /b