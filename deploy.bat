@echo off
setlocal

rem Spec\ify the paths
set "projectName=LightItUp-1.0"
set "projectFilePath=D:\E\5th sem\MIS project LightItUp\LighItUp\target\%projectName%"
set "warFilePath=D:\E\5th sem\MIS project LightItUp\LighItUp\target\%projectName%.war"
set "webappsDir=D:\tomcat10\webapps"

rem Stop Tomcat 
net stop Tomcat10

rem Delete the old exploded directory
rem rmdir /S /Q "%webappsDir%\%projectName%"

rem Copy entire updated directory
rem xcopy /Y /E "%projectFilePath%" "%webappsDir%\%projectName%"

rem Delete old war file
del /Q "%webappsDir%\%projectName%.war"

rem Copy the updated WAR file
copy /Y "%warFilePath%" "%webappsDir%\"


rem Start Tomcat
net start Tomcat10

echo Deployment completed.