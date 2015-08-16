xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";
import module namespace tei2="http://exist-db.org/xquery/app/tei2html" at "/db/apps/NiC/modules/tei2html.xql";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "html5";
declare option output:media-type "text/html";
import module namespace console="http://exist-db.org/xquery/console";


let $collection := '/db/apps/NiC/data/'
let $all-documents := collection($collection)[tei:TEI] ! substring-after(base-uri(), '/db/apps/NiC/data')
let $selected-docs := request:get-parameter('selected', ())
let $documents-to-show := if (exists($selected-docs)) then $all-documents[. = $selected-docs] else $all-documents

return
    
    <div>
        <form action = "items3.xq" method="GET">{
            $all-documents ! <input type="checkbox" name="selected" value="{.}">{if (.=$selected-docs) then attribute checked {"checked"} else ()}{.}</input>,
            <input type="submit" value="submit"/>
        }</form>
        {
            if (exists($selected-docs)) then 
                for $selected in $selected-docs
                return
                    tei2:tei2html(doc(concat($collection, $selected))/tei:TEI)
                else ()
        }
    </div>
   
