echo ON

if not "%RECIPE%"=="" (
	if exist ..\conda\%RECIPE%\appveyor-ci.patch (
		cd ..
		git apply -v conda\%RECIPE%\appveyor-ci.patch
		if errorlevel neq 0 exit /b 1
		cd appveyor-ci
	)
)

if not "%ENVIRONMENT%"== "" (
	cd ..
	conda env create -f environment.yml
	activate $ENVIRONMENT
)

echo OFF
