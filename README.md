NiC
===

An eXist app that makes accessible a curated and edited collection of primary resources for teaching the eighteenth-century novel in English

<h2>Things I Want to Do (In No Particular Order)</h2>

<ul>
<li><del>Add live link functionality to tei:imprint/extent[@type='online']<del>
<li><del>Added iteration for multiple XML contributors</del>
<li><del>Correct live linking to title in search results</del>
<li><del>Correct live linking to query term in search results</del>
<li><del>Typeswitch case <exist:match> in tei2html.xql doesn't return <mark> tags</del>
<li><del>Add facsimile page images (sample images available in /images)</del>
<li><del>Refine page image display - page images embedded in hays.xml -- see notes on page images below</del>
<li><del>Correct the branching path for selecting either view-play.html or view-work.html to default to one -- see note below</del>
<li>Add new kinds of xml files, linked to sample xml files currently in /data--for instance, headnotes and reading/study questions
<li>Why isn't the About link working as expected? I.e., like the Search Help link?
<li>Add user functionality for uploading and/or sub-collection creation
<li>Define a workflow to curate user contributions
<li>Enable users to select records from among all the data sources for inclusion into a pdf or a subcollection
<li>Generate a TOC and pagination for the resulting pdf
<li>Refine xml structure and create a style guide for user contributions
<li>Add topic model and graphing functionality
<li>Searching: what happens with hits in the epigraph? 
<li>How best to mark up topics in the xml? How can they be searched, or displayed? 
</ul>

<h2>Thoughts on App Structure</h2>

In the Shakespeare app, view-play.html or view-work.html are different, depending on the needs of the data. My app currently has no need of a distinction here, so I want to make view-work.html the default. This seems to be configured both in controller.xql and in app:work-title, but I think I may need help here. 

<h2>Thoughts on Page Images</h2>

<ol>
<li>How to display the page images? 
  <ul><li>I want to keep the <pb> elements inline with the xml. However, it may be more elegant to display them in a side bar or a footer, so as not to interrupt the flow of reading (see note 2).
  <li>The page images should be thumbnailed, and onclick show a high-res or at least full-size image. 
  <li>How to automate this? Count the <pb> elements, add on -00.png, -01.png, -02.png and so forth, depending on the <pb> count? Automation here is probably also determined by where the images are located. I don't want them to be stored in the regular data folder--or do I? How do I associate the xml with the page images? In the doc-types file, or in naming conventions? Would like some help with this. </ul>
<li>What if the application evolves to take not only textual excerpts with facsimile images, but also images themselves, like paintings or photographs of material objects? 
  <ul><li>Issues of focus and purpose emerge. Currently, the textual transcription and markup is the primary focus, with the page images functioning as secondary visual resources. </ul>
</ol>

<h2>Thoughts on Searching</h2>

<ol>
<li>Need to ensure everything that should be searched is searched.
  <ul><li>Epigraph hits should be returned--are they? With recent changes, teiHeader hits are no longer returned, which is good.
  <li>Definitely want to enable search for topics, or strings within xml marked by topic (searching, definitely; search within may be less useful)--but perhaps this is best reserved for the topic-model module?
  <li>A precursor step would be to display a topic list in each xml file.</ul>
</ol>
