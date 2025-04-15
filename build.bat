@echo off

:: ENVs
set PACKAGE_DIR=_build\packages\

:: Build and package
echo ### Build and Package ###
::call repo build -x
::call repo package

set LATEST_TXT_FILE="EMPTY"
for %%F in ("%PACKAGE_DIR%*latest.txt") do (
    set "LATEST_TXT_FILE=%%F"
)

:: Get package name from release txt file
echo Get package name from %LATEST_TXT_FILE%
<"%LATEST_TXT_FILE%" set /p PACKAGE_NAME=
echo Package name: %PACKAGE_NAME%

:: Get the package version
set /p PACKAGE_VERSION=<tools\VERSION.MD

:: Rename the package
set "TARGET_APP_NAME=dream-lab-composer-%PACKAGE_VERSION%.zip"
echo Renaming the package to %TARGET_APP_NAME%
ren %PACKAGE_DIR%%PACKAGE_NAME% %TARGET_APP_NAME%