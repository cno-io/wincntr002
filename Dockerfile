# This dockerfile utilizes components licensed by their respective owners/authors.
# Prior to utilizing this file or resulting images please review the respective licenses at: http://www.apache.org/licenses/, https://secure.php.net/license/

FROM mcr.microsoft.com/windows/servercore:ltsc2019

LABEL Description="Apache-PHP" Vendor1="Apache Software Foundation" Version1="2.4.38" Vendor2="The PHP Group" Version2="5.6.40"

ADD apache.zip /

RUN powershell -Command Expand-Archive -Path c:\\apache.zip -DestinationPath c:\\ ;

RUN powershell -Command Remove-Item c:\\apache.zip -Force ;

ADD vcredist_x86.exe /

RUN powershell -Command start-Process c:\\vcredist_x86.exe -ArgumentList '/quiet' -Wait ;

RUN powershell -Command Remove-Item c:\\vcredist_x86.exe -Force ;

ADD php.zip /

RUN powershell -Command Expand-Archive -Path c:\\php.zip -DestinationPath c:\\php ;

RUN powershell -Command Remove-Item c:\\php.zip -Force ;

RUN powershell -Command \
	$ErrorActionPreference = 'Stop'; \
	Remove-Item c:\Apache24\conf\httpd.conf ; \
	new-item -Type Directory c:\www -Force ; \
	Add-Content -Value "'<?php phpinfo() ?>'" -Path c:\www\index.php

ADD httpd.conf /apache24/conf

ADD info.php /www/

ADD debug.php /www/

ADD flag.txt /www/

WORKDIR /Apache24/bin

CMD /Apache24/bin/httpd.exe -w