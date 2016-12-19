<!-- ///////////////////////////////////////////////////////////////////// -->
<!-- Authors : F.JUGE (Altran Ouest), B.CORVE (Altran Ouest)               -->
<!-- Mail : florian.juge@altran.com, baptiste.corve@altran.com             -->
<!-- version 0 : 2014/10/06 : F.JUGE : creation                            -->
<!-- version 1 : 2014/12/05 : B.CORVE : sort algorithm                     -->
<!--                          								    		   -->
<!-- ///////////////////////////////////////////////////////////////////// -->


<xsl:stylesheet version="2.0"
 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:hb="HANDBOOK"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:d="http://docbook.org/ns/docbook" 
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="hb ../output/work/XSD/handbook.xsd">
	  
	
	
	<!--<xsl:namespace-alias result-prefix="hb" stylesheet-prefix="xsi" />-->
	<xsl:key name="cat" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:Category" />
	<xsl:key name="subcat" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:SubCategory" />
	<xsl:key name="parent_uid" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:ParentUID" /> 
	<xsl:key name="uid" match="hb:RuleSet/hb:Rule" use="hb:RuleUID" /> 
	<xsl:key name="son" match="hb:RuleSet/hb:Rule" use="hb:RuleContent/hb:IsSon" />  
	
	<!-- ====================================================================== -->
	<!-- Root Template -->
	<!-- ====================================================================== -->
	<xsl:template match="/">
		<xsl:element name="hb:RuleSet" namespace="HANDBOOK">
			<!-- apply the sorting on the standard rules -->
			<xsl:call-template name="category_filter">
			   <xsl:with-param name="catfilt_rule">STANDARD</xsl:with-param>
			</xsl:call-template>

			<!-- apply the sorting on the custom rules -->
			<xsl:call-template name="category_filter">
			   <xsl:with-param name="catfilt_rule">CUSTOM</xsl:with-param>
			</xsl:call-template>
			<!-- copy the RuleSetHist tag at the end of the new xml -->
			<xsl:copy-of select="hb:RuleSet/hb:RuleSetHist"/>   
		</xsl:element>
	</xsl:template>

	
    <!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
    <!-- ////////////////////////////  Category Filter   //////////////////////////////////////////////////  -->
    <!-- ////////////////////////////          SORT for section  //////////////////////////////////////////  -->	
    <!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
   <xsl:template name="category_filter">
      <xsl:param name="catfilt_rule">RULE</xsl:param>
      
         <xsl:choose>
	<!-- ////////////////////////////  STANDARD   /////////////////////////////////////////////////////////  -->
            <xsl:when test="$catfilt_rule='STANDARD'">     
                  <xsl:call-template name="subCategory_filter_std">                                               
                     <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                     <xsl:with-param name="sect_subcat">Naming</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                               
                     <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                     <xsl:with-param name="sect_subcat">FileStructure</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                 
                     <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                                                             
                  <xsl:call-template name="subCategory_filter_std">                                               
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Versioning</xsl:with-param>                    
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                               
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Reuse</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Requirement</xsl:with-param>                   
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                 
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                   
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>               
                  </xsl:call-template>                                                                  
                                                                     
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">I/O</xsl:with-param>                           
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Reset</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">StateMachine</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Clocking</xsl:with-param>                      
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Synchronous</xsl:with-param>                   
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Combinational</xsl:with-param>                 
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Type</xsl:with-param>                          
                  </xsl:call-template>                       
                  <xsl:call-template name="subCategory_filter_std">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Reliability</xsl:with-param>                 
                  </xsl:call-template>                                           
                  <xsl:call-template name="subCategory_filter_std">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                 
                  </xsl:call-template>                                                                  
                                                                 
                  <xsl:call-template name="subCategory_filter_std">                                                
                     <xsl:with-param name="sect_cat">Simulation</xsl:with-param>                       
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                 
                  </xsl:call-template>  
            </xsl:when>
            
	<!-- //////////////////////////////  CUSTOM   /////////////////////////////////////////////////////////  -->
            <xsl:when test="$catfilt_rule='CUSTOM'">         
                  <xsl:call-template name="subCategory_filter_cus">                                                
                  <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                  <xsl:with-param name="sect_subcat">Naming</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                
                  <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                  <xsl:with-param name="sect_subcat">FileStructure</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                  
                  <xsl:with-param name="sect_cat">Formatting</xsl:with-param>                        
                  <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                                                              
                  <xsl:call-template name="subCategory_filter_cus">                                                
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Versioning</xsl:with-param>                    
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Reuse</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                     
                     <xsl:with-param name="sect_subcat">Requirement</xsl:with-param>                   
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                  
                     <xsl:with-param name="sect_cat">Traceability</xsl:with-param>                   
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>               
                  </xsl:call-template>                                                                  
                                                                                        
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">I/O</xsl:with-param>                           
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Reset</xsl:with-param>                         
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">StateMachine</xsl:with-param>                  
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                  
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Clocking</xsl:with-param>                      
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Synchronous</xsl:with-param>                   
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Combinational</xsl:with-param>                 
                  </xsl:call-template>                                                                  
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Type</xsl:with-param>                          
                  </xsl:call-template> 
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Reliability</xsl:with-param>                 
                  </xsl:call-template>                  
                  <xsl:call-template name="subCategory_filter_cus">                                                  
                     <xsl:with-param name="sect_cat">Design</xsl:with-param>                           
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                 
                  </xsl:call-template>                                        
                                                                
                  <xsl:call-template name="subCategory_filter_cus">                                                 
                     <xsl:with-param name="sect_cat">Simulation</xsl:with-param>                       
                     <xsl:with-param name="sect_subcat">Miscellaneous</xsl:with-param>                 
                  </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <!-- NO ACTION -->
			</xsl:otherwise>
		</xsl:choose>                            
    </xsl:template>
   
   
   
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  SECTION 3a  ////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          STANDARD   /////////////////////////////////////////////////  -->	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<xsl:template name="subCategory_filter_std">
		<xsl:param name="sect_cat">CAT</xsl:param>
		<xsl:param name="sect_subcat">SUBCAT</xsl:param>
      
		<xsl:for-each select="key('cat', $sect_cat)">
            <!-- Sorting -->
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Major'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Minor'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Note'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleUID/text()" order="ascending" data-type="text" />
            <!-- Select rule to copy on output file -->
            <xsl:if test="hb:RuleContent/hb:SubCategory/text()=$sect_subcat">
			<xsl:if test="starts-with(hb:RuleUID/text(), 'STD')">
				<xsl:choose>
					<!-- Parent rule -->
					<xsl:when test="hb:RuleContent/hb:IsParent/text() = 'true'" >
						<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                           	<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                              	<xsl:call-template name="copy_rule" />
                              	<xsl:variable name="P_UID" > <xsl:value-of select=".//hb:RuleUID"/> </xsl:variable>
                              	<!-- Son rules of Parent rule selected -->
                              	<xsl:for-each select="key('parent_uid', $P_UID)">
                                 	<xsl:sort select="hb:RuleContent/hb:Severity/text()='Major'" order="descending" data-type="text" />
                                 	<xsl:sort select="hb:RuleContent/hb:Severity/text()='Minor'" order="descending" data-type="text" />
                                 	<xsl:sort select="hb:RuleContent/hb:Severity/text()='Note'" order="descending" data-type="text" />
                                 	<!-- if the son is in another category, it is displayed in this category              -->
                                 	<!-- if the son is in another sub-category, it is displayed in this sub-category      -->
                                 	<xsl:if test="starts-with(hb:RuleUID/text(), 'STD')">
                                    	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                                       		<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                                          		<xsl:call-template name="copy_rule" />
                                       		</xsl:if>
                                    	</xsl:if>   
                                 	</xsl:if>
                              	</xsl:for-each>
							</xsl:if>   
						</xsl:if>
					</xsl:when>
					<!-- Son rule -->
					<xsl:when test="hb:RuleContent/hb:IsSon/text() = 'true'">
                        <xsl:variable name="P_UID" ><xsl:value-of select=".//hb:RuleContent/hb:ParentUID"/></xsl:variable>
                        <xsl:variable name="TRUE" >true</xsl:variable>
                        <xsl:variable name="SonToDisplay" >
                           	<!-- Only different RuleUID exist, so only true or false text can be resulted -->
                           	<xsl:for-each select="key('uid', $P_UID)">
                              	<!-- if the son is in a others category, it is displayed in this category              -->
                              	<!-- if the son is in a others sub-category, it is displayed in this sub-category      -->
                              	<xsl:choose>
                              	 	<!-- if the parent is not displayed on Standard rules -->
                                 	<xsl:when test="not(starts-with(hb:RuleUID/text(), 'STD'))" > 
                                    	<xsl:text>true</xsl:text>  
                                 	</xsl:when>
                                 	<xsl:otherwise>
                                    	<xsl:text>false</xsl:text>
                                 	</xsl:otherwise>
                              	</xsl:choose>   
                           	</xsl:for-each>
                        </xsl:variable>
                        <!-- Parent is not in standart rule, so rule was not displayed with parent -->
						<xsl:if test="$SonToDisplay='true'" >
                           	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                              	<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                                 	<xsl:call-template name="copy_rule" />
                              	</xsl:if>
                        	</xsl:if>
                     	</xsl:if>
                     </xsl:when>
                     <!-- No son and no parent rule -->
                     	<xsl:otherwise>
                        	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                           		<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
									<xsl:call-template name="copy_rule" />
								</xsl:if>
                        	</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>   
	</xsl:template>
   
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////  SECTION 3b  ////////////////////////////////////////////////////////  -->
	<!-- ////////////////////////////          CUSTOM   ///////////////////////////////////////////////////  -->	
	<!-- //////////////////////////////////////////////////////////////////////////////////////////////////  -->	
	<xsl:template name="subCategory_filter_cus">                                                                 
      	<xsl:param name="sect_cat">CAT</xsl:param>
		<xsl:param name="sect_subcat">SUBCAT</xsl:param>
      
		<xsl:for-each select="key('cat', $sect_cat)">
            <!-- Sorting -->
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Major'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Minor'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleContent/hb:Severity/text()='Note'" order="descending" data-type="text" />
            <xsl:sort select="hb:RuleUID/text()" order="ascending" data-type="text" />
            <!-- Select rule to copy on output file -->
			<xsl:if test="hb:RuleContent/hb:SubCategory/text()=$sect_subcat">
               	<xsl:choose>
               	  	<!-- Standart rules -->
                  	<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')"> 
                  	</xsl:when>
                  	<!-- when not(starts-with(hb:RuleUID/text(), 'STD') -->
                  	<!-- Custom rules and Parent rules-->
                  	<xsl:when test="hb:RuleContent/hb:IsParent/text() = 'true'" >  
                     	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                        	<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                           		<xsl:call-template name="copy_rule" />
                           		<xsl:variable name="P_UID" > <xsl:value-of select=".//hb:RuleUID"/>  </xsl:variable>
                           		<xsl:for-each select="key('parent_uid', $P_UID)">
                              		<xsl:sort select="hb:RuleContent/hb:Severity/text()='Major'" order="descending" data-type="text" />
                              		<xsl:sort select="hb:RuleContent/hb:Severity/text()='Minor'" order="descending" data-type="text" />
                              		<xsl:sort select="hb:RuleContent/hb:Severity/text()='Note'" order="descending" data-type="text" />
                              		<!-- if the son is in a others category, it is displayed in this category              -->
                              		<!-- if the son is in a others sub-category, it is displayed in this sub-category      -->
                              		<xsl:if test="not(starts-with(hb:RuleUID/text(), 'STD'))" >
                                 		<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                                    		<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                                       			<xsl:call-template name="copy_rule" />
                                    		</xsl:if>
                                 		</xsl:if>
                              		</xsl:if>
                           		</xsl:for-each>
                        	</xsl:if>
                     	</xsl:if>
                  	</xsl:when>
                  	<!-- Custom rules and Son rules-->
                  	<xsl:when test="hb:RuleContent/hb:IsSon/text() = 'true'"> 
                     	<xsl:variable name="P_UID" ><xsl:value-of select=".//hb:RuleContent/hb:ParentUID"/></xsl:variable>
                     	<xsl:variable name="TRUE" >true</xsl:variable>
                     	<xsl:variable name="FALSE" >false</xsl:variable>
                     	<xsl:variable name="SonToDisplay" >
                        	<xsl:for-each select="key('uid', $P_UID)">
                        		<!-- if the son is in a others category, it is displayed in this category              -->
                        		<!-- if the son is in a others sub-category, it is displayed in this sub-category      -->
                           		<xsl:choose>
                              		<!-- if the parent is displayed on Standard rules -->
                              		<xsl:when test="starts-with(hb:RuleUID/text(), 'STD')" > 
                                 		<xsl:text>true</xsl:text>  
                              		</xsl:when>
                              		<xsl:otherwise>
                                 		<xsl:text>false</xsl:text>
                              		</xsl:otherwise>
                           		</xsl:choose>  
							</xsl:for-each>
						</xsl:variable>
                 	    <xsl:choose>
                 	    	<xsl:when test="$SonToDisplay=$TRUE"> 							<!--  Parent Rule is defined in Standard rules -->
                     			<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                          	 		<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                          	    		<xsl:call-template name="copy_rule" />
                           			</xsl:if>
                        		</xsl:if>
                     		</xsl:when>
                     		<xsl:when test="$SonToDisplay=$FALSE"> 							<!--  Parent Rule is defined in Custom rules -->
                     		</xsl:when>
                     		<xsl:otherwise> 												<!--  Parent Rule is not defined in the handbook -->
                     			<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                           			<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                              			<xsl:call-template name="copy_rule" />
                           			</xsl:if>
                        		</xsl:if>
                     		</xsl:otherwise>
                     	</xsl:choose>
                  	</xsl:when>
                  	<!-- Custom rules and no Parent and no Son rules -->
                  	<xsl:otherwise> 
                     	<xsl:if test="hb:RuleHist/hb:Status/text()!='Deleted'">
                        	<xsl:if test="hb:RuleHist/hb:Status/text()!='Rejected'">
                           		<xsl:call-template name="copy_rule" />
                        	</xsl:if>
                     	</xsl:if>
                  	</xsl:otherwise>
            	</xsl:choose>
			</xsl:if>
		</xsl:for-each>                                                                              
	</xsl:template>    
<!-- ====================================================================== -->
<!-- 						COPY THE CURRENT NODE (SORTED)					-->
<!-- ====================================================================== -->
	<xsl:template name="copy_rule">
		<xsl:element name="hb:Rule">
			<xsl:copy-of select="@*|node()"/>
		</xsl:element >
	</xsl:template>
   
</xsl:stylesheet>
  