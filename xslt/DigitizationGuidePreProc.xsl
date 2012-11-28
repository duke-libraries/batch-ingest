<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">

    <xsl:include href="Common.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    
    <xsl:param name="digitizationGuideFilePath"/>
    <xsl:param name="qdcFilePath"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="Root">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="Row">
        <xsl:call-template name="writeDigitizationGuideDoc">
            <xsl:with-param name="row" select="."/>
            <xsl:with-param name="digitizationGuideFileURI" select="concat($fileURIPrefix,$digitizationGuideFilePath,ID,$xmlExtension)"/>
        </xsl:call-template>
        <xsl:call-template name="writeQDCDoc">
            <xsl:with-param name="row" select="."/>
            <xsl:with-param name="qdcFileURI" select="concat($fileURIPrefix,$qdcFilePath,ID,$xmlExtension)"/>            
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="writeDigitizationGuideDoc">
        <xsl:param name="row"/>
        <xsl:param name="digitizationGuideFileURI"/>
        <xsl:result-document href="{$digitizationGuideFileURI}">
            <xsl:copy-of select="$row"/>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template name="writeQDCDoc">
        <xsl:param name="row"/>
        <xsl:param name="qdcFileURI"/>
        <xsl:result-document href="{$qdcFileURI}">
            <dc xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <dcterms:title>
                    <xsl:value-of select="Title"/>
                </dcterms:title>
                <dcterms:identifier>
                    <xsl:value-of select="ID"/>
                </dcterms:identifier>                
            </dc>
        </xsl:result-document>        
    </xsl:template>
    
</xsl:stylesheet>