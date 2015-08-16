xquery version "3.0";

declare namespace html="http://www.w3.org/1999/xhtml";
let $resource-name := 'Clara_Reeve'
let $url := concat('http://dbpedia.org/resource/',$resource-name)
let $request := <http:request href="{$url}" method="GET"/>
let $response := http:send-request($request)
let $head := $response[1]
let $body := $response[2]
return
    $body//html:span[@property="dbpedia-owl:abstract" and @xml:lang="en"]/string()
    