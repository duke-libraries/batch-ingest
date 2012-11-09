<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0"
    xmlns:fbm="http://www.fedora.info/definitions/">
    
    <xsl:include href="Common.xsl"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="add" select="'add'"/>
    <xsl:variable name="modify" select="'modify'"/>
    
    <xsl:param name="addModify" select="$add"/>
    
    <xsl:param name="dsLocationPath"/>
    <xsl:param name="dsFilenameElement"/>
    
    <xsl:param name="pid"/>
    <xsl:param name="dsId"/>
    <xsl:param name="dsLabel"/>
    <xsl:param name="dsMimeType"/>
    <xsl:param name="dsFormatURI"/>
    <xsl:param name="dsControlGroupType"/>
    <xsl:param name="dsState"/>
    <xsl:param name="dsVersionable"/>
    <xsl:param name="dsAltIds"/>
    <xsl:param name="dsChecksumType"/>
    <xsl:param name="dsChecksum"/>
    <xsl:param name="logMessage"/>

    <xsl:variable name="defaultDsMimeType" select="$xmlMimetype"/>
    <xsl:variable name="defaultDsControlGroupType" select="$managedControlGroupType"/>
    <xsl:variable name="defaultDsState" select="$activeState"/>
    <xsl:variable name="defaultDsVersionable" select="true"/>
    <xsl:variable name="defaultDsChecksumType" select="$sha256ChecksumType"/>
    
    <xsl:variable name="addDatastreamElement" select="'fbm:addDatastream'"/>
    <xsl:variable name="modifyDatastreamElement" select="'fbm:modifyDatastream'"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="objects">
        <fbm:batchModify xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchModify.xsd">
            <xsl:apply-templates/>
        </fbm:batchModify>
    </xsl:template>
    
    <xsl:template match="object">
        <xsl:variable name="dsFilename">
            <xsl:choose>
                <xsl:when test="$dsFilenameElement = ''">
                    <xsl:value-of select="concat(identifier,$xmlExtension)"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="./*[name()=$dsFilenameElement]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="dsLocationURI" select="concat($fileURIPrefix,$dsLocationPath,$dsFilename)"/>
        <xsl:variable name="dsMimeTypeToUse">
            <xsl:choose>
                <xsl:when test="$dsMimeType != ''">
                    <xsl:value-of select="$dsMimeType"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="ends-with($dsLocationURI,$pdfExtension)">
                            <xsl:value-of select="$pdfMimetype"/>
                        </xsl:when>
                        <xsl:when test="ends-with($dsLocationURI,$xlsExtension)">
                            <xsl:value-of select="$xlsMimetype"/>
                        </xsl:when>
                        <xsl:when test="ends-with($dsLocationURI,$xlsxExtension)">
                            <xsl:value-of select="$xlsxMimetype"/>
                        </xsl:when>
                        <xsl:when test="ends-with($dsLocationURI,$xmlExtension)">
                            <xsl:value-of select="$xmlMimetype"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$addModify = $add">
                <xsl:element name="{$addDatastreamElement}">
                    <xsl:call-template name="constructDatastream">
                        <xsl:with-param name="object" select="."/>
                        <xsl:with-param name="dsLocationURI" select="$dsLocationURI"/>
                        <xsl:with-param name="dsMimeTypeToUse" select="$dsMimeTypeToUse"/>
                        <xsl:with-param name="dsControlGroupTypeToUse">
                            <xsl:choose>
                                <xsl:when test="$dsControlGroupType != ''">
                                    <xsl:value-of select="$dsControlGroupType"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$defaultDsControlGroupType"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="dsStateToUse">
                            <xsl:choose>
                                <xsl:when test="$dsState != ''">
                                    <xsl:value-of select="$dsState"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$defaultDsState"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="dsVersionableToUse">
                            <xsl:choose>
                                <xsl:when test="$dsVersionable != ''">
                                    <xsl:value-of select="$dsVersionable"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$defaultDsVersionable"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                        <xsl:with-param name="dsChecksumTypeToUse">
                            <xsl:choose>
                                <xsl:when test="$dsChecksumType != ''">
                                    <xsl:value-of select="$dsChecksumType"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$defaultDsChecksumType"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:element>
            </xsl:when>
            <xsl:when test="$addModify = $modify">
                <xsl:element name="{$modifyDatastreamElement}">
                    <xsl:call-template name="constructDatastream">
                        <xsl:with-param name="object" select="."/>
                        <xsl:with-param name="dsLocationURI" select="$dsLocationURI"/>
                        <xsl:with-param name="dsMimeTypeToUse" select="$dsMimeTypeToUse"/>
                        <xsl:with-param name="dsControlGroupTypeToUse" select="$dsControlGroupType"/>
                        <xsl:with-param name="dsStateToUse" select="$dsState"/>
                        <xsl:with-param name="dsVersionableToUse" select="$dsVersionable"/>
                        <xsl:with-param name="dsChecksumTypeToUse" select="$dsChecksumType"/>
                    </xsl:call-template>
                </xsl:element>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="constructDatastream">
        <xsl:param name="object"/>
        <xsl:param name="dsLocationURI"/>
        <xsl:param name="dsMimeTypeToUse"/>
        <xsl:param name="dsControlGroupTypeToUse"/>
        <xsl:param name="dsStateToUse"/>
        <xsl:param name="dsVersionableToUse"/>
        <xsl:param name="dsChecksumTypeToUse"/>
        <xsl:attribute name="pid" select="$pid"/>
        <xsl:attribute name="dsID" select="$dsId"/>
        <xsl:if test="$dsLabel != ''">
            <xsl:attribute name="dsLabel" select="$dsLabel"/>            
        </xsl:if>
        <xsl:if test="$dsMimeTypeToUse != ''">
            <xsl:attribute name="dsMIME" select="$dsMimeTypeToUse"/>
        </xsl:if>
        <xsl:if test="$dsFormatURI != ''">
            <xsl:attribute name="formatURI" select="$dsFormatURI"/>            
        </xsl:if>
        <xsl:if test="$dsVersionableToUse != ''">
            <xsl:attribute name="versionable" select="$dsVersionableToUse"/>
        </xsl:if>
        <xsl:if test="$dsAltIds != ''">
            <xsl:attribute name="altIDs" select="$dsAltIds"/>            
        </xsl:if>
        <xsl:if test="$dsControlGroupTypeToUse = $externalControlGroupType or $dsControlGroupTypeToUse = $managedControlGroupType or $dsControlGroupTypeToUse = $redirectControlGroupType">
            <xsl:attribute name="dsLocation" select="$dsLocationURI"/>
        </xsl:if>
        <xsl:if test="$dsControlGroupTypeToUse != ''">
            <xsl:attribute name="dsControlGroupType" select="$dsControlGroupTypeToUse"/>
        </xsl:if>
        <xsl:if test="$dsStateToUse != ''">
            <xsl:attribute name="dsState" select="$dsStateToUse"/>
        </xsl:if>
        <xsl:if test="$dsChecksumTypeToUse != ''">
            <xsl:attribute name="checksumType" select="$dsChecksumTypeToUse"/>
        </xsl:if>
        <!-- checksum -->
        <xsl:if test="$logMessage != ''">
            <xsl:attribute name="logMessage" select="$logMessage"/>            
        </xsl:if>
        <xsl:if test="$dsControlGroupTypeToUse = $inlineControlGroupType">
            <xsl:variable name="xmlDocument" select="document($dsLocationURI)"/>
            <fbm:xmlData>
                <xsl:copy-of select="$xmlDocument"/>
            </fbm:xmlData>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>