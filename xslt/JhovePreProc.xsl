<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:jhove="http://hul.harvard.edu/ois/xml/ns/jhove" exclude-result-prefixes="jhove">
    <xsl:include href="Common.xsl"/>
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="jhoveFilePath"/>
    <xsl:param name="model"/>
    <xsl:param name="parentId"/>
    <xsl:param name="autoParentId"/>
    <xsl:param name="autoParentIdLength"/>
    <xsl:param name="haveChecksum"/>
    <xsl:param name="checksumFilePath"/>
    <xsl:variable name="modelURI" select="concat($fedoraURIPrefix,$model)"/>
    <xsl:template match="/">
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="jhove:jhove">
        <xsl:variable name="checksums">
            <xsl:if test="$haveChecksum">
                <xsl:copy-of select="document(concat($fileURIPrefix,$checksumFilePath))"/>
            </xsl:if>
        </xsl:variable>
        <objects>
            <xsl:apply-templates>
                <xsl:with-param name="dateNode" select="jhove:date"/>
                <xsl:with-param name="checksums" select="$checksums"/>
            </xsl:apply-templates>
        </objects>
    </xsl:template>
    <xsl:template match="jhove:repInfo">
        <xsl:param name="dateNode"/>
        <xsl:param name="checksums"/>
        <xsl:variable name="sourceFilename" select="tokenize(@uri, '/')[last()]"/>
        <xsl:if
            test="(substring-after($sourceFilename, '.') = 'tif') or (substring-after($sourceFilename, '.') = 'pdf')">
            <xsl:variable name="jhoveFilename" select="concat($sourceFilename,$xmlExtension)"/>
            <xsl:variable name="jhoveFileURI" select="concat($fileURIPrefix,$jhoveFilePath,$jhoveFilename)"/>
            <xsl:result-document href="{$jhoveFileURI}">
                <jhove xmlns="http://hul.harvard.edu/ois/xml/ns/jhove">
                    <xsl:for-each select="./parent::*/@*">
                        <xsl:attribute name="{name(.)}">
                            <xsl:value-of select="."/>
                        </xsl:attribute>
                    </xsl:for-each>
                    <xsl:copy-of select="$dateNode"/>
                    <xsl:copy-of select="."/>
                </jhove>
            </xsl:result-document>
            <xsl:variable name="objectId">
                <xsl:value-of select="substring-before($sourceFilename, '.')"/>
            </xsl:variable>
            <object>
                <xsl:attribute name="model" select="$modelURI"/>
                <identifier>
                    <xsl:value-of select="$objectId"/>
                </identifier>
                <jhoveFilename>
                    <xsl:value-of select="$jhoveFilename"/>
                </jhoveFilename>
                <filepath>
                    <xsl:value-of select="@uri"/>
                </filepath>
                <mimetype>
                    <xsl:value-of select="jhove:mimeType"/>
                </mimetype>
                <xsl:if test="$parentId or $autoParentId">
                    <parentid>
                        <xsl:choose>
                            <xsl:when test="$parentId">
                                <xsl:value-of select="$parentId"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of
                                    select="substring($objectId,1,number($autoParentIdLength))"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </parentid>
                </xsl:if>
                <xsl:if test="$haveChecksum">
                    <checksum source="dpc">
                        <type>
                            <xsl:value-of
                                select="$checksums/checksums/checksum[componentid=$objectId]/type"/>
                        </type>
                        <value>
                            <xsl:value-of
                                select="$checksums/checksums/checksum[componentid=$objectId]/value"/>
                        </value>
                    </checksum>
                </xsl:if>
            </object>
        </xsl:if>
    </xsl:template>
    <xsl:template match="jhove:date"></xsl:template>
</xsl:stylesheet>
