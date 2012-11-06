<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

    <xsl:include href="Common.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:template match="/">
        <xsl:call-template name="processCdmCollectionNodes">
            <xsl:with-param name="records" select="metadata/record[Type = 'Collection']"/>
        </xsl:call-template>
        <xsl:call-template name="processCdmItemNodes">
            <xsl:with-param name="records" select="metadata/record except metadata/record[Type = 'Collection']"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="processCdmCollectionNodes">
        <xsl:param name="records"/>
        <xsl:variable name="enumerationFileURI" select="concat($collectionEnumerationPathURI,'collection',$xmlExtension)"/>
        <xsl:result-document href="{$enumerationFileURI}">
            <objects>
            <xsl:for-each select="$records">
                <object>
                    <identifier><xsl:value-of select="localid"/></identifier>
                </object>
                <xsl:call-template name="writeContentdmDoc">
                    <xsl:with-param name="record" select="."/>
                    <xsl:with-param name="contentdmFileURI" select="concat($collectionContentdmPathURI,localid,$xmlExtension)"/>
                </xsl:call-template>
                <xsl:call-template name="writeModsDoc">
                    <xsl:with-param name="record" select="."/>
                    <xsl:with-param name="modsFileURI" select="concat($collectionModsPathURI,localid,$xmlExtension)"/>
                </xsl:call-template>
            </xsl:for-each>
            </objects>            
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="processCdmItemNodes">
        <xsl:param name="records"/>
        <xsl:variable name="enumerationFileURI" select="concat($itemEnumerationPathURI,'items',$xmlExtension)"/>
        <xsl:result-document href="{$enumerationFileURI}">
            <objects>
                <xsl:for-each select="$records">
                    <object>
                        <identifier><xsl:value-of select="localid"/></identifier>
                    </object>
                    <xsl:call-template name="writeContentdmDoc">
                        <xsl:with-param name="record" select="."/>
                        <xsl:with-param name="contentdmFileURI" select="concat($itemContentdmPathURI,localid,$xmlExtension)"/>
                    </xsl:call-template>
                    <xsl:call-template name="writeModsDoc">
                        <xsl:with-param name="record" select="."/>
                        <xsl:with-param name="modsFileURI" select="concat($itemModsPathURI,localid,$xmlExtension)"/>
                    </xsl:call-template>
                </xsl:for-each>
            </objects>            
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="writeContentdmDoc">
        <xsl:param name="record"/>
        <xsl:param name="contentdmFileURI"/>
        <xsl:result-document href="{$contentdmFileURI}">
            <xsl:copy-of select="$record"/>
        </xsl:result-document>        
    </xsl:template>
    
    <xsl:template name="writeModsDoc">
        <xsl:param name="record"/>
        <xsl:param name="modsFileURI"/>
        <xsl:result-document href="{$modsFileURI}">
            <mods xmlns="http://www.loc.gov/mods/v3" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.4" xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
                <titleInfo>
                    <title><xsl:value-of select="$record/Title"/></title>
                </titleInfo>
                <xsl:for-each select="$record/Subject">
                    <xsl:if test=".!=''">
                    <subject>
                        <topic><xsl:value-of select="."/></topic>
                    </subject>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Description">
                    <xsl:if test=".!=''">
                        <note type="content"><xsl:value-of select="."/></note>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Creator">
                    <xsl:if test=".!=''">
                        <name>
                            <namePart><xsl:value-of select="."/></namePart>
                            <role>
                                <roleTerm type="text">creator</roleTerm>
                            </role>
                        </name>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Date">
                    <xsl:if test=".!=''">
                        <originInfo>
                            <dateCreated><xsl:value-of select="."/></dateCreated>
                        </originInfo>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Type">
                    <xsl:if test=".!=''">
                        <note><xsl:value-of select="."/></note>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/localid">
                    <xsl:if test=".!=''">
                        <identifier type="local"><xsl:value-of select="."/></identifier>
                    </xsl:if>
                </xsl:for-each>
            </mods>
        </xsl:result-document>
        <!-- 
            Title -> titleInfo/title
            Subject -> subject/topic
            Description -> note(@type=content?)
            Creator -> name/namePart and name/role/roleTerm(@type=text)creator
            Date -> originInfo/dateCreated(@keyDate=yes?)
            Type -> note(@type=?)
            localid -> identifier(@type=local)
            Print_Number ->
            Box_Number ->
            Source_Collection ->
            collection ->
        -->
    </xsl:template>
    
</xsl:stylesheet>