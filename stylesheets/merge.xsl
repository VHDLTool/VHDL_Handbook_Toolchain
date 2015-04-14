<!-- ///////////////////////////////////////////////////////////////////// -->
<!-- Authors : F.JUGE (Altran Ouest), B.CORVE (Altran Ouest)               -->
<!-- Mail : florian.juge@altran.com, baptiste.corve@altran.com             -->
<!-- version 0 : 2014/10/06 : F.JUGE : creation                            -->
<!-- version 1 : 2014/12/05 : B.CORVE : completion of template for keep    -->
<!--                          RuleSetHist of intput file only    		   -->
<!-- ///////////////////////////////////////////////////////////////////// -->
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hb="HANDBOOK"
	xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="hb ../src/XSD/handbook.xsd ">
	
	<!-- Parameters defined by apache ant -->
	<xsl:param name="RuleSet_folder">parameter given by apache ant</xsl:param>
	
	<xsl:output indent="no" method="xml" />

   	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
		
	</xsl:template>
 
 	<xsl:template match="hb:Rule"/> <!-- Delete all rules present in Input_File because these rules are copied in next template -->
 
	<xsl:template match="hb:RuleSetHist"> <!-- RuleSetHist because in Input_File, this node have to be present, and only one time -->
		<xsl:comment>Rules added from ../src/RuleSets with merge.xsl</xsl:comment>
		
		<xsl:copy-of select="collection(concat($RuleSet_folder,'?select=*.xml;recurse=yes'))/*/hb:Rule" /> <!-- recurse means that sub-directories will also be included -->
		
		<xsl:copy-of select="." /> <!-- Copy of Input_File RuleSetHist -->
	</xsl:template> 
</xsl:stylesheet>