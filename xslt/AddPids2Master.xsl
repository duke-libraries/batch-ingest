<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    
    <xsl:output method="xml" indent="yes"/>
        
    <xsl:param name="collectioncode"/>
    <xsl:param name="objecttype"/>
    <xsl:param name="ingestLogFile" select="concat('file:///srv/fedora-working/ingest/',$collectioncode,'/logs/ingest-',$objecttype,'.log')"/>
    <xsl:param name="path2objectPrefix" select="concat('/srv/fedora-working/ingest/',$collectioncode,'/',$objecttype,'/foxml/')"/>
    <xsl:param name="path2objectExtension" select="'.xml'"/>

    <xsl:variable name="ingestLog" select="document($ingestLogFile)"/>
    
    <xsl:template match="/">
        <objects>
            <xsl:for-each select="//object">
                <xsl:variable name="identifier" select="identifier"/>
                <xsl:variable name="path2object" select="concat($path2objectPrefix,$identifier,$path2objectExtension)"/>
                <object>
                    <xsl:attribute name="model" select="@model"/>
                    <xsl:copy-of select="node()"/>
                    <xsl:element name="pid">
                        <xsl:value-of select="$ingestLog/object-processing-map/map[@path2object=$path2object]/@pid"/>
                    </xsl:element>
                </object>
            </xsl:for-each>
        </objects>
    </xsl:template>
    
</xsl:stylesheet>
