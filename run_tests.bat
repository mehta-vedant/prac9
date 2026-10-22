@echo off
setlocal

rem Prefer a normal Python installation. The fallback supports this laptop's
rem Python 3.13 runtime bundled with pgAdmin when python is not on PATH.
set "PYTHON_EXE=C:\Program Files\PostgreSQL\18\pgAdmin 4\python\python.exe"
if not exist "%PYTHON_EXE%" set "PYTHON_EXE=python"

if not exist "%PYTHON_EXE%" (
    echo Python was not found. Install Python or set PYTHON_EXE in run_tests.bat.
    exit /b 1
)

if /I "%~1"=="install" (
    if exist ".venv\Lib\site-packages\pytest" exit /b 0
    "%PYTHON_EXE%" -m pip install --target .venv\Lib\site-packages -r requirements.txt
    exit /b %ERRORLEVEL%
)

if /I "%~1"=="test" (
    set "PYTHONPATH=%CD%\.venv\Lib\site-packages"
    "%PYTHON_EXE%" -m pytest --junitxml=test-results.xml
    exit /b %ERRORLEVEL%
)

echo Usage: run_tests.bat install ^| test
exit /b 1
