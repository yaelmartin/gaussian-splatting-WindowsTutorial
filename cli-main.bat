@echo off
setlocal enabledelayedexpansion

:: Activate the Conda environment
:: modify the path to suit your system!
call C:\ProgramData\anaconda3\condabin\conda.bat activate gs


:: Show the final settings string
echo Retrieved settings:
:: Initialize an empty settings string
set "settings="
:: Read the settings from the file, ignoring lines that start with #
for /f "eol=# delims=" %%a in (cli-train-settings.txt) do (
    :: Echo the line
    echo %%a

    :: Add the line to the settings string
    set "settings=!settings! %%a"
)

echo.
echo Provide the path to your source folder.
echo You can simply paste the path here or drag and drop the folder into this window.
echo You can add optional arguments to customize the process. 
:input_loop
:: Wait for the user's input
set /p "user_input=Your input: "

:: Extract the folder name from the user's input
for %%i in (%user_input%) do (
    if exist "%%~i\" (
        set "folder_name=%%~nxi"
        goto :show_command
    )
)

echo The source directory you entered is not valid. Please try again.
goto :input_loop

:show_command
:: Show the final command to the user
echo python train.py %settings% -s %user_input% -m output/%folder_name%

:: Uncomment the line below to run the command
python train.py %settings% -s %user_input% -m output/%folder_name%

pause
