echo ON

if "%PLATFORM%"=="x32" set PATH=C:\Miniconda;C:\Miniconda\Scripts;%PATH%
if "%PLATFORM%"=="x64" set PATH=C:\Miniconda-x64;C:\Miniconda-x64\Scripts;%PATH%
if %errorlevel% neq 0 exit /b %errorlevel%

conda config --set always_yes yes --set changeps1 no
if %errorlevel% neq 0 exit /b %errorlevel%
conda update -q conda
if %errorlevel% neq 0 exit /b %errorlevel%
conda info -a
if %errorlevel% neq 0 exit /b %errorlevel%
conda install conda-build=1.21
if %errorlevel% neq 0 exit /b %errorlevel%
conda install anaconda-client
if %errorlevel% neq 0 exit /b %errorlevel%

for /f %%i in ('python python_version.py') DO (set PYTHON_VERSION=%%i)
if %errorlevel% neq 0 exit /b %errorlevel%
set CMD_IN_ENV=cmd /E:ON /V:ON /C %cd%\\cmd_in_env.cmd
if %errorlevel% neq 0 exit /b %errorlevel%