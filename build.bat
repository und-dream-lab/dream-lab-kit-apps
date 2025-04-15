@echo off

:: Set environment variables
set "PACKAGE_DIR=_build\packages\"

:: Build and package
echo ### Build and Package ###
call repo build -x || exit /b 1
call repo package || exit /b 1

:: Initialize the latest text file variable
set "LATEST_TXT_FILE=EMPTY"

:: Find the latest text file
for %%F in ("%PACKAGE_DIR%*latest.txt") do (
    set "LATEST_TXT_FILE=%%F"
)

:: Check if the latest text file was found
if "%LATEST_TXT_FILE%"=="EMPTY" (
    echo Error: No latest.txt file found in %PACKAGE_DIR%
    exit /b 1
)

:: Get package name from the release text file
echo Get package name from %LATEST_TXT_FILE%
<"%LATEST_TXT_FILE%" set /p ORIGINAL_PACKAGE_NAME=

:: Validate the package name
if "%ORIGINAL_PACKAGE_NAME%"=="" (
    echo Error: Failed to read package name from %LATEST_TXT_FILE%
    exit /b 1
)

echo Package name: %ORIGINAL_PACKAGE_NAME%

:: Get the package version
set /p PACKAGE_VERSION=<tools\VERSION.MD

:: Validate the package version
if "%PACKAGE_VERSION%"=="" (
    echo Error: Failed to read package version from tools\VERSION.MD
    exit /b 1
)

:: Rename the package
set "TARGET_APP_NAME=dream-lab-composer-%PACKAGE_VERSION%.zip"
echo Renaming the package to %TARGET_APP_NAME%
ren "%PACKAGE_DIR%%ORIGINAL_PACKAGE_NAME%" "%TARGET_APP_NAME%" || (
    echo Error: Failed to rename the package
    exit /b 1
)

echo Build and packaging completed successfully.