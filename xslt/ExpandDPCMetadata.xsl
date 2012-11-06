<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    version="2.0">
    
    <xsl:variable name="newline">
        <xsl:text>&#xa;</xsl:text>
    </xsl:variable>
    
    <xsl:output method="xml" indent="yes" />
    
    <xsl:template match="/">
        <Root>
        <xsl:for-each select="//Row">
            <xsl:variable name="count" select="Count"/>
            <xsl:call-template name="expand">
                <xsl:with-param name="count" select="$count"/>
            </xsl:call-template>
        </xsl:for-each>
        </Root>            
    </xsl:template>
    
    <xsl:template name="expand">
        <xsl:param name="index" select="1"/>
        <xsl:param name="count"/>
        <Row>
            <xsl:copy-of select="*[not(name()='Count')]"/>
        </Row>
        <xsl:if test="$index &lt; number($count)">
            <xsl:call-template name="expand">
                <xsl:with-param name="index" select="$index + 1"/>
                <xsl:with-param name="count" select="$count"></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>