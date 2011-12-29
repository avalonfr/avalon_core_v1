:top
@echo off
echo.
color 9
echo  Please enter your MySQL info:
echo  If this information is not correct
echo  the import will not work...
echo  You may modify this script however you want :D
echo.
set /p host= 	MySQL Server Address (Default = localhost): 
if %host%. == . set host=localhost
set /p user= 	MySQL Username (Default = root): 
if %user%. == . set user=root
set /p pass= 	MySQL Password (Default = ): 
if %pass%. == . set pass=
set /p world_db= 	Trinity World Database (Default = world): 
if %world_db%. == . set world_db=world
set /p chars_db= 	Characters Database (Default = characters): 
if %chars_db%. == . set chars_db=characters
set /p realmd_db= 	Realmd Database (Default = auth): 
if %realmd_db%. == . set realmd_db=auth
set port=3306

set trinitysql=.\world_updates\
set realmdsql=.\auth_updates\
set charsql=.\characters_updates\
set mysqlpath=.\mysql\

:main
CLS
echo.
echo  _______   _       _ _          _____  ____  _       
echo #__   __# (_)     (_) #        / ____#/ __ \# #      
echo    # #_ __ _ _ __  _# #_ _   _# (___ # #  # # #      
echo    # # '__# # '_ \# # __# # # #\___ \# #  # # #      
echo    # # #  # # # # # # #_# #_# #____) # #__# # #____  
echo    #_#_#  #_#_# #_#_#\__#\__, #_____/ \___\_\______# 
echo                           __/ #                      
echo                          #___/                       
echo.
echo                          _____                            _             
echo                         #_   _#                          # #            
echo                           # #  _ __ ___  _ __   ___  _ __# #_  ___ _ __ 
echo                           # # # '_ ` _ \# '_ \ / _ \# '__# __#/ _ \ '__#
echo                          _# #_# # # # # # #_) # (_) # #  # #_#  __/ #   
echo                         #_____#_# #_# #_# .__/ \___/#_#   \__#\___#_#   
echo                                         # #                             
echo                                         #_#  
ECHO    Trinity SQL Importer.
echo    Note: Please refer to the README.txt
echo    if you have not read it before
echo    else this will surely fail.
echo  -----------
Echo   Main Menu 
echo  -----------
ECHO.
echo    c - Trinity Character Database update(s)
echo    r - Trinity Auth Database update(s)
echo    u - Trinity World Database update(s)
echo    z - Reconfigure Mysql Information
echo    x - Close the program
echo.
set /p v=	Enter a letter: 
if %v%==* goto error
if %v%==c goto chars
if %v%==C goto chars
if %v%==r goto realmd
if %v%==R goto realmd
if %v%==u goto updates
if %v%==U goto updates
if %v%==z goto top
if %v%==Z goto top
if %v%==x goto close
if %v%==X goto close
set v=
goto error

:close
CLS
EXIT

:chars
CLS
echo.
echo  Importing Trinity Character Database update(s)..
echo.
for %%C in (%charsql%\*.sql) do (
   echo import: %%~nxC
D:\wamp\bin\mysql\mysql5.1.53\bin\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %chars_db% < "%%~fC"
)
echo.
echo  Done.
echo.
echo  Press any key to return to the main menu.
pause >NUL
goto main

:updates
CLS
echo.
echo  Importing Trinity World Database update(s)..
echo.
for %%C in (.\*.sql) do (
   echo import: %%~nxC
D:\wamp\bin\mysql\mysql5.1.53\bin\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
echo.
echo  Done.
echo.
echo  Press any key to return to the main menu.
pause >NUL
goto main

:realmd
CLS
echo.
echo  Importing Trinity Auth Database update(s)..
echo.
for %%C in (%realmdsql%\*.sql) do (
   echo import: %%~nxC
D:\wamp\bin\mysql\mysql5.1.53\bin\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %realmd_db% < "%%~fC"
)
echo.
echo  Done.
echo.
echo  Press any key to return to the main menu.
pause >NUL
goto main

:error
CLS
echo.
echo  Please enter the correct letter.
echo.
echo  Press any key to go back and start again.
pause >NUL
goto main