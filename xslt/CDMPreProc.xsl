<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

    <xsl:include href="Common.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="basepath"/>
    <xsl:param name="collectionmodel"/>
    <xsl:param name="itemmodel"/>
    <xsl:variable name="basePathURI" select="concat($fileURIPrefix,$basepath)"/>
    <xsl:variable name="collectionModelURI" select="concat($fedoraURIPrefix,$collectionmodel)"/>
    <xsl:variable name="itemModelURI" select="concat($fedoraURIPrefix,$itemmodel)"/>
    
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
        <xsl:variable name="masterFileURI" select="concat($basePathURI,'collection/master/master',$xmlExtension)"/>
        <xsl:result-document href="{$masterFileURI}">
            <objects>
            <xsl:for-each select="$records">
                <object>
                    <xsl:attribute name="model" select="$collectionModelURI"/>
                    <identifier><xsl:value-of select="localid"/></identifier>
                </object>
                <xsl:call-template name="writeContentdmDoc">
                    <xsl:with-param name="record" select="."/>
                    <xsl:with-param name="contentdmFileURI" select="concat($basePathURI,'collection/contentdm/',localid,$xmlExtension)"/>
                </xsl:call-template>
                <xsl:call-template name="writeQDCDoc">
                    <xsl:with-param name="record" select="."/>
                    <xsl:with-param name="qdcFileURI" select="concat($basePathURI,'collection/qdc/',localid,$xmlExtension)"/>
                </xsl:call-template>
            </xsl:for-each>
            </objects>            
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="processCdmItemNodes">
        <xsl:param name="records"/>
        <xsl:variable name="masterFileURI" select="concat($basePathURI,'item/master/master',$xmlExtension)"/>
        <xsl:result-document href="{$masterFileURI}">
            <objects>
                <xsl:for-each select="$records">
                    <object>
                        <xsl:attribute name="model" select="$itemModelURI"/>
                        <identifier><xsl:value-of select="localid"/></identifier>
                    </object>
                    <xsl:call-template name="writeContentdmDoc">
                        <xsl:with-param name="record" select="."/>
                        <xsl:with-param name="contentdmFileURI" select="concat($basePathURI,'item/contentdm/',localid,$xmlExtension)"/>
                    </xsl:call-template>
                    <xsl:call-template name="writeQDCDoc">
                        <xsl:with-param name="record" select="."/>
                        <xsl:with-param name="qdcFileURI" select="concat($basePathURI,'item/qdc/',localid,$xmlExtension)"/>
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
    
    <xsl:template name="writeQDCDoc">
        <xsl:param name="record"/>
        <xsl:param name="qdcFileURI"/>
        <xsl:result-document href="{$qdcFileURI}">
            <dc xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <dcterms:title><xsl:value-of select="$record/Title"/></dcterms:title>
                <xsl:for-each select="$record/Subject">
                    <xsl:if test=".!=''">
                        <dcterms:subject><xsl:value-of select="."/></dcterms:subject>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Description">
                    <xsl:if test=".!=''">
                        <dcterms:description><xsl:value-of select="."/></dcterms:description>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Creator">
                    <xsl:if test=".!=''">
                        <dcterms:creator><xsl:value-of select="."/></dcterms:creator>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Date">
                    <xsl:if test=".!=''">
                        <dcterms:date><xsl:value-of select="."/></dcterms:date>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/Type">
                    <xsl:if test=".!=''">
                        <dcterms:type><xsl:value-of select="."/></dcterms:type>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="$record/localid">
                    <xsl:if test=".!=''">
                        <dcterms:identifier><xsl:value-of select="."/></dcterms:identifier>
                    </xsl:if>
                </xsl:for-each>
            </dc>
        </xsl:result-document>
   </xsl:template>
    
</xsl:stylesheet>