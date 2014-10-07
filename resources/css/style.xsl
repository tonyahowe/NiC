<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:template match="TEI">
        <html>
            <head>
                <title>
                    <xsl:apply-templates select="/TEI/teiHeader/fileDesc/titleStmt"/>
                </title>
                <style type="text/css">
          body{
              font:15px georgia;
              line-height:180%;
              margin-top: 20px;
              margin-left: 20%;
              margin-right: 20%;
          }
          
        l {
          font: 15px; arial; <!-- the xslt doesn't seem to be putting <l>s around the <l>s! -->
          }
          
          blockquote {
          text-align:left !important;
          }
          
          opener:issue{
              text-align:right;
          }
          
          .pageImages{
          text-align:center;
          }
          
         div.titleInfo {
         width: 700px ;
         margin-left: auto ;
         margin-right: auto ;
         text-align:center;
         }
         
         .mainTitle{
              font-size:3em;
              line-height:1em;
              font-variant:small-caps;

          }
          
          
          .subTitle{
          font-size:2em;
          line-height:1em;
          font-variant:small-caps;
          
          }
          
          .author {
            font-size:2em;
            line-height:1em;

          }
          
          .pubDate {
            font-size:1.5em;
            line-height:1em;
            font-variant:small-caps;
            }
            
          .facsize{
              height:50%
              width:50%;
              text-align:center;
          }
          .facsital{
              font-style:italic;
          }
          .real{
              color:blue;
          }
          .sectionHeader{
              text-align:left;
              font-variant:small-caps;
              font-size:2em;
          }
        .realism {
           background: rgba(17,17,17,0.5);
        }
        
        .thesis {
        background: rgba(17,17,17,0.5);
        }
        
        .valueClaim {
        background: rgba(17,17,17,0.5);
        }
        
        .support {
        background: rgba(17,17,17,0.5);
        }
        
        .affect {
        background: rgba(17,17,17,0.5);
        }
        
        .imitation {
        background: rgba(17,17,17,0.5);
        }
        
        .idealism {
        background: rgba(17,17,17,0.5);
        }
        
        .purpose {
        background: rgba(17,17,17,0.5);
        }
        
        .religion {
        background: rgba(17,17,17,0.5);
        }
        
        .experience {
        background: rgba(17,17,17,0.5);
        }
        
        .romance {
        background: rgba(17,17,17,0.5);
        }
        
        .gothic {
        background: rgba(17,17,17,0.5);
        }
        
        .term {
        background: rgba(17,17,17,0.5);
        }
        
        .genre {
        background: rgba(17,17,17,0.5);
        }
        
        .youth {
        background: rgba(17,17,17,0.5);
        }
        
        .reference {
        background: rgba(17,17,17,0.5);
        }
        
        .quote {
        background: rgba(17,17,17,0.5);
        }
        
        .reason {
        background: rgba(17,17,17,0.5);
        }
        
        .probability {
        background: rgba(17,17,17,0.5);
        }
        
        .metaphor {
        background: rgba(17,17,17,0.5);
        }
        
        .character {
        background: rgba(17,17,17,0.5);
        }
        
        .science {
        background: rgba(17,17,17,0.5);
        }
        
        .reader {
        background: rgba(17,17,17,0.5);
        }
        
        .connection {
        background: rgba(17,17,17,0.5);
        }
        
        .education {
        background: rgba(17,17,17,0.5);
        }
        
        .distinction {
        background: rgba(17,17,17,0.5);
        }
        
        .gender {
        background: rgba(17,17,17,0.5);
        }
        
        .imagination {
        background: rgba(17,17,17,0.5);
        }
        
        .writing {
        background: rgba(17,17,17,0.5);
        }
        
        .economy {
        background: rgba(17,17,17,0.5);
        }
        
        .sociability {
        background: rgba(17,17,17,0.5);
        }
        
        .ease {
        background: rgba(17,17,17,0.5);
        }
        
        </style>
            </head>
            <body>
                <xsl:apply-templates select="/TEI/text/body"/>
        <!-- here, apply the templates to everything that matches, in the XML, the tag /body/ - could spit out only the opener, or only the floating text, or... -->
            </body>
        </html>
    </xsl:template>


  <!-- <xsl:template match="teiHeader"/> -->
  <!-- keeps teiHeader from displaying -->
    <xsl:template match="//titleStmt">
        <xsl:value-of select="*[@type='statusBar']"/>
    </xsl:template>
    <xsl:template match="*[@rend='mainTitle']">
        <span class="mainTitle">
            <xsl:apply-templates/>
      <!-- applying all templates to anything that matches inside this class, and spitting out anything as text that doesn't match. So, the linebreaks. -->
            <p/>
        </span>
    </xsl:template>
    <xsl:template match="*[@rend='subTitle']">
        <span class="subTitle">
            <xsl:apply-templates/>
      <!-- applying all templates to anything that matches inside this class, and spitting out anything as text that doesn't match. So, the linebreaks. -->
            <p/>
        </span>
    </xsl:template>
    <xsl:template match="*[@rend='sectionHeader']">
        <span class="sectionHeader">
            <xsl:apply-templates/>
      <!-- applying all templates to anything that matches inside this class, and spitting out anything as text that doesn't match. So, the linebreaks. -->
            <p/>
        </span>
    </xsl:template>
    <xsl:template match="div[@rend='titleInfo']/byline">
        <span class="author">
            <xsl:apply-templates/>
            <p/>
        </span>
    </xsl:template>
    <xsl:template match="div[@rend='titleInfo']/dateline">
        <span class="pubDate">
            <xsl:apply-templates/>
            <p/>
        </span>
    </xsl:template>
    <xsl:template match="*[@rend='italics']">
        <span class="facsital">
            <xsl:apply-templates/>
      <!-- applying all templates to anything that matches inside this class, and spitting out anything as text that doesn't match. So, the linebreaks. -->
        </span>
    </xsl:template>
    <xsl:template match="l">
    <!-- displays all <l>s -->
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    <xsl:template match="l[@real]">
        <span class="real">
            <xsl:apply-templates/>
        </span>
        <br/>
    </xsl:template>
    <xsl:template match="//div[@rend='pageImages']">
        <span class="pageImages">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//div[@rend='titleInfo']">
        <div class="titleInfo">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="lg">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="quote">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <xsl:template match="//div/epigraph">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
    <xsl:template match="//div/floatingText">
        <blockquote>
            <xsl:apply-templates/>
        </blockquote>
    </xsl:template>
  
<!-- image displays used -->
    <xsl:template match="//pb"> <!-- matches every pb element -->
        <xsl:element name="img"> <!-- creates an element img instead -->
            <xsl:attribute name="src">file:/C:/Users/Tonya/Dropbox/DHOXSS%202013/NiC-not%20in%20use/<!-- creates an attribute src inside the img element -->
                <xsl:value-of select="@facs"/><!-- gives the src attribute a specific style  [source = value of facs] -->
            </xsl:attribute>
            <xsl:attribute name="class">facsize</xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//graphic">
    <!-- matches every graphic element -->
        <xsl:element name="img">
      <!-- outputs an img element instead -->
            <xsl:attribute name="src"><!-- outputs the src attribute inside the object -->file:/C:/Users/Tonya/Dropbox/DHOXSS%202013/NiC-not%20in%20use/<xsl:value-of select="@url"/><!-- gives the src attribute a specific style -->
            </xsl:attribute>
        </xsl:element>
        <p/>
    </xsl:template>
  
  
<!-- matches span elements typed as annotations and identifying themes of realism, styling as link with tooltip -->
    <xsl:template match="//span[@ana='editorial.xml#realism']">
    <!-- <a href="#" title="Realism"> -->
        <span class="realism">  <!-- or, instead of a, use span class="realism" to style as .realism -->
            <xsl:apply-templates/>
    <!-- </a> -->
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#valueClaim']">
        <span class="valueClaim">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#support']">
        <span class="support">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#affect']">
        <span class="affect">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#imitation']">
        <span class="imitation">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#idealism']">
        <span class="idealism">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#purpose']">
        <span class="purpose">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#religion']">
        <span class="religion">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#experience']">
        <span class="experience">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#romance']">
        <span class="romance">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#gothic']">
        <span class="gothic">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#term']">
        <span class="term">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#genre']">
        <span class="genre">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#youth']">
        <span class="youth">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#reference']">
        <span class="reference">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#quote']">
        <span class="quote">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#reason']">
        <span class="reason">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#probability']">
        <span class="probability">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#metaphor']">
        <span class="metaphor">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#character']">
        <span class="character">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#science']">
        <span class="science">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#reader']">
        <span class="reader">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#connection']">
        <span class="connection">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#education']">
        <span class="education">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#distinction']">
        <span class="distinction">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#gender']">
        <span class="gender">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#imagination']">
        <span class="imagination">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#writing']">
        <span class="writing">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#economy']">
        <span class="economy">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#sociability']">
        <span class="sociability">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//span[@ana='editorial.xml#ease']">
        <span class="ease">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="//closer">
        <hr/>
    <!-- other way to do this is to xsl:element name="hr" -->
        <h3 align="center">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>
</xsl:stylesheet>