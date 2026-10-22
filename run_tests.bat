@echo off
setlocal

rem Use the standard Python installation available on this laptop. The
rem pgAdmin-bundled Python is deliberately not used because it is isolated.
set "PYTHON_EXE=C:\Users\Vedantnew\AppData\Local\Programs\Python\Python313\python.exe"
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
