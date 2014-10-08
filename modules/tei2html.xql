module namespace tei2="http://exist-db.org/xquery/app/tei2html";
import module namespace console="http://exist-db.org/xquery/console";

declare namespace tei="http://www.tei-c.org/ns/1.0";

declare function tei2:tei2html($nodes as node()*) {
    for $node in $nodes
    return
        typeswitch ($node)
            case text() return
                $node
            case element(tei:TEI) return
                tei2:tei2html($node/*)
            case element(tei:teiHeader) return
                tei2:header($node) 
            case element(tei:front) return
                tei2:front($node)
            case element(tei:body) return 
                tei2:body($node) 
            case element(tei:p) return
                <p xmlns="http://www.w3.org/1999/xhtml">{$node}</p> 
            case element() return
                tei2:tei2html($node/node())
            default return
                $node/string() (: what would this catch? comment node in the xml? :)
};

declare function tei2:header($header as element(tei:teiHeader)) {
    let $titleStmt := $header//tei:titleStmt
    let $pubStmt := $header//tei:publicationStmt
    let $sourceDesc := $header//tei:sourceDesc
    let $authors := $header//tei:titleStmt/tei:author
    let $imprints := $header//tei:sourceDesc/tei:imprint
    let $onlineImprint := $header//tei:sourceDesc/tei:imprint/tei:extent[@type="online"]
    let $publishers := $header//tei:sourceDesc/tei:imprint/tei:publisher

  (: link issue: works, but don't want it to display with @type=physical extent. need an or operator? or something else? :)
    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="text-header">
            <h1>{$titleStmt/tei:title/text()}</h1>
            <h2>By 
            {
                let $author-full-names :=
                    for $author in $authors
                    return
                        concat($author/tei:forename, ' ', $author/tei:surname)
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
            </h2>
            
            {
                for $resp in $titleStmt/tei:respStmt
                return
                    <p>{$resp/tei:resp/text()}: {$resp/tei:name/text()} </p>
            }
            
            {
                for $onlineImprint in $imprints
                return <a href="{$publishers/tei:extent/text()}">{$publishers/tei:extent/text()}</a>
            }
</div>
};

declare function tei2:front($front as element (tei:front)) {
    let $frontTitle := $front//tei:head
    let $epigraph := $front//tei:epigraph
    let $quote := $front//tei:quote
    let $bibl := $front//tei:bibl
    
    return
        <div xmlns="http://www.w3.org/1999/xhtml" class="main-text-frontmatter">
            <h3>{$frontTitle/text()}</h3>
            {
                console:log($epigraph),
                for $cit in $epigraph
                return
                    <blockquote>{$quote/tei:l/text()}<br/>--{$bibl/text()}</blockquote>
            }
            </div>
};
    
declare function tei2:body($body as element (tei:body)) {
    let $para := $body//tei:p
    
    return 
        $para
};

declare function tei2:themes($work as element(tei:TEI)) {
    let $theme := $work//tei:span/@type="ana" 
    return
        console:log($theme),
        for $theme in $work
            return 
                $theme/text()
};


declare %private function tei2:get-id($node as element()) {
    ($node/@xml:id, $node/@exist:id)[1]
};