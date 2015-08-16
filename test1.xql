xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";

let $collection := '/db/apps/NiC/data'
let $all-documents := xmldb:get-child-resources($collection) 
 
return
        <all-documents> {
            collection ($collection)//tei:text
        }</all-documents>
