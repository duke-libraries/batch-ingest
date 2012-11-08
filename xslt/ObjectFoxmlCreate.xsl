<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:include href="Common.xsl"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="foxmlFilePath"/>
    <xsl:param name="label"/>
    <xsl:param name="objectState" select="$defaultObjectState"/>
    <xsl:param name="objectOwner" select="$defaultObjectOwner"/>

    <xsl:template match="/">
        <log>
        <xsl:apply-templates/>
        </log>
    </xsl:template>

    <xsl:template match="objects">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="object">
        <xsl:variable name="identifier" select="identifier"/>
        <xsl:variable name="foxmlFilename" select="concat($identifier,$xmlExtension)"/>
        <xsl:variable name="foxmlFileURI" select="concat($fileURIPrefix,$foxmlFilePath,$foxmlFilename)"/>
        <xsl:call-template name="writeFoxmlDoc">
            <xsl:with-param name="identifier" select="$identifier"/>
            <xsl:with-param name="foxmlFileURI" select="$foxmlFileURI"/>
        </xsl:call-template>
        <log-entry>
            <identifier><xsl:value-of select="$identifier"/></identifier>
            <foxmlFileURI><xsl:value-of select="$foxmlFileURI"/></foxmlFileURI>
        </log-entry>
    </xsl:template>
    
    <xsl:template name="writeFoxmlDoc">
        <xsl:param name="identifier"/>
        <xsl:param name="foxmlFileURI"/>
        <xsl:result-document href="{$foxmlFileURI}">
            <foxml:digitalObject VERSION="1.1" xmlns:foxml="info:fedora/fedora-system:def/foxml#"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-1.xsd">
                <foxml:objectProperties>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#state">
                        <xsl:attribute name="VALUE" select="$objectState"/>
                    </foxml:property>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#label">
                        <xsl:attribute name="VALUE" select="$label"/>
                    </foxml:property>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#ownerId">
                        <xsl:attribute name="VALUE" select="$objectOwner"/>
                    </foxml:property>
                </foxml:objectProperties>
            </foxml:digitalObject>            
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
