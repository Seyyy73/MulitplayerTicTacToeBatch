@echo off
setlocal EnableDelayedExpansion

set owned=0
mode con: cols=39 lines=30

REM ==================================
REM      Multiplayer Tic Tac Toe
REM              created
REM                 by
REM         Seyyy aka Sayhoo73
REM         github.com/Seyyy73
REM ==================================

:basicset
cls
color 0E
set bag=0
set tex=E
echo What is your name?
:repname
set usrname=ERR
set /p "usrname=User Name: "
if %usrname% == ERR goto repname

title Playing as %usrname%

set oponent=NOTSET

:reall
cls
echo Multiplayer Tic Tac Toe
echo -------------------------------
echo.
echo.
echo  1^> Create Online Game
echo  2^> Join Online Game
echo  3^> Change Color
echo  4^> Quit
echo.

choice /c 1234v /n

if %errorlevel% EQU 1 goto create
if %errorlevel% EQU 2 goto join
if %errorlevel% EQU 3 goto col
if %errorlevel% EQU 4 goto sui
if %errorlevel% EQU 5 goto basicset

goto errex

:col
cls
echo Change Color!
echo -------------------------------
echo.
echo.
echo  1^> Background
echo  2^> Text
echo  3^> Default
echo  4^> Back
echo.

choice /c 1234 /n
if %errorlevel% EQU 4 goto reall
if %errorlevel% EQU 3 (
color 0E
set bag=0
set tex=E
goto reall
)
set csmod=%errorlevel%

cls
echo Change Color!
echo -------------------------------
echo.
echo  1^> Black
echo  2^> Blue
echo  3^> Green
echo  4^> Aqua
echo  5^> Red
echo  6^> Purple
echo  7^> Yellow
echo  8^> White
echo  9^> Gray
echo.


choice /c 123456789 /n
set /a ccd = %errorlevel% - 1
if %csmod% EQU 1 (
set bag=%ccd%
) ELSE (
set tex=%ccd%
)
color %bag%%tex%
goto reall


:create
set owned=5
set opsign=o
set mysign=x
cls
echo Creating Online Game
echo -------------------------------
echo.
echo.
:fixdirnow
set sdir=ERR
set /p "sdir=Shared Directory: "

if %sdir% == ERR goto fixdirnow
if %sdir% == back goto reall

if not exist %sdir% (
echo -- Invalid Directory Path
goto fixdirnow
)

if not %sdir:~-1% == \ (
echo --Make Sure Path looks like
echo ----C:\dir\something\
goto fixdirnow
)

echo.
echo Right! 
echo Swipe Dir Set to: "%sdir%"
echo.
:fixname
set namn=ERR
set /p "namn=Game Name: " 

if %namn% == ERR goto fixname
if %namn% == back goto reall

echo %namn%>%sdir%locked.ttt

if not exist %sdir%locked.ttt (
echo -------------------------------
echo Could not create new game!
goto errex
)

:creategamemech

echo 1 > %sdir%game.swipe
echo %usrname% > %sdir%host.swipe

set nicebar=----------
:waitingforplayer
cls
echo Waiting for another player to join!
echo !nicebar:~0,%random:~0,1%!
echo %time%
timeout /nobreak /t 1 >nul

for /f "delims=" %%x in (%sdir%game.swipe) do set resp=%%x

if %resp% == 1 goto waitingforplayer
set oponent=%resp:~0,-1%

cls
echo Preparing Game!
echo -------------------------------
echo.
echo.
echo Player: %usrname% (you): x
echo Player: %oponent% (oponent): o
echo.
echo.
echo.
echo Press Any Key To Start!
timeout /T 15 > nul

echo 6 > %sdir%game.swipe

:gameinit
cls
set tab(1)=1
set tab(2)=2
set tab(3)=3
set tab(4)=4
set tab(5)=5
set tab(6)=6
set tab(7)=7
set tab(8)=8
set tab(9)=9

set nowmove=6


:game_newt
if %nowmove% == %owned% (
set log=1
) else (
set log=3
)
:game_reselect
cls


if %nowmove% == %owned% (
echo Game: Your Turn
) ELSE (
echo Game: %oponent% Turn
)

echo -------------------------------
echo.
echo.
echo  + - + - + - +
echo  ^| %tab(1)% ^| %tab(2)% ^| %tab(3)% ^|
echo  + - + - + - +
echo  ^| %tab(4)% ^| %tab(5)% ^| %tab(6)% ^|
echo  + - + - + - +
echo  ^| %tab(7)% ^| %tab(8)% ^| %tab(9)% ^|
echo  + - + - + - +
echo.
echo.


if %log% EQU 3 (
echo Waiting for %oponent%
goto wafomove
)

if %log% EQU 1 (
echo Select: 
)
if %log% EQU 2 (
echo You Cannot Do That! Select: 
)

choice /c 123456789m /n

if %errorlevel% == 10 goto errex

if !tab(%errorlevel%)! == x (
set log=2
goto game_reselect
)
if !tab(%errorlevel%)! == o (
set log=2
goto game_reselect
)

set tab(%errorlevel%)=%mysign%


REM DO I WIN?


if not %tab(1)% == %mysign% goto et1
if not %tab(2)% == %mysign% goto et1
if not %tab(3)% == %mysign% goto et1
goto likeiwin
:et1

if not %tab(4)% == %mysign% goto et2
if not %tab(5)% == %mysign% goto et2
if not %tab(6)% == %mysign% goto et2
goto likeiwin
:et2

if not %tab(7)% == %mysign% goto et3
if not %tab(8)% == %mysign% goto et3
if not %tab(9)% == %mysign% goto et3
goto likeiwin
:et3

if not %tab(1)% == %mysign% goto et4
if not %tab(4)% == %mysign% goto et4
if not %tab(7)% == %mysign% goto et4
goto likeiwin
:et4

if not %tab(2)% == %mysign% goto et5
if not %tab(5)% == %mysign% goto et5
if not %tab(8)% == %mysign% goto et5
goto likeiwin
:et5

if not %tab(3)% == %mysign% goto et6
if not %tab(6)% == %mysign% goto et6
if not %tab(9)% == %mysign% goto et6
goto likeiwin
:et6

if not %tab(1)% == %mysign% goto et7
if not %tab(5)% == %mysign% goto et7
if not %tab(9)% == %mysign% goto et7
goto likeiwin
:et7

if not %tab(3)% == %mysign% goto et8
if not %tab(5)% == %mysign% goto et8
if not %tab(7)% == %mysign% goto et8
goto likeiwin
:et8

if %tab(1)% == 1 goto et9
if %tab(2)% == 2 goto et9
if %tab(3)% == 3 goto et9
if %tab(4)% == 4 goto et9
if %tab(5)% == 5 goto et9
if %tab(6)% == 6 goto et9
if %tab(7)% == 7 goto et9
if %tab(8)% == 8 goto et9
if %tab(9)% == 9 goto et9
goto nomoremoves
:et9




echo %errorlevel% > %sdir%carrier.swipe

if %owned% == 5 (
echo 6 > %sdir%game.swipe
set nowmove=6
) ELSE (
echo 5 > %sdir%game.swipe
set nowmove=5
)

goto game_newt

:wafomove
timeout /nobreak /t 1 >nul
for /f "delims=" %%x in (%sdir%game.swipe) do set resp=%%x
if not %resp% == %owned% goto wafomove
set nowmove=%owned%

set carryfl=err
set /p carryfl=<%sdir%carrier.swipe

if %carryfl% == err goto errex

set tab(%carryfl:~0,1%)=%opsign%
if %carryfl% equ 13 goto likeidied
if %carryfl% equ 14 goto nomoremoves

goto game_newt

:nomoremoves
echo 14 > %sdir%carrier.swipe
if %owned% == 5 (
echo 6 > %sdir%game.swipe
) ELSE (
echo 5 > %sdir%game.swipe
)
echo.
echo.
echo +----------------------------+
echo.
echo  Nobody Wins!
echo.
echo +----------------------------+
echo.
echo.
goto endofgame

:likeiwin
echo 13 > %sdir%carrier.swipe
if %owned% == 5 (
echo 6 > %sdir%game.swipe
) ELSE (
echo 5 > %sdir%game.swipe
)
echo.
echo.
echo +----------------------------+
echo.
echo  You were Winner!
echo.
echo +----------------------------+
echo.
echo.
goto endofgame

:likeidied
echo.
echo.
echo +----------------------------+
echo.
echo  You were Looser!
echo.
echo +----------------------------+
echo.
echo.
:endofgame

if %owned% EQU 5 goto hostselector

echo [r]ejoin game or [q]uit
choice /c rq /n
if %errorlevel% EQU 1 goto swipeset
if %errorlevel% EQU 2 goto reall

:hostselector
echo [r]ecreate game or [q]uit
choice /c rq /n
if %errorlevel% EQU 1 goto creategamemech
if %errorlevel% EQU 2 goto reall

:join
set owned=6
set opsign=x
set mysign=o

cls
echo Join To Game
echo -------------------------------
echo.
echo.
:fixswipe
set sdir=err
set /p "sdir=Swipe Path: "
if %sdir% == err goto fixswipe
if %sdir% == back goto reall

:swipeset

if not exist %sdir%locked.ttt (
echo Could not find an online game!
goto fixswipe
)

:foundgame
for /f "delims=" %%x in (%sdir%locked.ttt) do set resp=%%x
for /f "delims=" %%x in (%sdir%host.swipe) do set hosts=%%x
for /f "delims=" %%x in (%sdir%game.swipe) do set gstat=%%x
echo.
echo +-----------------------------+
echo  Found Game!
echo  Name: %resp%
echo  Host: %hosts%
echo  Status: %gstat%
echo +-----------------------------+


if not %gstat% == 1 (
echo --Cannot join!
goto fixswipe
)


echo Do you want to join [y/n]?
choice /c yn /n

if %errorlevel% == 1 goto joininit
if %errorlevel% == 2 goto reall
:joininit

echo %usrname% > %sdir%game.swipe

set nicebar=----------
:waitingforhost
cls
echo Waiting for Host!
echo !nicebar:~0,%random:~0,1%!
echo %time%
timeout /nobreak /t 1 >nul

for /f "delims=" %%x in (%sdir%game.swipe) do set resp=%%x

if not %resp% == 6 goto waitingforhost
set oponent=%hosts:~0,-1%

goto gameinit


:errex
color F0
echo Something went wrong :(
echo ------------------------------
echo.
echo.
echo ErrLv: %errorlevel%
echo sdir: %sdir%
echo namn: %namn%
echo resp: %resp%
echo usrname: %usrname%
echo oponent: %oponent%
echo owned: %owned%
echo carrylf: %carryfl%
echo opsign: %opsign%
echo mysign: %mysign%
echo gstat: %gstat%


echo.
echo.
pause>nul

:sui 
cls
echo.
echo +----------------------------+
echo  Bye Bye!
echo +----------------------------+
echo.
