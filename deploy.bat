@echo off
setlocal

rem Specify the paths
set "projectName=LightItUp-1.0"
set "projectFilePath=D:\E\5th sem\MIS project LightItUp\LightItUp\target\%projectName%"
set "warFilePath=D:\E\5th sem\MIS project LightItUp\LightItUp\target\%projectName%.war"
set "webappsDir=D:\tomcat10\webapps"

rem Stop Tomcat 
net stop Tomcat10

rem Delete old war file
del /Q "%webappsDir%\%projectName%.war"

rem Delete the old exploded directory
rmdir /S /Q "%webappsDir%\%projectName%"

rem Copy entire updated directory
xcopy /Y /E "%projectFilePath%" "%webappsDir%\%projectName%"

rem Copy the updated WAR file
copy /Y "%warFilePath%" "%webappsDir%\"

rem Start Tomcat
net start Tomcat10

echo Deployment completed.
pause
