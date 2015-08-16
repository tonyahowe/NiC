xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html5";
declare option output:media-type "text/html";


let $collection := '/db/apps/NiC/data/'
let $all-documents := collection($collection)[tei:TEI] ! substring-after(base-uri(), '/db/apps/NiC/data')
let $selected-docs := request:get-parameter('selected', ())
let $documents-to-show := if (exists($selected-docs)) then $all-documents[. = $selected-docs] else $all-documents

return
    <div>
        <form action = "items.xq" method="GET">{
            $all-documents ! <input type="checkbox" name="selected" value="{.}">{if (.=$selected-docs) then attribute checked {"checked"} else ()}{.}</input>,
            <input type="submit" value="submit"/>
        }</form>
        {
            if (exists($selected-docs)) then 
                for $selected in $selected-docs
                return
                    <h1>{doc(concat($collection, $selected))//tei:title[1]/string()}</h1>
                else ()
        }
    </div>
   
