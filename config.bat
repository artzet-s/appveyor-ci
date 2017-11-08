conda config --set always_yes yes
if errorlevel 1 exit 1
conda config --add channels openalea
if errorlevel 1 exit 1
if not "%ANACONDA_UPLOAD%" == "openalea" (
    conda config --add channels %ANACONDA_UPLOAD%
    if errorlevel 1 exit 1
    if not "%ANACONDA_LABEL%" == "main" (
      conda config --add channels %ANACONDA_UPLOAD%/label/%ANACONDA_LABEL%
      if errorlevel 1 exit 1
    )
) else (
    if not "%ANACONDA_LABEL%" == "main" (
      conda config --add channels openalea/label/%ANACONDA_LABEL%
      if errorlevel 1 exit 1
    )
)
