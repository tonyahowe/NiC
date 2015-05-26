xquery version "3.0";

declare namespace tei="http://www.tei-c.org/ns/1.0";

import module namespace app="http://exist-db.org/apps/" at "/db/apps/NiC/modules/app.xql";

let $work := doc('/db/apps/NiC/data/barbauld.xml')/tei:TEI
return 
    app:work-title($work)