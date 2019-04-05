xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare function local:func() as xs:string {
    if(fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('EnvironmentName'),'select VALUE from ESB_DEPLOYMENT_CONFIG WHERE KEY=?',fn-bea:getHostname())//text())then
    fn-bea:execute-sql('jdbc/ESBDevDB',xs:QName('EnvironmentName'),'select VALUE from ESB_DEPLOYMENT_CONFIG WHERE KEY=?',fn-bea:getHostname())//text()
    else
    fn:substring-before(fn-bea:getHostname(),".")
};

local:func()
