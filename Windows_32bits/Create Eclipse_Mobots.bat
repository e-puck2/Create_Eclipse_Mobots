@echo off
set current_dir=%cd%

echo.
echo.
echo WARNING All the paths you give must be correct
echo otherwise unpredictable behaviors could happen
echo Spaces in the paths are not allowed
echo.
echo You can drag and drop every file of folder in the terminal to 
echo give their path
echo .
echo Enter the path to the folder where you want 
echo to generate the Eclipse_Mobots folder and press [ENTER]

set /p installation_dir=

echo.
echo Enter the path to the eclipse folder you want to use and press [ENTER]

set /p eclipse_path=

echo.
echo Enter the path to the arm-none-eabi toolchain folder you want to use 
echo and press [ENTER]

set /p gcc_path=
for %%a in ("%gcc_path%") do set "gcc_folder_name=%%~na"

echo.
echo Copying Eclipse

mkdir %installation_dir%\Eclipse_Mobots
if %errorlevel% neq 0 (
pause
exit
)
mkdir %installation_dir%\Eclipse_Mobots\eclipse
if %errorlevel% neq 0 (
pause
exit
)
xcopy %eclipse_path% %installation_dir%\Eclipse_Mobots\eclipse /s /e /q
if %errorlevel% neq 0 (
pause
exit
)

echo Eclipse copied

echo.
echo Copying Instalation stuff to Eclipse_Mobots folder
xcopy %current_dir%\"Installation Stuff" %installation_dir%\Eclipse_Mobots /s /e /q
if %errorlevel% neq 0 (
pause
exit
)
echo Installation stuff copied

echo.
echo Copying arm-none-eabi
mkdir %installation_dir%\Eclipse_Mobots\Tools\%gcc_folder_name%
if %errorlevel% neq 0 (
pause
exit
)
xcopy %gcc_path% %installation_dir%\Eclipse_Mobots\Tools\%gcc_folder_name% /s /e /q
if %errorlevel% neq 0 (
pause
exit
)
echo arm-none-eabi copied

echo.
echo Installing the Hardware Debugging plugin
echo Please authorize the opening of Ecipse if asked

%installation_dir%/Eclipse_Mobots/eclipse/eclipsec.exe ^
-clean -purgeHistory ^
-application org.eclipse.equinox.p2.director ^
-noSplash ^
-repository http://download.eclipse.org/tools/cdt/releases/9.3 ^
-installIUs org.eclipse.cdt.debug.gdbjtag.feature.group
if %errorlevel% neq 0 (
pause
exit
)
echo Hardware Debugging plugin installed

echo.
echo Unzipping Workspace

%current_dir%\"Installation Stuff"\Tools\gnutools\bin\7za.exe x %current_dir%\Workspace.zip -o%installation_dir%\Eclipse_Mobots
if %errorlevel% neq 0 (
pause
exit
)
echo.
echo Workspace unzipped

echo.
echo Configuring the PATH to the arm-none-eabi folder given
echo \tools\%gcc_folder_name%\bin>%installation_dir%\Eclipse_Mobots\eclipse\gcc_path.txt
if %errorlevel% neq 0 (
pause
exit
)
echo.
echo Finished

PAUSE