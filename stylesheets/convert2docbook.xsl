<!-- ///////////////////////////////////////////////////////////////////// -->
<!-- Authors : F.JUGE (Altran Ouest), B.CORVE (Altran Ouest)               -->
<!-- Mail : florian.juge@altran.com, baptiste.corve@altran.com             -->
<!-- version 0 : 2014/10/06 : F.JUGE : creation                            -->
<!-- version 1 : 2014/12/05 : B.CORVE : add selected item choice 		   -->
<!-- version 2 : 2015/02/10 : B.CORVE : add book info and change article   -->
<!-- 						  to book 									   -->
<!-- ///////////////////////////////////////////////////////////////////// -->

<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hb="HANDBOOK"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:d="http://docbook.org/ns/docbook"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="hb ../output/work/XSD/handbook.xsd">

   <xsl:import href="../stylesheets/docbook/fo/docbook.xsl" />
	<xsl:import href="../stylesheets/docbook/fo/highlight.xsl" />

	<xsl:key name="cat" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:Category" />
	<xsl:key name="subcat" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:SubCategory" />
   <xsl:key name="parent_uid" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:ParentUID" /> 
   <xsl:key name="uid" match="hb:RuleSet/hb:Rule" use="hb:RuleUID" /> 
   <xsl:key name="son" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:IsSon" />  
	
	<!-- Parameters defined by apache ant -->
	<xsl:param name="VHDL_folder">parameter given by apache ant</xsl:param>
	<xsl:param name="Text_folder">parameter given by apache ant</xsl:param>
	<xsl:param name="Images_folder">parameter given by apache ant</xsl:param>
	<xsl:param name="Standart_to_pdf">parameter given by apache ant</xsl:param>
	<xsl:param name="Custom_to_pdf">parameter given by apache ant</xsl:param>
	<xsl:param name="Subtitle">parameter given by apache ant</xsl:param>
	<xsl:param name="VHDL_tag">parameter given by apache ant</xsl:param>
	<xsl:param name="Sonarqube_enabled">parameter given by apache ant</xsl:param>

	<xsl:output indent="yes" method="xml" />




	<!-- ====================================================================== -->
	<!-- Root Template -->
	<!-- ====================================================================== -->
	<xsl:template match="/"> 
		
		<book xmlns='http://docbook.org/ns/docbook'>
		
			<bookinfo>
				<!-- For title page -->
				<title>DESIGN AND VHDL HANDBOOK FOR VLSI DEVELOPMENT</title>
				<subtitle><xsl:value-of select="$Subtitle" /></subtitle>
				<legalnotice></legalnotice>
      			<releaseinfo><d:literallayout><xsl:value-of select="unparsed-text(concat($Text_folder, 'releaseInfo.txt'), 'iso-8859-1')"/> Version <xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Version" /> - <xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Modified" /></d:literallayout></releaseinfo>
      			<!-- For headers -->
				<revhistory>
					<revision>
						<date><xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Modified" /></date>
						<revremark><xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Version" /></revremark>
					</revision>
				</revhistory> 
				<author> </author><!-- to space title of header -->
	
				<!-- If there are many mediaobject, they will be displayed one after one in descending on titlepage -->
				<!--  
   				<mediaobject>
          			<imageobject>
 						<xsl:element name="d:imagedata">
							<xsl:attribute name="fileref">
								<xsl:value-of select="concat($Images_folder, 'logoCNES.png')" /> 
							</xsl:attribute>
						</xsl:element>
          			</imageobject>
      			</mediaobject> -->
      	
			</bookinfo>
			
			
			<chapter>   
				<d:title>INTRODUCTION</d:title>
				<d:literallayout><xsl:value-of select="unparsed-text(concat($Text_folder, 'introduction.txt'), 'iso-8859-1')"/></d:literallayout>
			</chapter>
			
			<chapter>
				<d:title>GLOSSARY</d:title>
				<d:literallayout><xsl:value-of select="unparsed-text(concat($Text_folder, 'glossary.txt'), 'iso-8859-1')"/></d:literallayout>
			</chapter>
         	
			<chapter>
				<d:title>VERSION HISTORY</d:title>
				<xsl:call-template name="History"/>
			</chapter>
			
			
			<xsl:if test="$Standart_to_pdf='true'">
				<chapter>
					<d:title>STANDARD RULES</d:title>
            		<xsl:call-template name="section2">
						<xsl:with-param name="sect2_rule">STANDARD</xsl:with-param>
            		</xsl:call-template>
				</chapter>
         	</xsl:if>

			<xsl:if test="$Custom_to_pdf='true'">
				<chapter>
					<d:title>CUSTOM RULES</d:title>
            		<xsl:call-template name="section2">
               			<xsl:with-param name="sect2_rule">CUSTOM</xsl:with-param>
           			</xsl:call-template>
				</chapter>
         	</xsl:if>

		</book>

	</xsl:template>
	
	
	
	<xsl:template name="section2">
		<xsl:param name="sect2_rule">RULE</xsl:param>

		<xsl:choose>
	<!-- ////////////////////////////  STANDARD   /////////////////////////////////////////////////////////  -->
			<xsl:when test="$sect2_rule='STANDARD'">                                 
   				<xsl:call-template name="checkCategory_STD">                                               
					<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
				</xsl:call-template>                                                                                   
                <xsl:call-template name="checkCategory_STD">                                                 
					<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                   
				</xsl:call-template>                                                          
				<xsl:call-template name="checkCategory_STD">                                                 
					<xsl:with-param name="CatToCheck">Design</xsl:with-param>                            
				</xsl:call-template>                                                                            
				<xsl:call-template name="checkCategory_STD">                                                
					<xsl:with-param name="CatToCheck">Simulation</xsl:with-param>                       
				</xsl:call-template>    
			</xsl:when>
	<!-- //////////////////////////////  CUSTOM   /////////////////////////////////////////////////////////  -->
			<xsl:when test="$sect2_rule='CUSTOM'">                                             
				<xsl:call-template name="checkCategory_CUST">                                                            
					<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
				</xsl:call-template>                                                         
				<xsl:call-template name="checkCategory_CUST">                                                  
					<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                  
				</xsl:call-template>                                                    
				<xsl:call-template name="checkCategory_CUST">                                                 
					<xsl:with-param name="CatToCheck">Design</xsl:with-param>            
				</xsl:call-template>                                                          
				<xsl:call-template name="checkCategory_CUST">                                                 
					<xsl:with-param name="CatToCheck">Simulation</xsl:with-param>                     
				</xsl:call-template>       
			</xsl:when>
            <xsl:otherwise>
				<xsl:text>no rule are coming !!!!</xsl:text>
            </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  checkCategory_STD  ////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          Check if empty Category for STD   /////////////////////////  -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->	
	<xsl:template name="checkCategory_STD">
		<xsl:param name="CatToCheck">CAT</xsl:param>
   
   	<!-- Initialize variable with true if category is not empty for STD -->
   		<xsl:variable name="TRUE" >true</xsl:variable>
        <xsl:variable name="CatNoEmpty" >
      	  <xsl:for-each select="key('cat', $CatToCheck)">
        		<xsl:choose>
					<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')">
						<xsl:choose>
							<xsl:when test="hb:RuleHist/hb:Status/text()='Deleted'">
          		              	<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:when test="hb:RuleHist/hb:Status/text()='Rejected'">
								<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>true</xsl:text>
							</xsl:otherwise>
            	    	</xsl:choose>	
					</xsl:when>
					<xsl:otherwise>
            	    	<xsl:text>false</xsl:text>
            	    </xsl:otherwise>	
				</xsl:choose>   
			</xsl:for-each>
		</xsl:variable> 
					
		<!-- If category is present, then check for all subcategory the presence of rules-->
		<xsl:if test="contains($CatNoEmpty,'true')" >	                                  
        	<d:sect1>                                                                          
        		<d:title><xsl:value-of select="$CatToCheck"/></d:title>   
        		<xsl:choose>
        			<xsl:when test="$CatToCheck= 'Formatting'">                                      
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Naming</xsl:with-param>                         
						</xsl:call-template>                                                       
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">FileStructure</xsl:with-param>                         
						</xsl:call-template>                                                         
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>   
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Traceability'">                                  
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Versioning</xsl:with-param>                         
						</xsl:call-template>                                          
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reuse</xsl:with-param>                         
						</xsl:call-template>                                                   
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Requirement</xsl:with-param>                         
						</xsl:call-template>                                                   
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>                                 
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Design'">                                                 
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">I/O</xsl:with-param>                         
						</xsl:call-template>                                              
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reset</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">StateMachine</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Clocking</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Synchronous</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Combinational</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Type</xsl:with-param>                         
						</xsl:call-template>                         
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reliability</xsl:with-param>                         
						</xsl:call-template>                         
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>      
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Simulation'">                  
						<xsl:call-template name="checkSubcategory_STD">                                               
							<xsl:with-param name="CatToCheck">Simulation</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>      
        			</xsl:when>
        		</xsl:choose>
				<xsl:processing-instruction name="hard-pagebreak" /> 
        	</d:sect1>
        </xsl:if>
   </xsl:template>  	                                                      
	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  checkSubcategory_STD  /////////////////////////////////////////////  -->
	<!-- ////////////////////////////          Check if empty subcategory   //////////////////////////////  -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="checkSubcategory_STD">
		<xsl:param name="CatToCheck">CAT</xsl:param>
		<xsl:param name="SubcatToCheck">SUBCAT</xsl:param>
   
   		<!-- Variable definition with following of true and false text         -->
   		<!-- true : if subcategory of rule is the same as subcategory tested   -->
   		<!-- false : if subcategory of rule is different                       -->
        <xsl:variable name="SubcatNoEmpty" >
        	<xsl:for-each select="key('cat', $CatToCheck)">
        		<xsl:choose>
        			<xsl:when test="hb:RuleContent/hb:SubCategory/text()=$SubcatToCheck">
        				<xsl:choose>
							<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')">
								<xsl:choose>
									<xsl:when test="hb:RuleHist/hb:Status/text()='Deleted'">
           		             			<xsl:text>false</xsl:text>
									</xsl:when>
									<xsl:when test="hb:RuleHist/hb:Status/text()='Rejected'">
										<xsl:text>false</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>true</xsl:text>
									</xsl:otherwise>
            	    			</xsl:choose>	
							</xsl:when>
							<xsl:otherwise>
              	  				<xsl:text>false</xsl:text>
              	 	 		</xsl:otherwise>
              		  	</xsl:choose>
             	   </xsl:when>		
					<xsl:otherwise>
             	   	<xsl:text>false</xsl:text>
            	    </xsl:otherwise>	
				</xsl:choose>   
			</xsl:for-each>
		</xsl:variable> 
				
		<!-- Test if true is present on variable                                   -->	
		<!-- = subcategory tested have at least one rule with the same subcategory -->
		<xsl:if test="contains($SubcatNoEmpty,'true')" >	                                 
        	<d:sect2>  
        		<d:sect2info>                                                                        
        			<d:title><xsl:value-of select="$SubcatToCheck"/></d:title>  
        		</d:sect2info>                 
				<xsl:call-template name="section3a">                                               
					<xsl:with-param name="sect3_cat"><xsl:value-of select="$CatToCheck"/></xsl:with-param>                        
					<xsl:with-param name="sect3_subcat"><xsl:value-of select="$SubcatToCheck"/></xsl:with-param>                         
				</xsl:call-template>  
        	</d:sect2>
        </xsl:if>
      
   </xsl:template>  	                               			   	
	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  checkCategory_CUST  ////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          Check if empty Category for CUST   /////////////////////////  -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="checkCategory_CUST">
		<xsl:param name="CatToCheck">CAT</xsl:param>
   
   	<!-- Initialize variable with true if category is not empty for CUST -->
   		<xsl:variable name="TRUE" >true</xsl:variable>
        <xsl:variable name="CatNoEmpty" >
      	  <xsl:for-each select="key('cat', $CatToCheck)">
        		<xsl:choose>
        			<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')">
        				<xsl:text>false</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="hb:RuleHist/hb:Status/text()='Deleted'">
          		              	<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:when test="hb:RuleHist/hb:Status/text()='Rejected'">
								<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>true</xsl:text>
							</xsl:otherwise>
            	    	</xsl:choose>	
            	    </xsl:otherwise>	
				</xsl:choose>   
			</xsl:for-each>
		</xsl:variable> 
					
		<!-- If category is present, then check for all subcategory the presence of rules-->
		<xsl:if test="contains($CatNoEmpty,'true')" >	                                  
        	<d:sect1>                                                                          
        		<d:title><xsl:value-of select="$CatToCheck"/></d:title>   
        		<xsl:choose>
        			<xsl:when test="$CatToCheck= 'Formatting'">                                      
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Naming</xsl:with-param>                         
						</xsl:call-template>                                                       
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">FileStructure</xsl:with-param>                         
						</xsl:call-template>                                                         
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Formatting</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>   
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Traceability'">                                  
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Versioning</xsl:with-param>                         
						</xsl:call-template>                                          
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reuse</xsl:with-param>                         
						</xsl:call-template>                                                   
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Requirement</xsl:with-param>                         
						</xsl:call-template>                                                   
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Traceability</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>                                 
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Design'">                                                 
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">I/O</xsl:with-param>                         
						</xsl:call-template>                                              
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reset</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">StateMachine</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Clocking</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Synchronous</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Combinational</xsl:with-param>                         
						</xsl:call-template>                                
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Type</xsl:with-param>                         
						</xsl:call-template>                         
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Reliability</xsl:with-param>                         
						</xsl:call-template>                         
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Design</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>      
        			</xsl:when>
        			<xsl:when test="$CatToCheck= 'Simulation'">                  
						<xsl:call-template name="checkSubcategory_CUST">                                               
							<xsl:with-param name="CatToCheck">Simulation</xsl:with-param>                        
							<xsl:with-param name="SubcatToCheck">Miscellaneous</xsl:with-param>                         
						</xsl:call-template>      
        			</xsl:when>
        		</xsl:choose>
        		
				<xsl:processing-instruction name="hard-pagebreak" />
        	</d:sect1>
        </xsl:if>
      
   </xsl:template>  	                                                      
			
					
					
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  checkSubcategory_CUST  /////////////////////////////////////////////  -->
	<!-- ////////////////////////////          Check if empty subcategory   //////////////////////////////  -->	
	<!-- /////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="checkSubcategory_CUST">
		<xsl:param name="CatToCheck">CAT</xsl:param>
		<xsl:param name="SubcatToCheck">SUBCAT</xsl:param>
   
   		<!-- Variable definition with following of true and false text         -->
   		<!-- true : if subcategory of rule is the same as subcategory tested   -->
   		<!-- false : if subcategory of rule is different                       -->
        <xsl:variable name="SubcatNoEmpty" >
        	<xsl:for-each select="key('cat', $CatToCheck)">
        		<xsl:choose>
        			<xsl:when test="hb:RuleContent/hb:SubCategory/text()=$SubcatToCheck">
        				<xsl:choose>
							<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')">
              	  				<xsl:text>false</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="hb:RuleHist/hb:Status/text()='Deleted'">
           		             			<xsl:text>false</xsl:text>
									</xsl:when>
									<xsl:when test="hb:RuleHist/hb:Status/text()='Rejected'">
										<xsl:text>false</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>true</xsl:text>
									</xsl:otherwise>
            	    			</xsl:choose>	
              	 	 		</xsl:otherwise>
              		  	</xsl:choose>
             	   	</xsl:when>		
					<xsl:otherwise>
             	   		<xsl:text>false</xsl:text>
            	    </xsl:otherwise>	
				</xsl:choose>   
			</xsl:for-each>
		</xsl:variable> 
		
		<!-- Test if true is present on variable                                   -->	
		<!-- = subcategory tested have at least one rule with the same subcategory -->			
		<xsl:if test="contains($SubcatNoEmpty,'true')" >	                                 
        	<d:sect2>                                                                          
        		<d:title><xsl:value-of select="$SubcatToCheck"/></d:title>                   
				<xsl:call-template name="section3b">                                               
					<xsl:with-param name="sect3_cat"><xsl:value-of select="$CatToCheck"/></xsl:with-param>                        
					<xsl:with-param name="sect3_subcat"><xsl:value-of select="$SubcatToCheck"/></xsl:with-param>                         
				</xsl:call-template>  
        	</d:sect2>
        </xsl:if>
      
   </xsl:template>  	                               			   
	
	
	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  SECTION 3a  ////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          STANDARD   /////////////////////////////////////////////////  -->	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="section3a">
		<xsl:param name="sect3_cat">CAT</xsl:param>
      	<xsl:param name="sect3_subcat">SUBCAT</xsl:param>
			
		<!-- Display all rule with category $sect_cat and subcategory $sect3_subcat for standart rules -->
		<xsl:for-each select="key('cat', $sect3_cat)">
			<xsl:if test="hb:RuleContent/hb:SubCategory/text()=$sect3_subcat">
				<xsl:if test="starts-with(hb:RuleUID/text(), 'STD')">
					<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
				   		<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
					  		<xsl:call-template name="rule_display" />
				   		</xsl:if>
					</xsl:if>   
				</xsl:if>
			</xsl:if>			
       	</xsl:for-each>   
   </xsl:template>	
	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  SECTION 3b  ////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          CUSTOM   ///////////////////////////////////////////////////  -->	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->	
	<xsl:template name="section3b">                                                                 
      	<xsl:param name="sect3_cat">CAT</xsl:param>
      	<xsl:param name="sect3_subcat">SUBCAT</xsl:param>

		<!-- Display all rule with category $sect_cat and subcategory $sect3_subcat for custom rules   -->
        <xsl:for-each select="key('cat', $sect3_cat)">
            <xsl:if test="hb:RuleContent/hb:SubCategory/text()=$sect3_subcat">
               	<xsl:choose>
                  	<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')">
                  	</xsl:when>
                  	<!-- when not(starts-with(hb:RuleUID/text(), 'STD') -->
                  	<xsl:otherwise>
                     	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                        	<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                           		<xsl:call-template name="rule_display" />
							</xsl:if>
						</xsl:if>
                	</xsl:otherwise>
               	</xsl:choose>
            </xsl:if>
        </xsl:for-each>                                                                              
	</xsl:template>        
	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  SECTION 4   ////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          RULE     ///////////////////////////////////////////////////  -->	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="rule_display">
		<d:sect3>
			<d:title>
				<xsl:value-of select=".//hb:RuleUID" />
				:
				<xsl:value-of select=".//hb:RuleContent/hb:Name" />
			</d:title>

			<!-- Creation of table of 6 rows and 3 columns -->
			<d:informaltable frame="all">
				<d:tgroup cols="3" align="left">
					<d:colspec colname="c1" colnum="1" colwidth="0.5*" />
					<d:colspec colname="c2" colnum="2" colwidth="2.0*" />
					<d:colspec colname="c3" colnum="3" colwidth="0.5*" />
					<d:thead>
						<!-- header of table : RuleUID / Name / Severity -->
						<d:row valign="middle">
							<d:entry>
								<xsl:value-of select=".//hb:RuleUID" />
							</d:entry>
							<d:entry>
								<xsl:value-of select=".//hb:RuleContent/hb:Name" />
							</d:entry>
							<d:entry>
								<xsl:value-of select=".//hb:RuleContent/hb:Severity" />
							</d:entry>
						</d:row>
					</d:thead>
					<d:tbody>
						<!-- 1st line : Revision and version -->
						<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Revision
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
								<xsl:value-of select=".//hb:RuleHist/hb:Version" /> /
                        		<xsl:value-of select=".//hb:RuleHist/hb:Modified" />
							</d:entry>
						</d:row>
						<!-- 2nd t line : status  -->
						<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Status / Engine
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
								<xsl:value-of select=".//hb:RuleHist/hb:Status" /> /
                        		<xsl:value-of select=".//hb:RuleHist/hb:Engine" />
							</d:entry>
						</d:row>
						<!-- "3rd line : Technology, Category and subcategory -->
						<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Classification
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
                        		<xsl:value-of select=".//hb:RuleContent/hb:Technology" /> / 
								<xsl:value-of select=".//hb:RuleContent/hb:Category" /> / 
								<xsl:value-of select=".//hb:RuleContent/hb:SubCategory" />
							</d:entry>
						</d:row>
						<!-- 4th line : Application field -->
						<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Application Field
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
								<xsl:value-of select=".//hb:RuleContent/hb:ApplicationFields" />
							</d:entry>
						</d:row>
						<!-- 5th line : RuleUID of Parent rule -->
                 		<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Parent Rule
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
                        		<xsl:choose>
                           			<xsl:when test="hb:RuleContent/hb:IsSon/text() = 'true'">
                              			<xsl:value-of select=".//hb:RuleContent/hb:ParentUID" />
                           			</xsl:when>
                           			<xsl:otherwise>
                              			<xsl:text>N/A</xsl:text>
                           			</xsl:otherwise>
                        		</xsl:choose>
							</d:entry>
						</d:row>
						<!-- 6th line : Short Description -->
						<d:row valign="middle">
							<d:entry>
								<d:emphasis role="bold">Description
								</d:emphasis>
							</d:entry>
							<d:entry namest="c2" nameend="c3">
								<xsl:value-of select=".//hb:RuleContent/hb:ShortDesc" />
							</d:entry>
						</d:row>
					</d:tbody>
				</d:tgroup>
			</d:informaltable>

			<d:itemizedlist>
				<d:listitem>
					<d:para>
                  		<d:emphasis role="bold">Detailed Description:</d:emphasis>
              		</d:para>
					<d:literallayout><xsl:value-of select=".//hb:RuleContent/hb:LongDesc" /></d:literallayout>
				</d:listitem>
             
            	<xsl:if test=".//hb:Figure/@fileref"> <!-- if there is an information then the picture is displayed -->
					<d:listitem>
						<d:para>
							<d:emphasis role="bold">Figure:
							</d:emphasis>
						</d:para>
						<d:para>
							<xsl:call-template name="Figure" />
						</d:para>
					</d:listitem>
				</xsl:if>
   
            	<d:listitem>
					<d:para>
						<d:emphasis role="bold">Rationale:
						</d:emphasis>
					</d:para>
					<d:para>
						<xsl:value-of select=".//hb:RuleContent/hb:Rationale" />
					</d:para>
				</d:listitem>
				
            	<xsl:if test=".//hb:GoodExDesc!=''"> <!-- if there is an information then the example is displayed -->
					<d:listitem>
						<d:para>
							<d:emphasis role="bold">Good Example:</d:emphasis>
						</d:para>
						<d:para>
							<xsl:call-template name="GoodExample" />
						</d:para>
					</d:listitem>
				</xsl:if>
				
				<xsl:if test=".//hb:BadExDesc!=''"> <!-- if there is an information then the example is displayed -->
					<d:listitem>
						<d:para>
							<d:emphasis role="bold">Bad Example:
							</d:emphasis>
						</d:para>
						<d:para>
							<xsl:call-template name="BadExample" />
						</d:para>
					</d:listitem>
				</xsl:if>
			</d:itemizedlist>
			
			<xsl:if test="contains($Sonarqube_enabled,'true')" >	                                 
			
				<d:itemizedlist>
					<d:listitem>
						<d:para>
            	      		<d:emphasis role="bold">Sonarqube:</d:emphasis>
        	      		</d:para>
					
						<!-- Creation of table of 3 rows and 2 columns -->
						<d:informaltable frame="all">
							<d:tgroup cols="2" align="left">
								<d:colspec colname="c1" colnum="1" colwidth="0.5*" />
								<d:colspec colname="c2" colnum="2" colwidth="2.0*" />
								<d:tbody>
									<!-- 1st line : Sonar type effort -->
									<d:row valign="middle">
										<d:entry>
											<d:emphasis role="bold">Type
											</d:emphasis>
										</d:entry>
										<d:entry>
											<xsl:if test=".//hb:Sonarqube/hb:SonarType ='Vulnerability'">
												 Vulnerability 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:SonarType ='Bug'">
												 Bug 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:SonarType ='Code_Smell'">
												 Code Smell 
											</xsl:if>
												<!-- Add of TBD which is not an enum element, but is used -->
											<xsl:if test=".//hb:Sonarqube/hb:SonarType ='TBD'">
												 TBD 
											</xsl:if>
										</d:entry>
									</d:row>
									<!-- 1st line : Remediation effort -->
									<d:row valign="middle">
										<d:entry>
											<d:emphasis role="bold">Remediation effort
											</d:emphasis>
										</d:entry>
										<d:entry>
											<xsl:value-of select=".//hb:Sonarqube/hb:RemediationEffort" />
											<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='Trivial'">
												 - 5 minutes 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='Easy'">
												 - 10 minutes 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='Medium'">
												 - 20 minutes 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='Major'">
												 - 1 hour 
											</xsl:if>
											<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='High'">
												 - 3 hours 
											</xsl:if>
												<xsl:if test=".//hb:Sonarqube/hb:RemediationEffort ='Complex'">
												 - 1 day 
											</xsl:if>
										</d:entry>
									</d:row>
									<!-- 2nd line : Sonar severity -->
									<d:row valign="middle">
										<d:entry>
											<d:emphasis role="bold">Sonar severity
											</d:emphasis>
										</d:entry>
										<d:entry>
											<xsl:value-of select=".//hb:Sonarqube/hb:SonarSeverity" />
										</d:entry>
									</d:row>
									<!-- 3rd line : Tag -->
									<d:row valign="middle">
										<d:entry>
											<d:emphasis role="bold">Sonar tag
											</d:emphasis>
										</d:entry>
										<d:entry>
											<xsl:value-of select=".//hb:Sonarqube/hb:SonarTag" />
										</d:entry>
									</d:row>
								</d:tbody>
							</d:tgroup>
						</d:informaltable>
					</d:listitem>
				</d:itemizedlist>
			</xsl:if>
			<xsl:if test=".//hb:RuleParams">
				<d:itemizedlist>
					<d:listitem>
						<d:para>
							<d:emphasis role="bold">Parameters:</d:emphasis>
						</d:para>
						<!-- Creation of table of n rows and 5 columns -->
						<d:informaltable frame="all">
							<d:tgroup cols="3" align="left">
								<d:colspec colname="c1" colnum="1" colwidth="0.5*" />
								<d:colspec colname="c2" colnum="2" colwidth="0.5*" />
								<d:colspec colname="c3" colnum="3" colwidth="0.5*" />
								<d:thead>
									<!-- header of table : ParamId / Type / Relation or position / Value min / Value Max -->
									<d:row valign="middle">
									
										<d:entry>
											<xsl:text>Parameter ID</xsl:text>
										</d:entry>
										<d:entry>
											<xsl:text>Type</xsl:text>
										</d:entry>
										<d:entry>
											<xsl:text>Value</xsl:text>
										</d:entry>
									</d:row>
								</d:thead>
								<d:tbody>
									<xsl:for-each select=".//hb:RuleParams/hb:IntParam">
-										<d:row valign="middle">

											<d:entry>
												<xsl:value-of select="hb:ParamID" />
											</d:entry>
											<d:entry>
												<xsl:text>Integer</xsl:text>
											</d:entry>
											<d:entry>
												<!-- &le; = &#8804; -->
												<xsl:choose>
													<xsl:when test="hb:Relation = 'LT'">
														&lt; <xsl:value-of select="hb:Value" />
													</xsl:when>
													<xsl:when test="hb:Relation = 'LET'">
														&lt;= <xsl:value-of select="hb:Value" />
													</xsl:when>
													<xsl:when test="hb:Relation = 'E'">
														= <xsl:value-of select="hb:Value" />
													</xsl:when>
													<xsl:when test="hb:Relation = 'GET'">
														&gt;= <xsl:value-of select="hb:Value" />
													</xsl:when>
													<xsl:when test="hb:Relation = 'GT'">
														&gt; <xsl:value-of select="hb:Value" />
													</xsl:when>
												</xsl:choose>
											</d:entry>
										</d:row>
									</xsl:for-each>
									<xsl:for-each select=".//hb:RuleParams/hb:StringParam">
										<d:row valign="middle">
											<d:entry>
												<xsl:value-of select="hb:ParamID" />
											</d:entry>
											<d:entry>
												<xsl:text>String</xsl:text>
											</d:entry>
											<d:entry>
												<xsl:choose>
													<xsl:when test="hb:Position = 'Prefix'">
														<xsl:value-of select="hb:Value" />*
													</xsl:when>
													<xsl:when test="hb:Position = 'Contain'">
														*<xsl:value-of select="hb:Value" />*
													</xsl:when>
													<xsl:when test="hb:Position = 'Equal'">
														<xsl:value-of select="hb:Value" />
													</xsl:when>
													<xsl:when test="hb:Position = 'Suffix'">
														<xsl:value-of select="hb:Value" />*
													</xsl:when>
												</xsl:choose>
											</d:entry>
										</d:row>
									</xsl:for-each>
									<xsl:for-each select=".//hb:RuleParams/hb:RangeParam">
										<d:row valign="middle">
											<d:entry >
												<xsl:value-of select="hb:ParamID" />
											</d:entry>
											<d:entry>
												<xsl:text>Integer range</xsl:text>
											</d:entry>
											<d:entry>
												<xsl:choose>
													<xsl:when test="hb:Range = 'LT_GT'">
														<xsl:value-of select="hb:ValueMin" /> &lt; _ &lt; <xsl:value-of select="hb:ValueMax" /> 
													</xsl:when>
													<xsl:when test="hb:Range = 'LET_GT'">
														<xsl:value-of select="hb:ValueMin" /> &lt; _ &lt;= <xsl:value-of select="hb:ValueMax" /> 
													</xsl:when>
													<xsl:when test="hb:Range = 'LET_GET'">
														<xsl:value-of select="hb:ValueMin" /> &lt;= _ &lt;= <xsl:value-of select="hb:ValueMax" /> 
													</xsl:when>
													<xsl:when test="hb:Range = 'LT_GET'">
														<xsl:value-of select="hb:ValueMin" /> &lt;= _ &lt; <xsl:value-of select="hb:ValueMax" /> 
													</xsl:when>
												</xsl:choose>
											</d:entry>
										</d:row>
									</xsl:for-each>
								</d:tbody>
							</d:tgroup>
						</d:informaltable>
					</d:listitem>
				</d:itemizedlist>
			</xsl:if>
        	<xsl:processing-instruction name="linebreak" />
			<xsl:processing-instruction name="linebreak" />
		</d:sect3>
	</xsl:template>
	
	<!-- ====================================================================== -->
	<!-- TEMPLATE TO CALL                                                       -->
	<!-- ====================================================================== -->
	<xsl:template name="GoodExample">
		<xsl:variable name="vhdlGoodFileName" > <xsl:value-of select=".//hb:GoodExample"/> </xsl:variable>
		<!-- Display the description -->
		<xsl:value-of select=".//hb:GoodExDesc" />	
		<xsl:processing-instruction name="linebreak" />
		<!-- Display the example -->
		<xsl:if test=".//hb:GoodExample!=''">
			<d:programlisting>
			   <xsl:variable name="VHDLcodeGood"><xsl:value-of select="unparsed-text(concat($VHDL_folder, $vhdlGoodFileName, '.vhd'), 'UTF-8')" /></xsl:variable>
            <xsl:variable name="VHDLextractGood"><xsl:value-of select="substring-before(substring-after($VHDLcodeGood, $VHDL_tag), $VHDL_tag)"></xsl:value-of></xsl:variable>
            <xsl:value-of select="$VHDLextractGood"></xsl:value-of>
			</d:programlisting><!-- file reference name is in the xml -->
		</xsl:if>
	</xsl:template>

	<xsl:template name="BadExample">
		<xsl:variable name="vhdlBadFileName" > <xsl:value-of select=".//hb:BadExample"/> </xsl:variable>
		<!-- Display the description -->
		<xsl:value-of select=".//hb:BadExDesc" />
		<xsl:processing-instruction name="linebreak" />
		<!-- Display the example -->
		<xsl:if test=".//hb:BadExample!=''">
			<d:programlisting>
			   <xsl:variable name="VHDLcodeBad"><xsl:value-of select="unparsed-text(concat($VHDL_folder, $vhdlBadFileName, '.vhd'), 'UTF-8')" /></xsl:variable>
            <xsl:variable name="VHDLextractBad"><xsl:value-of select="substring-before(substring-after($VHDLcodeBad, $VHDL_tag), $VHDL_tag)"></xsl:value-of></xsl:variable>
            <xsl:value-of select="$VHDLextractBad"></xsl:value-of>
			</d:programlisting><!-- file reference name is in the xml -->
		</xsl:if>
	</xsl:template>
		
	<xsl:template name="Figure">
		<!-- Display the description -->
		<xsl:value-of select=".//hb:FigureDesc" />
		<xsl:processing-instruction name="linebreak" />
		<!-- Display the picture -->
		<xsl:if test=".//hb:Figure/@fileref">
			<xsl:variable name="figureName" > <xsl:value-of select=".//hb:Figure/@fileref"/> </xsl:variable>
			<xsl:element name="d:mediaobject">
				<xsl:element name="d:imageobject">
					<xsl:element name="d:imagedata">
						<xsl:attribute name="fileref">
							<xsl:value-of select="concat($Images_folder , $figureName)" /> 
						</xsl:attribute>
						<xsl:attribute name="align">center</xsl:attribute>
						<xsl:attribute name="width">
            				<xsl:value-of select=".//hb:Figure/@width" />
         				</xsl:attribute>
						<xsl:attribute name="depth">
            				<xsl:value-of select=".//hb:Figure/@height" />
         				</xsl:attribute>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:if>	
	</xsl:template>	
	
	<xsl:template name="History">
	<!-- Table of 3 rows and 2 columns -->
		<d:informaltable frame="all">
			<d:tgroup cols="2" align="left">
				<d:colspec colname="c1" colnum="1" colwidth="0.3*" />
				<d:colspec colname="c2" colnum="2" colwidth="0.8*" />
				<d:tbody>
					<d:row valign="middle">
						<d:entry>
							<d:emphasis role="bold">Version
							</d:emphasis>
						</d:entry>
						<d:entry>
							<xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Version" />
						</d:entry>
					</d:row>
					<d:row valign="middle">
						<d:entry>
							<d:emphasis role="bold">Modification date
							</d:emphasis>
						</d:entry>
						<d:entry>
							<xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Modified" />
						</d:entry>
					</d:row>
					<d:row valign="middle">
						<d:entry>
							<d:emphasis role="bold">Revision
							</d:emphasis>
						</d:entry>
						<d:entry>
							<d:literallayout><xsl:value-of select="hb:RuleSet/hb:RuleSetHist/hb:Revision" /></d:literallayout>
						</d:entry>
					</d:row>
				</d:tbody>
			</d:tgroup>
		</d:informaltable>
	</xsl:template>
	
</xsl:stylesheet>