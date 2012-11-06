<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fbm="http://www.fedora.info/definitions/">

    <xsl:output method="xml" name="xml" indent="yes"/>

    <xsl:param name="fedorauriprefix" select="'info:fedora/'"/>
    <xsl:param name="contentmetadatafilepath"/>
    <xsl:param name="componentpidmasterfile"/>
    <xsl:param name="itemPrefix"/>
    <xsl:param name="fileGroupId" select="'GRP01'"/>
    <xsl:param name="fileGroupUse" select="'Master Image'"/>
    <xsl:param name="fileIdPrefix" select="'FILE'"/>
    <xsl:param name="fileNumberStart" select="11"/>
    <xsl:param name="fileNumberLength" select="3"/>
    <xsl:param name="fLocatLocType" select="'URL'"/>
    <xsl:param name="structMapType"/>
    <xsl:param name="div0Type"/>
    <xsl:param name="div1Type"/>

    <xsl:variable name="componentPidMaster" select="document($componentpidmasterfile)"/>

    <xsl:template match="/">
        <fbm:batchModify xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchModify.xsd">
            <xsl:apply-templates/>
        </fbm:batchModify>
    </xsl:template>

    <xsl:template match="//object">
        <xsl:variable name="itemid" select="identifier"/>
        <xsl:variable name="itemPid" select="pid"/>
        <xsl:variable name="metsfilename"
            select="concat('file://',$contentmetadatafilepath,$itemid,'.xml')"/>
        <xsl:if test="$itemPrefix = '' or starts-with($itemid,$itemPrefix)">
            <xsl:call-template name="writeContentMetadataDoc">
                <xsl:with-param name="itemid" select="$itemid"/>
                <xsl:with-param name="metsfilename" select="$metsfilename"/>
            </xsl:call-template>
            <xsl:call-template name="addContentMetadataDatastream">
                <xsl:with-param name="itemid" select="$itemid"/>
                <xsl:with-param name="itemPid" select="$itemPid"/>
                <xsl:with-param name="metsfilename" select="$metsfilename"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="addContentMetadataDatastream">
        <xsl:param name="itemid"/>
        <xsl:param name="itemPid"/>
        <xsl:param name="metsfilename"/>
        <fbm:addDatastream dsID="contentMetadata" dsLabel="Content Metadata for this object"
            dsMIME="text/xml" dsControlGroupType="M" dsState="A"
            logMessage="Create contentMetadata datastream">
            <xsl:attribute name="pid">
                <xsl:value-of select="$itemPid"/>
            </xsl:attribute>
            <xsl:attribute name="dsLocation" select="$metsfilename"/>
        </fbm:addDatastream>
    </xsl:template>

    <xsl:template name="writeContentMetadataDoc">
        <xsl:param name="itemid"/>
        <xsl:param name="metsfilename"/>
        <xsl:result-document href="{$metsfilename}" format="xml">
            <mets:mets xmlns:mets="http://www.loc.gov/METS/"
                xmlns:xlink="http://www.w3.org/1999/xlink">
                <mets:fileSec>
                    <mets:fileGrp>
                        <xsl:attribute name="ID" select="$fileGroupId"/>
                        <xsl:attribute name="USE" select="$fileGroupUse"/>
                        <xsl:for-each select="$componentPidMaster/objects/object[parentid=$itemid]">
                            <xsl:variable name="fileNumber"
                                select="substring(identifier,$fileNumberStart,$fileNumberLength)"/>
                            <mets:file>
                                <xsl:attribute name="ID" select="concat($fileIdPrefix,$fileNumber)"/>
                                <mets:FLocat>
                                    <xsl:attribute name="xlink:href" select="concat(pid,'/content')"/>
                                    <xsl:attribute name="LOCTYPE" select="$fLocatLocType"/>
                                </mets:FLocat>
                            </mets:file>
                        </xsl:for-each>
                    </mets:fileGrp>
                </mets:fileSec>
                <mets:structMap>
                    <xsl:if test="$structMapType != ''">
                        <xsl:attribute name="TYPE" select="$structMapType"/>
                    </xsl:if>
                    <mets:div>
                        <xsl:if test="$div0Type != ''">
                            <xsl:attribute name="TYPE" select="$div0Type"/>
                        </xsl:if>
                        <xsl:for-each select="$componentPidMaster/objects/object[parentid=$itemid]">
                            <xsl:variable name="fileNumber"
                                select="substring(identifier,$fileNumberStart,$fileNumberLength)"/>
                            <mets:div>
                                <xsl:if test="$div1Type != ''">
                                    <xsl:attribute name="TYPE" select="$div1Type"/>
                                </xsl:if>
                                <xsl:if test="$fileNumber castable as xs:integer">
                                    <xsl:attribute name="ORDER" select="number($fileNumber)"/>
                                </xsl:if>
                                <mets:fptr>
                                    <xsl:attribute name="FILEID"
                                        select="concat($fileIdPrefix,$fileNumber)"/>
                                </mets:fptr>
                            </mets:div>
                        </xsl:for-each>
                    </mets:div>
                </mets:structMap>
            </mets:mets>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
