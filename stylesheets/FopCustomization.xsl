<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:fo="http://www.w3.org/1999/XSL/Format"
				xmlns:d="http://docbook.org/ns/docbook"
				xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
				xsi:schemaLocation="hb ../output/work/XSD/handbook.xsd">

	<xsl:import href="../stylesheets/docbook/fo/docbook.xsl" />

	<xsl:param name="chapter.autolabel" select="0"/> <!-- HANDBOOK -->
	<xsl:param name="section.autolabel" select="1"/><!-- handbook : default value is 0 -->
	<xsl:param name="section.autolabel.max.depth">2</xsl:param><!-- ALTRAN : handbook : default value is 8 -->
	<xsl:param name="section.label.includes.component.label" select="A"/> <!-- handbook : default value is 0 -->
	<!-- from fo/param.xsl customization -->
	<xsl:attribute-set name="monospace.verbatim.properties" use-attribute-sets="verbatim.properties monospace.properties">
  		<xsl:attribute name="wrap-option">wrap</xsl:attribute> <!-- handbook: ddefault value is "no-wrap"-->
  		<!-- handbook following lines have been added -->
  		<xsl:attribute name="font-size">0.80em</xsl:attribute>
    	<xsl:attribute name="border-top">0.5pt solid black</xsl:attribute>
  		<xsl:attribute name="border-bottom">0.5pt solid black</xsl:attribute>
      	<xsl:attribute name="border-left">0.5pt solid black</xsl:attribute>
  		<xsl:attribute name="border-right">0.5pt solid black</xsl:attribute>
  		<xsl:attribute name="background-color">#EEEEEE</xsl:attribute>
  		<!-- END OF handbook following lines have been added -->
	</xsl:attribute-set>
	<xsl:param name="page.margin.inner">
  	<xsl:choose>
    	<xsl:when test="$double.sided != 0">0.75in</xsl:when>
    		<!-- handbook <xsl:otherwise>1in</xsl:otherwise>-->
    		<xsl:otherwise>0.6in</xsl:otherwise>
  		</xsl:choose>
	</xsl:param>
	<xsl:param name="toc.max.depth">8</xsl:param>
	<xsl:param name="toc.section.depth">4</xsl:param><!-- ALTRAN : handbook : default value is 2 -->
	<xsl:param name="highlight.source" select="1"/> <!-- HANDBOOK : default value is 0 -->
	<xsl:attribute-set name="section.title.properties">
		<!-- handbook : following lines have been added -->
  	  	<xsl:attribute name="color">blue</xsl:attribute>
  		<xsl:attribute name="padding-top">6pt</xsl:attribute>
  		<xsl:attribute name="padding-bottom">3pt</xsl:attribute>
  		<!-- /handbook -->
	</xsl:attribute-set>
	<xsl:attribute-set name="table.properties" use-attribute-sets="formal.object.properties">
  		<!-- handbook -->
  		<xsl:attribute name="keep-together.within-page">always</xsl:attribute>
  		<!-- end of handbook -->
	</xsl:attribute-set>
	
	
	
	<!-- From fo/component.xsl customization -->
	<xsl:attribute-set name ="component.title.properties">
		<xsl:attribute name="color">blue</xsl:attribute>
	</xsl:attribute-set>

	
	
	<!-- From fo/docbook.xsl -->
	<xsl:template match="processing-instruction('linebreak')" priority="9">
  		<fo:block/>
	</xsl:template>
	<xsl:template match="processing-instruction('hard-pagebreak')" priority="9">
  		<fo:block break-after='page'/>
	</xsl:template>


	<!-- From fo/pagesetup.xsl -->
	<!-- Header -->
	<xsl:template name="header.content">
  		<xsl:param name="pageclass" select="''"/>
  		<xsl:param name="sequence" select="''"/>
  		<xsl:param name="position" select="''"/>
  		<xsl:param name="gentext-key" select="''"/>

  		<fo:block>
    		<!-- sequence can be odd, even, first, blank -->
    		<!-- position can be left, center, right -->
    		<xsl:choose>
      			<xsl:when test="$sequence = 'blank'">
    	    		<!-- nothing -->
	      		</xsl:when>

      			<xsl:when test="$position='center'">
        		<!-- Same for odd, even, first, and blank sequences -->
        		<!-- ALTRAN : HANDBOOK : add book title in center of header -->
 					<xsl:value-of select="ancestor-or-self::d:book/d:bookinfo/d:title"></xsl:value-of> 
      			</xsl:when>

			    <xsl:when test="$position='right'">
      				<!-- Same for odd, even and first sequences -->
        			<!-- ALTRAN : HANDBOOK : add book build date in right of header -->
        			<xsl:value-of select="ancestor-or-self::d:book/d:bookinfo/d:revhistory/d:revision/d:date"></xsl:value-of> 
      			</xsl:when>

      			<xsl:when test="$position='left'">
        			<!-- Same for odd, even and first sequences -->
        			<!-- ALTRAN : HANDBOOK : add book version in left of header -->
        			Version <xsl:value-of select="ancestor-or-self::d:book/d:bookinfo/d:revhistory/d:revision/d:revremark"></xsl:value-of> 
      			</xsl:when>

    		</xsl:choose>
  		</fo:block>
	</xsl:template>

	<!--  Footer -->
	<xsl:template name="footer.content">
	  	<xsl:param name="pageclass" select="''"/>
	  	<xsl:param name="sequence" select="''"/>
	  	<xsl:param name="position" select="''"/>
	  	<xsl:param name="gentext-key" select="''"/>
	
	
		<fo:block>
			<!-- pageclass can be front, body, back -->
			<!-- sequence can be odd, even, first, blank -->
			<!-- position can be left, center, right -->
	 		<xsl:choose>
	 			<xsl:when test="$sequence = 'blank'">
	 				<!-- nothing to do -->
				</xsl:when>
				<!-- Second page of titlepage -->
				<xsl:when test="$pageclass = 'titlepage' and $sequence = 'odd' and $position = 'right'">
					Page <fo:page-number/>
				</xsl:when>
				<xsl:when test="$pageclass = 'titlepage' and $sequence = 'odd' and $position = 'left'">
					Release Notes
				</xsl:when>
				<!-- pages of TOC -->
	   			<xsl:when test="$pageclass = 'lot' and $position = 'right'">
	   					Page <fo:page-number/>
	   			</xsl:when>
	   			<xsl:when test="$pageclass = 'lot' and $position = 'left'">
	   				Table of Contents
	   			</xsl:when>
	   	
				<!-- pages of Body -->
				<xsl:when test="$pageclass = 'body' and $position = 'right'">
					Page <fo:page-number/>
				</xsl:when>
				<xsl:when test="$pageclass = 'body' and $position = 'left' and $sequence = 'first'"><!-- For fisrt page of chapter -->
					<xsl:apply-templates select="." mode="titleabbrev.markup"/>
				</xsl:when>
				<xsl:when test="$pageclass = 'body' and $position = 'left'"><!-- For other pages of chapter -->
					<xsl:apply-templates select="." mode="titleabbrev.markup"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- nothing to do -->
	   			</xsl:otherwise>
	   		</xsl:choose>
		</fo:block>
	</xsl:template>


	<!-- From fo/table.xsl -->
<xsl:template name="table.row.properties">
<!-- HANDBOOK -->
    <xsl:if test="ancestor::d:thead">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="background-color">#EEEEEE</xsl:attribute><!-- grey -->
    </xsl:if>
<!-- END HANDBOOK -->
  <xsl:variable name="row-height">
    <xsl:if test="processing-instruction('dbfo')">
      <xsl:call-template name="pi.dbfo_row-height"/>
    </xsl:if>
  </xsl:variable>

  <xsl:if test="$row-height != ''">
    <xsl:attribute name="block-progression-dimension">
      <xsl:value-of select="$row-height"/>
    </xsl:attribute>
  </xsl:if>

  <xsl:variable name="bgcolor">
    <xsl:call-template name="pi.dbfo_bgcolor"/>
  </xsl:variable>

  <xsl:if test="$bgcolor != ''">
    <xsl:attribute name="background-color">
      <xsl:value-of select="$bgcolor"/>
    </xsl:attribute>
  </xsl:if>

  <!-- Keep header row with next row -->
  <xsl:if test="ancestor::d:thead">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:if>

</xsl:template>


	<xsl:attribute-set name="verbatim.properties">
  		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  		<xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
  		<xsl:attribute name="hyphenate">false</xsl:attribute>
  		<xsl:attribute name="wrap-option">wrap</xsl:attribute> <!-- HANDBOOK : default value is "no-wrap" -->
  		<xsl:attribute name="white-space-collapse">false</xsl:attribute>
  		<xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
  		<xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  		<xsl:attribute name="text-align">justify</xsl:attribute> <!-- HANDBOOK : default value is "start" -->
	</xsl:attribute-set>
</xsl:stylesheet>