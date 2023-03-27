#!/bin/bash

[[ $DEBUG == "1" ]] && env

nginx

/usr/bin/xvfb-run --auto-servernum --server-num=1 /usr/bin/spawn-fcgi -P /run/qgis.pid -p 9993 -n -d /home/qgis -- /usr/lib/cgi-bin/qgis_mapserv.fcgi
