echo ON

if "%CONDA_VERSION%" == "" (
  set CONDA_VERSION=2
)

if not "%ANACONDA_USERNAME%" == "" (
  if "%ANACONDA_UPLOAD%" == "" (
    set ANACONDA_UPLOAD=%ANACONDA_USERNAME%
  )
)

if "%ANACONDA_DEPLOY%" == "" (
    if not "%ANACONDA_USERNAME%" == "" (
        set ANACONDA_DEPLOY=true
    ) else (
        set ANACONDA_DEPLOY=false
    )
)

if "%ANACONDA_LABEL%" == "" (
    set ANACONDA_LABEL=main
)

if "%PLATFORM%" == "x86" (
  set ARCH=x86
) else (
  set ARCH=x86_64
)

rmdir /s /q C:\Miniconda
if errorlevel 1 exit 1
curl https://repo.continuum.io/miniconda/Miniconda%CONDA_VERSION%-latest-Windows-%ARCH%.exe -o miniconda.exe
if errorlevel 1 exit 1
miniconda.exe /AddToPath=1 /InstallationType=JustMe /RegisterPython=0 /S /D=%HOMEDRIVE%\Miniconda 
if errorlevel 1 exit 1
del miniconda.exe
if errorlevel 1 exit 1
set PATH=%HOMEDRIVE%\Miniconda;%HOMEDRIVE%\Miniconda\Scripts;%PATH%
if errorlevel 1 exit 1
call %HOMEDRIVE%\Miniconda\Scripts\activate.bat root
if not "%ANACONDA_CHANNELS%"=="" (
  conda config --add channels %ANACONDA_CHANNELS%
  if errorlevel 1 exit 1
)
call config.bat
if errorlevel 1 exit 1

conda update conda
if errorlevel 1 exit 1
conda install conda-build anaconda-client
if errorlevel 1 exit 1

for /f %%i in ('python python_version.py') DO (set PYTHON_VERSION=%%i)
if errorlevel 1 exit 1

set MAJOR_PYTHON_VERSION=%PYTHON_VERSION:~0,1%

if "%PYTHON_VERSION:~2,1%" == "" (
    :: PYTHON_VERSION style, such as 27, 34 etc.
    set MINOR_PYTHON_VERSION=%PYTHON_VERSION:~1,1%
) else (
    if "%PYTHON_VERSION:~3,1%" == "." (
     set MINOR_PYTHON_VERSION=%PYTHON_VERSION:~2,1%
    ) else (
     set MINOR_PYTHON_VERSION=%PYTHON_VERSION:~2,2%
    )
)

set CMD_IN_ENV=cmd /E:ON /V:ON /C %cd%\\cmd_in_env.cmd
if errorlevel 1 exit 1

set TEST_LEVEL=1
if errorlevel 1 exit 1

echo OFF
