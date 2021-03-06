@echo off

rem opencon - launch the openconsole binary.
rem Runs the OpenConsole.exe binary generated by the build in the debug directory.
rem    Passes any args along.

if not exist %OPENCON%\%PLATFORM%\%_LAST_BUILD_CONF%\CascadiaWin32.exe (
    echo Could not locate the CascadiaWin32.exe in %OPENCON%\bin\%PLATFORM%\%_LAST_BUILD_CONF%. Double check that it has been built and try again.
    goto :eof
)

setlocal
rem Generate a unique name, so that we can debug multiple revisions of the binary at the same time if needed.
set rand_val=%random%
set _r=%random%
set _last_build=%OPENCON%\bin\%PLATFORM%\%_LAST_BUILD_CONF%
set _last_cascadia_build=%OPENCON%\%PLATFORM%\%_LAST_BUILD_CONF%
set copy_dir=OpenConsole\%_r%
set cascadia_copy_dir=OpenConsole\%_r%\Cascadia

(echo f | xcopy /Y %_last_build%\OpenConsole.exe %TEMP%\%copy_dir%\OpenConsole.exe) > nul
(echo f | xcopy /Y %_last_build%\OpenConsole.exe %TEMP%\%cascadia_copy_dir%\conhost.exe) > nul
(echo f | xcopy /Y %_last_build%\VtPipeTerm.exe %TEMP%\%copy_dir%\VtPipeTerm.exe) > nul
(echo f | xcopy /Y %_last_build%\Nihilist.exe %TEMP%\%copy_dir%\Nihilist.exe) > nul
(echo f | xcopy /Y %_last_build%\console.dll %TEMP%\%copy_dir%\console.dll) > nul
(echo f | xcopy /Y %_last_cascadia_build%\CascadiaWin32.exe %TEMP%\%cascadia_copy_dir%\CascadiaWin32.exe) > nul
(echo f | xcopy /Y %_last_cascadia_build%\TerminalConnection.dll %TEMP%\%cascadia_copy_dir%\TerminalConnection.dll) > nul
(echo f | xcopy /Y %_last_cascadia_build%\TerminalControl.dll %TEMP%\%cascadia_copy_dir%\TerminalControl.dll) > nul
(echo f | xcopy /Y %_last_cascadia_build%\TerminalSettings.dll %TEMP%\%cascadia_copy_dir%\TerminalSettings.dll) > nul
(echo f | xcopy /Y %_last_cascadia_build%\TerminalApp.dll %TEMP%\%cascadia_copy_dir%\TerminalApp.dll) > nul

echo Launching %TEMP%\%cascadia_copy_dir%\CascadiaWin32.exe...
start %TEMP%\%cascadia_copy_dir%\CascadiaWin32.exe %*
