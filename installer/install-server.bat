@echo off
setlocal EnableDelayedExpansion
title Forge Server Installer

echo ==========================================
echo       FORGE SERVER INSTALLER
echo ==========================================
echo.

REM ==========================================
REM Buscar el instalador de Forge
REM ==========================================

set "FORGE_INSTALLER="

for %%F in (forge-*-installer.jar) do (
    set "FORGE_INSTALLER=%%F"
    goto :found_installer
)

echo [ERROR] No se ha encontrado ningun instalador de Forge.
echo.
echo Coloca este archivo .bat junto al:
echo forge-XXXX-installer.jar
echo.
pause
exit /b 1

:found_installer

echo Instalador encontrado:
echo !FORGE_INSTALLER!
echo.

REM ==========================================
REM Comprobar Java
REM ==========================================

echo [1/5] Comprobando Java...
echo.

java -version >nul 2>&1

if errorlevel 1 (
    echo [ERROR] Java no esta instalado o no esta en PATH.
    echo.
    echo Instala Java y vuelve a ejecutar este archivo.
    echo.
    pause
    exit /b 1
)

echo Java encontrado correctamente.
echo.

REM ==========================================
REM Instalar Forge
REM ==========================================

echo [2/5] Instalando Forge...
echo.

java -jar "!FORGE_INSTALLER!" --installServer

if errorlevel 1 (
    echo.
    echo [ERROR] La instalacion de Forge ha fallado.
    echo.
    pause
    exit /b 1
)

echo.
echo Forge se ha instalado correctamente.
echo.

REM ==========================================
REM Configurar RAM
REM ==========================================

echo [3/5] Configuracion de RAM
echo.
echo Introduce solamente el numero.
echo.
echo Ejemplos:
echo   4G
echo   8G
echo   12G
echo   2500M
echo.

:ask_min_ram

set /p "MIN_RAM=RAM minima (Xms): "

if "!MIN_RAM!"=="" (
    echo.
    echo [ERROR] Debes introducir una cantidad.
    echo.
    goto :ask_min_ram
)

:ask_max_ram

set /p "MAX_RAM=RAM maxima (Xmx): "

if "!MAX_RAM!"=="" (
    echo.
    echo [ERROR] Debes introducir una cantidad.
    echo.
    goto :ask_max_ram
)

echo.
echo RAM minima: !MIN_RAM!
echo RAM maxima: !MAX_RAM!
echo.

REM ==========================================
REM Comprobar user_jvm_args.txt
REM ==========================================

if not exist "user_jvm_args.txt" (
    echo [ERROR] No se ha encontrado user_jvm_args.txt.
    echo.
    pause
    exit /b 1
)

REM ==========================================
REM Crear/modificar user_jvm_args.txt
REM ==========================================

echo Configurando user_jvm_args.txt...

(
    echo # Xmx and Xms set the maximum and minimum RAM usage, respectively.
    echo # They can take any number, followed by an M or a G.
    echo # M means Megabyte, G means Gigabyte.
    echo.
    echo -Xmx!MAX_RAM!
    echo -Xms!MIN_RAM!
) > user_jvm_args.txt

echo.
echo user_jvm_args.txt configurado:
echo.
type user_jvm_args.txt
echo.

REM ==========================================
REM Aceptar EULA
REM ==========================================

echo [4/5] Aceptando EULA...
echo.

(
    echo #By changing the setting below to TRUE you are indicating your agreement to our EULA
    echo #https://aka.ms/MinecraftEULA
    echo eula=true
) > eula.txt

echo EULA aceptado.
echo.

REM ==========================================
REM Ejecutar servidor
REM ==========================================

if not exist "run.bat" (
    echo [ERROR] No se ha encontrado run.bat.
    echo.
    echo Forge no genero el archivo de inicio esperado.
    echo.
    pause
    exit /b 1
)

echo [5/5] Iniciando servidor Forge...
echo.
echo ==========================================
echo          SERVIDOR INICIANDO
echo ==========================================
echo.
echo RAM minima: !MIN_RAM!
echo RAM maxima: !MAX_RAM!
echo.
echo Pulsa CTRL+C para detener el servidor.
echo.

call run.bat

echo.
echo ==========================================
echo          SERVIDOR DETENIDO
echo ==========================================
echo.

pause