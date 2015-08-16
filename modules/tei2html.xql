module namespace tei2="http://exist-db.org/xquery/app/tei2html";
import module namespace console="http://exist-db.org/xquery/console";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function tei2:tei2html($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case document-node() return
                tei2:tei2html($node/*)
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

  (: link issue: works, but don't want it to display with @type=physical extent. need an or operator? or something else? :)
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
    
declare %private function tei2:get-id($node as element()) {
    ($node/@xml:id, $node/@exist:id)[1]
};