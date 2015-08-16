xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html5";
declare option output:media-type "text/html";

declare function tei2:front($front as element (tei:front)) {
    let $frontTitle := $front//tei:head
    let $epigraph := $front//tei:epigraph
    let $quote := $front//tei:quote
    let $bibl := $front//tei:bibl
    let $author := $front//tei:author
    
    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="main-text-frontmatter">
            <h3>{$frontTitle/text()}</h3>
            {
                console:log($epigraph),
                for $cit in $epigraph
                return
                    <blockquote>
                        {$quote/tei:l/text()}<br/>--
                            {
                                <a href="{$author/@link}" data-toggle="tooltip" title="{$author/@title}">{$author/text()}</a>
                            }
                    </blockquote>
            }
            </div>
};


declare function tei2:link($node as element()) {
  if ($node/@link ne '' and $node/@link castable as xs:anyURI) then 
    <a href="{$node/@link}" data-toggle="tooltip" title="{$node/@title}">{
      tei2:tei2html( $node/node() )
    }</a>
  else 
    tei2:tei2html( $node/node() )
};

declare function tei2:note($node as element()) {
    <span style="color:orange" href="{$node/@link}" data-toggle="tooltip" title="{$node/@title}"> {
        tei2:tei2html ( $node/node() )
    }</span>
}; 

declare function tei2:header($header as element(tei:teiHeader)) {
    let $titleStmt := $header//tei:titleStmt
    let $pubStmt := $header//tei:publicationStmt
    let $sourceDesc := $header//tei:sourceDesc
    let $authors := $header//tei:titleStmt/tei:author
    let $resps := $header//tei:respStmt
    let $imprints := $header//tei:sourceDesc/tei:imprint
    let $onlineImprints := $header//tei:sourceDesc/tei:imprint/tei:extent[@type="online"]
    let $publishers := $header//tei:sourceDesc/tei:imprint/tei:publisher

    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="text-header">
            <h1>{$titleStmt/tei:title/text()}</h1>
            <h1><small>By 
            {
                let $author-full-names :=
                    for $author in $authors
                    return
                        concat($author//tei:forename, ' ', $author//tei:surname)
                let $name-count := count($authors)
                return
                    if ($name-count le 2) then
                        string-join($author-full-names, ' and ')
                    else
                        concat(
                            string-join(
                                $author-full-names[position() = (1 to last() - 1)]
                                , 
                                ', '),
                            ', and ',
                            $author-full-names[last()]
                        )
            }
            </small></h1><p></p>
        
            { 
                for $n in $resps
                return
                    <li class="list-unstyled">{concat($n//$resps/tei:resp, ' by ', $n//$resps/tei:name)}</li>
            }
    </div>
};
 
let $collection := '/db/apps/NiC/data/'
let $all-documents := collection($collection)[tei:TEI] ! substring-after(base-uri(), '/db/apps/NiC/data')
let $selected-docs := request:get-parameter('selected', ())
let $documents-to-show := if (exists($selected-docs)) then $all-documents[. = $selected-docs] else $all-documents

return
    <div>
        <form action = "items2.xq" method="GET">{
            $all-documents ! <input type="checkbox" name="selected" value="{.}">{if (.=$selected-docs) then attribute checked {"checked"} else ()}{.}</input>,
            <input type="submit" value="submit"/>
        }</form>
        {
            if (exists($selected-docs)) then 
                for $selected in $selected-docs
                return
                    typeswitch ($node)
                        case text() return
                            $node
                        case element(tei:TEI) return
                            tei2:tei2html($node/*)
                        case element(tei:teiHeader) return
                            tei2:header($node) 
                        case element(tei:lg) return
                            <lg>{ tei2:tei2html($node/node()) }</lg>
                        case element(tei:l) return
                            <l>{ tei2:tei2html($node/node()) }</l>
                        case element(tei:i) return
                            <i>{ tei2:tei2html($node/node()) }</i>
                        case element(tei:front) return
                            tei2:front($node)
                        case element(tei:rs) return 
                            tei2:link($node)
                        case element(tei:quote) return 
                            tei2:link($node)
                        case element(tei:note) return
                           tei2:note($node) 
                        case element(tei:p) return
                            <p xmlns="http://www.w3.org/1999/xhtml" id="{tei2:get-id($node)}">{ tei2:tei2html($node/node()) }</p> (: THIS IS WHERE THE ANCHORS ARE INSERTED! :)
                        case element(exist:match) return
                            <mark xmlns="http://www.w3.org/1999/xhtml">{ $node/node() }</mark>
                        case element() return
                            tei2:tei2html($node/node())
                        default return
                            $node/string() 
                else ()
        }
    </div>
   
