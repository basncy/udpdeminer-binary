cd /d "%~dp0"
set EVENT=%1
set STREAMID=%2
set SRVSTR=%3
set LSTR=%4

::set /a "randnum=%RANDOM% %% 40000 + 2048"

@echo off
if "%EVENT%"=="startpre" (
	start /min wstunnel.exe client -L "udp://%LSTR%:[::1]:10000?timeout_sec=0" ws://%SRVSTR% --http-headers host:speedtest.com
	timeout /t 1 >nul
	exit 0
)

if "%EVENT%"=="stoppost" (
	taskkill /F /IM wstunnel.exe
	exit 0
)
