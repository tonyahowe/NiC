xquery version "1.0";

declare variable $exist:path external;
declare variable $exist:resource external;
declare variable $exist:controller external;

if ($exist:path eq "/") then
    (: forward root path to index.xql :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="works/"/>
    </dispatch>

else if ($exist:resource = ("search.html", "demo-queries.html", "search-help.html", "about-NiC.html")) then
    (: the html page is run through view.xql to expand templates :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/{$exist:resource}">
            <set-header name="Cache-Control" value="no-cache"/>
        </forward>
        <view>
            <forward url="{$exist:controller}/modules/view.xql"/>
        </view>
        <error-handler>
            <forward url="{$exist:controller}/error-page.html" method="get"/>
            <forward url="{$exist:controller}/modules/view.xql"/>
        </error-handler>
    </dispatch>

else if (contains($exist:path, "/$shared/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="/shared-resources/{substring-after($exist:path, '/$shared/')}">
            <!--set-header name="Cache-Control" value="max-age=3600, must-revalidate"/-->
        </forward>
    </dispatch>

(: Requests for javascript libraries are resolved to the file system :)
else if (contains($exist:path, "/resources/")) then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <forward url="{$exist:controller}/resources/{substring-after($exist:path, '/resources/')}"/>
    </dispatch>

else if (contains($exist:path, "/headnotes/")) then
    let $id := replace($exist:resource, "^(.*)\.\w+$", "$1")
    let $html := "view-headnote.html"
    return   
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/{$html}">
                </forward>
                <view>
                    <forward url="{$exist:controller}/modules/view.xql">
                        <add-parameter name="id" value="{$id}"/>
                    </forward>
                </view>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
            
else if (starts-with($exist:path, "/works/")) then
    let $id := replace($exist:resource, "^(.*)\.\w+$", "$1")
    let $html :=
        if ($exist:resource = "") then
            "index.html"
        else
            "view-text.html"
(:        else if (ends-with($exist:resource, ".html")) then:)
(:            "view-play.html":)
(:        else:)
(:            "view-work.html":)
    return
        if (ends-with($exist:resource, ".epub")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/get-epub.xql">
                    <add-parameter name="id" value="{$id}"/>
                </forward>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
        else if (ends-with($exist:resource, ".pdf")) then
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/modules/tei2fo.xql">
                    <add-parameter name="id" value="{$id}"/>
                </forward>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
        else
            <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
                <forward url="{$exist:controller}/{$html}">
                </forward>
                <view>
                    <forward url="{$exist:controller}/modules/view.xql">
                        <add-parameter name="id" value="{$id}"/>
                    </forward>
                </view>
                <error-handler>
                    <forward url="{$exist:controller}/error-page.html" method="get"/>
                    <forward url="{$exist:controller}/modules/view.xql"/>
                </error-handler>
            </dispatch>
    
else
    (: everything else is passed through :)
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <cache-control cache="yes"/>
    </dispatch>