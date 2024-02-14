export JMETER_HOME=apache-jmeter-5.6.2
export PATH=$JMETER_HOME/bin:$PATH
jmeter -n -t  $WORKSPACE/jpetstore_configurable_host.jmx -l reportejenkins.jtl -e -o dashboard
