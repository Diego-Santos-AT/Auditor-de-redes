@echo off
setlocal EnableDelayedExpansion
title DIEGO SANTOS 2025 - AUDITORIA DE CIBERSEGURIDAD INTEGRAL
chcp 65001 >nul
cls

:: --- MOTOR GRAFICO (COLORES NEON) ---
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "ESC=%%b"
)
set "Red=%ESC%[91m"
set "Green=%ESC%[92m"
set "Yellow=%ESC%[93m"
set "Blue=%ESC%[94m"
set "Magenta=%ESC%[95m"
set "Cyan=%ESC%[96m"
set "White=%ESC%[97m"
set "Reset=%ESC%[0m"

:: --- CHEQUEO DE ADMIN ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo %Red%[ERROR DE PERMISOS]%Reset%
    echo Necesitas ejecutar esto como Administrador.
    echo Clic derecho - Ejecutar como admin.
    pause
    exit
)

:MENU
cls
echo %Cyan%=========================================================================%Reset%
echo    %Magenta%SUITE DE SEGURIDAD 2025 - DIEGO SANTOS (ULTIMATE)%Reset%
echo %Cyan%=========================================================================%Reset%
echo.
echo    %Yellow%[0] CONFIGURACION INICIAL (Solo la primera vez)%Reset%
echo.
echo    %White%[1] AUDITORIA LOCAL AVANZADA%Reset%
echo        (BitLocker, Updates, Firewall, Usuarios, Discos)
echo.
echo    %White%[2] RECONOCIMIENTO DE RED (CON MAC ADDRESS)%Reset%
echo        (Busca equipos y muestra sus direcciones fisicas)
echo.
echo    %White%[3] ESCANER DE VULNERABILIDADES "FULL SPECTRUM"%Reset%
echo        (Analiza los 10 puertos mas atacados en 2025: SQL, SSH, RDP...)
echo.
echo    %White%[4] SALIR%Reset%
echo.
set /p opcion="%Cyan%>> COMANDO: %Reset%"

if "%opcion%"=="0" goto SETUP
if "%opcion%"=="1" goto LOCAL_AUDIT
if "%opcion%"=="2" goto NET_MAP
if "%opcion%"=="3" goto VULN_SCAN
if "%opcion%"=="4" exit
goto MENU

:: =============================================================================
:: [0] SETUP
:: =============================================================================
:SETUP
cls
echo %Cyan%--- CONFIGURANDO ENTORNO ---%Reset%
echo.
powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
echo %Green%[OK] Sistema preparado para auditoria.%Reset%
pause
goto MENU

:: =============================================================================
:: [1] AUDITORIA LOCAL AVANZADA (Nivel 2025)
:: =============================================================================
:LOCAL_AUDIT
cls
echo %Cyan%--------------------------------------------------%Reset%
echo %Yellow%   AUDITORIA DE SEGURIDAD DEL PC (LOCAL)%Reset%
echo %Cyan%--------------------------------------------------%Reset%
echo.

:: 1. FIREWALL
echo %White%[+] Verificando Perimetro (Firewall)...%Reset%
netsh advfirewall show allprofiles state | findstr "Inactivo" >nul
if %errorlevel%==0 ( echo    %Red%[PELIGRO] FIREWALL DESACTIVADO%Reset% ) else ( echo    %Green%[OK] Firewall Activo%Reset% )

:: 2. BITLOCKER (CIFRADO DE DISCO)
echo.
echo %White%[+] Verificando Cifrado de Disco (BitLocker)...%Reset%
powershell -NoProfile -Command "try { $status = Get-BitLockerVolume -MountPoint 'C:'; if($status.ProtectionStatus -eq 'On'){Write-Host '   [OK] El disco esta cifrado y protegido.' -ForegroundColor Green}else{Write-Host '   [RIESGO] El disco NO esta cifrado. Si te roban el PC, acceden a todo.' -ForegroundColor Red} } catch { Write-Host '   [!] No se pudo verificar BitLocker (Version Home?).' -ForegroundColor Yellow }"

:: 3. WINDOWS UPDATE
echo.
echo %White%[+] Buscando actualizaciones pendientes...%Reset%
powershell -NoProfile -Command "try { $u = New-Object -ComObject Microsoft.Update.AutoUpdate; if($u.Results.LastSearchSuccessDate -lt (Get-Date).AddDays(-30)){Write-Host '   [ALERTA] Hace mas de 30 dias que no buscas parches.' -ForegroundColor Red}else{Write-Host '   [OK] Busqueda de parches reciente.' -ForegroundColor Green} } catch { echo [!] Skip }"

:: 4. PUERTOS LOCALES
echo.
echo %White%[+] Puertos abiertos en TU maquina...%Reset%
netstat -ano | findstr ":445 " | findstr "LISTENING" >nul && echo    %Red%[ALERTA] Puerto 445 (SMB) expuesto.%Reset%
netstat -ano | findstr ":3389 " | findstr "LISTENING" >nul && echo    %Yellow%[AVISO] Escritorio Remoto habilitado.%Reset%
echo    %Cyan%[INFO] Revision de puertos locales terminada.%Reset%

echo.
pause
goto MENU

:: =============================================================================
:: [2] MAPA DE RED + MAC ADDRESS
:: =============================================================================
:NET_MAP
cls
echo %Cyan%--------------------------------------------------%Reset%
echo %Yellow%   INTELIGENCIA DE RED (ACTIVOS)%Reset%
echo %Cyan%--------------------------------------------------%Reset%
echo.
ipconfig | findstr "IPv4"
echo.
:ASK_RED
set "red="
set /p red="%Cyan%>> Escribe el segmento (Ej: 192.168.1): %Reset%"
if "%red%"=="" goto ASK_RED

cls
echo %Magenta%Escaneando %red%.x ... Buscando IPs y MACs...%Reset%
echo %White%Esto puede tardar. Se paciente.%Reset%
echo.

:: Limpiamos cache ARP para datos frescos
arp -d * >nul 2>&1

:: Bucle rapido de Ping para despertar equipos
for /L %%i in (1,1,254) do (
    ping -n 1 -w 15 %red%.%%i >nul
)

:: Ahora leemos la tabla ARP que contiene las MACs reales
echo %Green%--- DISPOSITIVOS ENCONTRADOS ---%Reset%
arp -a | findstr "%red%."
echo.
echo %Cyan%CONSEJO:%Reset%
echo La "Direccion fisica" (MAC) es como la huella digital del dispositivo.
echo Copia la IP de la izquierda para escanearla en el paso 3.
echo.
pause
goto MENU

:: =============================================================================
:: [3] ESCANER "FULL SPECTRUM" (10 PUERTOS)
:: =============================================================================
:VULN_SCAN
cls
echo %Cyan%--------------------------------------------------%Reset%
echo %Red%   ANALISIS DE VULNERABILIDAD 2025 (DEEP SCAN)%Reset%
echo %Cyan%--------------------------------------------------%Reset%
echo.
:ASK_TARGET
set "target="
set /p target="%Cyan%>> IP Objetivo (Ej. 192.168.1.55): %Reset%"
if "%target%"=="" goto ASK_TARGET

cls
echo %Magenta%Iniciando auditoria profunda a %target%...%Reset%
echo %White%Analizando servicios criticos empresariales.%Reset%
echo.

:: --- BLOQUE DE ESCANEO ---

:: SMB (445)
echo %Yellow%[...] Testeando Archivos Compartidos (SMB/445)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 445 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[CRITICO] ABIERTO. Riesgo Ransomware alto.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: RDP (3389)
echo %Yellow%[...] Testeando Escritorio Remoto (RDP/3389)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 3389 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[ALERTA] ABIERTO. Puerta de entrada hackers.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: SQL SERVER (1433)
echo %Yellow%[...] Testeando Base de Datos SQL (1433)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 1433 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[PELIGRO] SQL SERVER ABIERTO. Robo de datos posible.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: SSH (22)
echo %Yellow%[...] Testeando Servidores Linux/SSH (22)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 22 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[ALERTA] SSH ABIERTO. Acceso consola detectado.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: FTP (21)
echo %Yellow%[...] Testeando Transferencia FTP (21)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 21 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[RIESGO] FTP ABIERTO. Trafico sin cifrar.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: TELNET (23)
echo %Yellow%[...] Testeando Telnet Antiguo (23)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 23 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[OBSOLETO] TELNET ABIERTO. Muy inseguro.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: VNC (5900)
echo %Yellow%[...] Testeando Control Remoto VNC (5900)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 5900 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Red%[ALERTA] VNC ABIERTO. Pantalla remota visible.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: HTTP (80)
echo %Yellow%[...] Testeando Web HTTP (80)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 80 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Cyan%[INFO] Web Server detectado.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

:: PROXY (8080)
echo %Yellow%[...] Testeando Proxy/Alternativo (8080)...%Reset%
powershell -NoProfile -Command "try{if(Test-NetConnection '%target%' -Port 8080 -InformationLevel Quiet){exit 1}else{exit 0}}catch{exit 0}"
if %errorlevel%==1 ( echo      %Cyan%[INFO] Servicio Web 8080 detectado.%Reset% ) else ( echo      %Green%[OK] Cerrado.%Reset% )

echo.
echo %Green%ANALISIS DE %target% COMPLETADO.%Reset%
pause
goto MENU