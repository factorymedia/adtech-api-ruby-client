require 'java'

java_import java.lang.System
System.setProperty('http.nonProxyHosts', '')
$CLASSPATH << 'lib/adtech/HeliosWSClientSystem'
$CLASSPATH << 'lib/adtech/HeliosWSClientSystem/lib'

require 'lib/adtech/HeliosWSClientSystem/HeliosWSClientSystem'
require 'adtech/client'
require 'adtech/api/report'
