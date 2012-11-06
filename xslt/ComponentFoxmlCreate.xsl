<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:jhove="http://hul.harvard.edu/ois/xml/ns/jhove"
    xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchMerge.xsd"
    exclude-result-prefixes="jhove xlink">

    <xsl:include href="Common.xsl"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="label">Component</xsl:param>
    <xsl:param name="objectContentModel">info:fedora/afmodel:Component</xsl:param>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="objects">
        <xsl:variable name="checksums">
            <xsl:if test="$haveChecksum">
                <xsl:copy-of select="document($componentChecksumFileURI)"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="digitizationGuide">
            <xsl:if test="$haveDigitizationguide">
                <xsl:copy-of select="document($componentDigitizationguideFileURI)"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="dpcMetadata">
            <xsl:if test="$haveDpcmetadata">
                <xsl:copy-of select="document($componentDpcmetadataFileURI)"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="fmpExport">
            <xsl:if test="$haveFmpexport">
                <xsl:copy-of select="document($componentFmpexportFileURI)"/>
            </xsl:if>
        </xsl:variable>
        <objects>
            <xsl:apply-templates>
                <xsl:with-param name="checksums" select="$checksums"/>
                <xsl:with-param name="digitizationGuide" select="$digitizationGuide"/>
                <xsl:with-param name="dpcMetadata" select="$dpcMetadata"/>
                <xsl:with-param name="fmpExport" select="$fmpExport"/>
            </xsl:apply-templates>
        </objects>
    </xsl:template>

    <xsl:template match="object">
        <xsl:param name="checksums"/>
        <xsl:param name="digitizationGuide"/>
        <xsl:param name="dpcMetadata"/>
        <xsl:param name="fmpExport"/>
        <xsl:variable name="identifier" select="identifier"/>
        <xsl:variable name="digitizationguideFilename">
            <xsl:choose>
                <xsl:when test="digitizationguideFilename and digitizationguideFilename != ''">
                    <xsl:value-of select="digitizationguideFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dpcmetadataFilename">
            <xsl:choose>
                <xsl:when test="dpcmetadataFilename and dpcmetadataFilename != ''">
                    <xsl:value-of select="dpcmetadataFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="fmpexportFilename">
            <xsl:choose>
                <xsl:when test="fmpexportFilename and fmpexportFilename != ''">
                    <xsl:value-of select="fmpexportFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="foxmlFilename" select="concat($identifier,$xmlExtension)"/>
        <xsl:variable name="jhoveFilename">
            <xsl:choose>
                <xsl:when test="jhoveFilename and jhoveFilename != ''">
                    <xsl:value-of select="jhoveFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="modsFilename">
            <xsl:choose>
                <xsl:when test="modsFilename and modsFilename != ''">
                    <xsl:value-of select="modsFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="digitizationguideFileURI"
            select="concat($componentDigitizationguidePathURI,$digitizationguideFilename)"/>
        <xsl:variable name="dpcmetadataFileURI"
            select="concat($componentDpcmetadataPathURI,$dpcmetadataFilename)"/>
        <xsl:variable name="fmpexportFileURI"
            select="concat($componentFmpexportPathURI,$fmpexportFilename)"/>
        <xsl:variable name="foxmlFileURI" select="concat($componentFoxmlPathURI,$foxmlFilename)"/>
        <xsl:variable name="jhoveFileURI" select="concat($componentJhovePathURI,$jhoveFilename)"/>
        <xsl:variable name="modsFileURI" select="concat($componentModsPathURI,$modsFilename)"/>
        <xsl:variable name="digitizationGuideRow">
            <xsl:if test="$haveDigitizationguide">
                <xsl:copy-of select="$digitizationGuide//Row[ID = $identifier]"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="title">
            <xsl:if test="$haveDigitizationguide">
                <xsl:value-of select="$digitizationGuideRow//Title"/>
            </xsl:if>            
        </xsl:variable>
        <xsl:if test="$haveDigitizationguide">
            <xsl:call-template name="writeDigitizationGuideDoc">
                <xsl:with-param name="digitizationGuideFileURI" select="$digitizationguideFileURI"/>
                <xsl:with-param name="digitizationGuideRow"
                    select="$digitizationGuideRow"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="$haveFmpexport">
            <xsl:call-template name="writeFmpExportDoc">
                <xsl:with-param name="fmpExportFileURI" select="$fmpexportFileURI"/>
                <xsl:with-param name="fmpExportRow" select="fmpExport//Row[ID = $identifier]"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:call-template name="writeModsDoc">
            <xsl:with-param name="modsFileURI" select="$modsFileURI"/>
            <xsl:with-param name="identifier" select="$identifier"/>
            <xsl:with-param name="title" select="$title"/>
        </xsl:call-template>
        <xsl:call-template name="writeFoxmlDoc">
            <xsl:with-param name="identifier" select="$identifier"/>
            <xsl:with-param name="foxmlFileURI" select="$foxmlFileURI"/>
            <xsl:with-param name="haveContent" select="$haveContent"/>
            <xsl:with-param name="haveDigitizationguide" select="$haveDigitizationguide"/>
            <xsl:with-param name="digitizationguideFileURI" select="$digitizationguideFileURI"/>
            <xsl:with-param name="haveDpcmetadata" select="$haveDpcmetadata"/>
            <xsl:with-param name="dpcmetadataFileURI" select="$dpcmetadataFileURI"/>
            <xsl:with-param name="haveFmpexport" select="$haveFmpexport"/>
            <xsl:with-param name="fmpexportFileURI" select="$fmpexportFileURI"/>
            <xsl:with-param name="haveJhove" select="$haveJhove"/>
            <xsl:with-param name="jhoveFileURI" select="$jhoveFileURI"/>
            <xsl:with-param name="haveMods" select="$haveMods"/>
            <xsl:with-param name="modsFileURI" select="$modsFileURI"/>
        </xsl:call-template>
        <object>
            <xsl:attribute name="model" select="$objectContentModel"/>
            <xsl:copy-of select="node()"/>
            <xsl:if test="$parentId or $autoParentId">
                <parentid>
                    <xsl:choose>
                        <xsl:when test="$parentId">
                            <xsl:value-of select="$parentId"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="substring($identifier,1,number($autoParentIdLength))"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </parentid>
            </xsl:if>
            <xsl:if test="$haveChecksum">
                <checksum source="dpc">
                    <type>
                        <xsl:value-of
                            select="$checksums/checksums/checksum[componentid=$identifier]/type"/>
                    </type>
                    <value>
                        <xsl:value-of
                            select="$checksums/checksums/checksum[componentid=$identifier]/value"/>
                    </value>
                </checksum>
            </xsl:if>
        </object>
    </xsl:template>

    <xsl:template name="writeModsDoc">
        <xsl:param name="modsFileURI"/>
        <xsl:param name="identifier"/>
        <xsl:param name="title"/>
        <xsl:result-document href="{$modsFileURI}">
            <mods xmlns="http://www.loc.gov/mods/v3"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="3.4"
                xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-4.xsd">
                <xsl:if test="$title != ''">
                    <titleInfo>
                        <title><xsl:value-of select="$title"/></title>
                    </titleInfo>
                </xsl:if>
                <xsl:if test="$identifier != ''">
                    <identifier type="local"><xsl:value-of select="$identifier"/></identifier>
                </xsl:if>
            </mods>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="writeDigitizationGuideDoc">
        <xsl:param name="digitizationGuideFileURI"/>
        <xsl:param name="digitizationGuideRow"/>
        <xsl:result-document href="{$digitizationGuideFileURI}">
            <xsl:copy-of select="$digitizationGuideRow"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="writeFmpExportDoc">
        <xsl:param name="fmpExportFileURI"/>
        <xsl:param name="fmpExportRow"/>
        <xsl:result-document href="{$fmpExportFileURI}">
            <xsl:copy-of select="$fmpExportRow"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template name="writeFoxmlDoc">
        <xsl:param name="identifier"/>
        <xsl:param name="foxmlFileURI"/>
        <xsl:param name="haveContent"/>
        <xsl:param name="haveDigitizationguide"/>
        <xsl:param name="digitizationguideFileURI"/>
        <xsl:param name="haveDpcmetadata"/>
        <xsl:param name="dpcmetadataFileURI"/>
        <xsl:param name="haveFmpexport"/>
        <xsl:param name="fmpexportFileURI"/>
        <xsl:param name="haveJhove"/>
        <xsl:param name="jhoveFileURI"/>
        <xsl:param name="haveMods"/>
        <xsl:param name="modsFileURI"/>

        <xsl:result-document href="{$foxmlFileURI}">
            <foxml:digitalObject VERSION="1.1" xmlns:foxml="info:fedora/fedora-system:def/foxml#"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xsi:schemaLocation="info:fedora/fedora-system:def/foxml# http://www.fedora.info/definitions/1/0/foxml1-1.xsd">
                <!-- 
                    Properties
                -->
                <foxml:objectProperties>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#state">
                        <xsl:attribute name="VALUE" select="$defaultObjectState"/>
                    </foxml:property>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#label">
                        <xsl:attribute name="VALUE" select="$label"/>
                    </foxml:property>
                    <foxml:property NAME="info:fedora/fedora-system:def/model#ownerId">
                        <xsl:attribute name="VALUE" select="$defaultObjectOwner"/>
                    </foxml:property>
                </foxml:objectProperties>
                <!--
                    content datastream (if content is available)
                -->
                <xsl:if test="$haveContent">
                    <foxml:datastream ID="content" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="content.0" LABEL="Content for this object">
                            <xsl:attribute name="MIMETYPE" select="mimetype"/>
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="concat($fileURIPrefix,filepath)"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!--
                    descMetadata datastream (if Mods descriptive metadata is available)
                -->
                <xsl:if test="$haveMods">
                    <foxml:datastream ID="descMetadata" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="descMetadata.0" LABEL="Descriptive Metadata for this object"
                            MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$modsFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    digitizationGuide datastream (if digitization guide data is available)
                -->
                <xsl:if test="$haveDigitizationguide">
                    <foxml:datastream ID="digitizationGuide" CONTROL_GROUP="M" STATE="A"
                        VERSIONABLE="true">
                        <foxml:datastreamVersion ID="digitizationGuide.0"
                            LABEL="Digitization Guide data for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$digitizationguideFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    dpcMetadata datastream (if DPC metadata is available)
                -->
                <xsl:if test="$haveDpcmetadata">
                    <foxml:datastream ID="dpcMetadata" CONTROL_GROUP="M" STATE="A"
                        VERSIONABLE="true">
                        <foxml:datastreamVersion ID="dpcMetadata.0"
                            LABEL="DPC metadata for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$dpcmetadataFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    fmpExport datastream (if FileMaker Pro export data is available)
                -->
                <xsl:if test="$haveFmpexport">
                    <foxml:datastream ID="fmpExport" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="fmpExport.0"
                            LABEL="FileMaker Pro export data for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$fmpexportFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    JHOVE datastream (if JHOVE data is available)
                -->
                <xsl:if test="$haveJhove">
                    <foxml:datastream ID="JHOVE" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="JHOVE.0" LABEL="JHOVE data" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$jhoveFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
            </foxml:digitalObject>
        </xsl:result-document>
    </xsl:template>

</xsl:stylesheet>
