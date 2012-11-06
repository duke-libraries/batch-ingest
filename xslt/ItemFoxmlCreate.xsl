<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Creates a FOXML document representing an Item object for ingest for ingest into Fedora, along with certain
    related files.
    
    Included XSL stylesheets:
        Common.xsl
    
    Source XML document: An item enumeration file identifying the items to be ingested.  The file should contain
        an  object element for each item.  The file is typically either constructed by hand or as a result 
        document of the CDMPreProc.xsl stylesheet if CONTENTdm metadata exists for the items).  Format of the
        item enumeration file is as follows:
        <objects>
            <object>
                <identifier/> # Required.  Item identifier.  E.g., kwlph010010010, viccb01.
                # Optional.  Any of the elements below, if the indicated file exists and has a file name other than
                    the item identifier with an .xml extension.  If used, the element contains the file name plus extension
                    but no path.
                <contentdmFilename/> # Name of the file comprising CONTENTdm metadata about the item. E.g., 
                    cdm_item01.xml.
                <marcxmlFilename/>  # Name of the file comprising metadata about the item in MARCXML format.  E.g.,
                    003018900.xml.
                <modsFilename/> # Name of the file comprising metadata about the item in MODS format.  E.g., 003018900.xml.
                <tripodmetsFilename/> # Name of the file comprising metadata about the item from Tripod2 in METS format.  E.g.,
                    viccb01001.xml.
            <object>
        <objects>
    
    Parameters:
        label: The label to be for the item object in Fedora.  Default is "Item".
        objectContentModel: The content model to be added as an attribute to the "object" element in the output XML document
            (the item master file).  Default is "info:fedora/afmodel:Item".
        [For additional parameters that can be provided, see included Common.xsl stylesheet.]
    
    Output XML document: The item master file.  The file is essentially a copy of the source XML document (the item
        enumeration file) with the addition of a "model" attribute to the "object" element and, optionally, an identifier for
        the "parent" of the item (typically the collection of which the item is a member).
    
    Additional results XML documents:
        FOXML document: To be used by Fedora batch ingest process to add the item object to the repository.
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:marcxml="http://www.loc.gov/MARC21/slim" xmlns:mods="http://www.loc.gov/mods/v3"
    xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchMerge.xsd"
    exclude-result-prefixes="marcxml mods xlink">

    <xsl:include href="Common.xsl"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="label">Item</xsl:param>
    <xsl:param name="objectContentModel">info:fedora/afmodel:Item</xsl:param>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="objects">
        <objects>
            <xsl:apply-templates/>
        </objects>
    </xsl:template>

    <xsl:template match="object">
        <xsl:variable name="identifier" select="identifier"/>
        <xsl:variable name="contentdmFilename">
            <xsl:choose>
                <xsl:when test="contentdmFilename and contentdmFilename != ''">
                    <xsl:value-of select="contentdmFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="foxmlFilename" select="concat($identifier,$xmlExtension)"/>
        <xsl:variable name="marcxmlFilename">
            <xsl:choose>
                <xsl:when test="marcxmlFilename and marcxmlFilename != ''">
                    <xsl:value-of select="marcxmlFilename"/>
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
        <xsl:variable name="tripodmetsFilename">
            <xsl:choose>
                <xsl:when test="tripodmetsFilename and tripodmetsFilename != ''">
                    <xsl:value-of select="tripodmetsFilename"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($identifier,$xmlExtension)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="contentdmFileURI"
            select="concat($itemContentdmPathURI,$contentdmFilename)"/>
        <xsl:variable name="foxmlFileURI" select="concat($itemFoxmlPathURI,$foxmlFilename)"/>
        <xsl:variable name="marcxmlFileURI" select="concat($itemMarcxmlPathURI,$marcxmlFilename)"/>
        <xsl:variable name="modsFileURI" select="concat($itemModsPathURI,$modsFilename)"/>
        <xsl:variable name="tripodmetsFileURI"
            select="concat($itemTripodmetsPathURI,$tripodmetsFilename)"/>
        <xsl:call-template name="writeFoxmlDoc">
            <xsl:with-param name="identifier" select="$identifier"/>
            <xsl:with-param name="foxmlFileURI" select="$foxmlFileURI"/>
            <xsl:with-param name="haveContentdm" select="$haveContentdm"/>
            <xsl:with-param name="contentdmFileURI" select="$contentdmFileURI"/>
            <xsl:with-param name="haveMarcxml" select="$haveMarcxml"/>
            <xsl:with-param name="marcxmlFileURI" select="$marcxmlFileURI"/>
            <xsl:with-param name="haveMods" select="$haveMods"/>
            <xsl:with-param name="modsFileURI" select="$modsFileURI"/>
            <xsl:with-param name="haveTripodmets" select="$haveTripodmets"/>
            <xsl:with-param name="tripodmetsFileURI" select="$tripodmetsFileURI"/>
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
        </object>
    </xsl:template>

    <xsl:template name="writeFoxmlDoc">
        <xsl:param name="identifier"/>
        <xsl:param name="foxmlFileURI"/>
        <xsl:param name="haveContentdm"/>
        <xsl:param name="contentdmFileURI"/>
        <xsl:param name="haveMarcxml"/>
        <xsl:param name="marcxmlFileURI"/>
        <xsl:param name="haveMods"/>
        <xsl:param name="modsFileURI"/>
        <xsl:param name="haveTripodmets"/>
        <xsl:param name="tripodmetsFileURI"/>
        <!--
        <xsl:variable name="marcxml">
            <xsl:if test="$haveMarcxml">
                <xsl:copy-of select="document($marcxmlFileURI)"/>
            </xsl:if>            
        </xsl:variable>
        <xsl:variable name="mods">
            <xsl:if test="$haveMods">
                <xsl:copy-of select="document($modsFileURI)"/>
            </xsl:if>
        </xsl:variable>        
        <xsl:variable name="tripodmets">
            <xsl:if test="$haveTripodmets">
                <xsl:copy-of select="document($tripodmetsFileURI)"/>
            </xsl:if>
        </xsl:variable>
-->
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
                    DC datastream
                -->
                <!--
                <foxml:datastream ID="DC" STATE="A" CONTROL_GROUP="X" VERSIONABLE="true">
                    <foxml:datastreamVersion ID="DC.0"
                        LABEL="Dublin Core Record for this object" MIMETYPE="text/xml"
                        FORMAT_URI="http://www.openarchives.org/OAI/2.0/oai_dc/">
                        <foxml:contentDigest TYPE="SHA-256"/>
                        <foxml:xmlContent>
                            <oai_dc:dc xmlns:dc="http://purl.org/dc/elements/1.1/">
                                <xsl:if test="$haveMods">
                                    <dc:title>
                                        <xsl:value-of select="$mods/mods:mods/mods:titleInfo[not(@type='alternative')]/mods:title"/>
                                    </dc:title>                                    
                                </xsl:if>
                                <xsl:if test="$identifier != ''">
                                    <dc:identifier>
                                        <xsl:value-of select="$identifier"/>
                                    </dc:identifier>
                                </xsl:if>
                                <xsl:if test="$haveMarcxml">
                                    <dc:identifier>
                                        <xsl:value-of select="$marcxml/marcxml:record/marcxml:controlfield[@tag='001']"/>
                                    </dc:identifier>
                                </xsl:if>
                                <xsl:if test="$haveTripodmets and ($tripodmets/mets/@ID != $identifier)">
                                    <dc:identifier>
                                        <xsl:value-of select="$tripodmets/mets/@ID"/>
                                    </dc:identifier>
                                </xsl:if>
                            </oai_dc:dc>
                        </foxml:xmlContent>
                    </foxml:datastreamVersion>
                </foxml:datastream>
-->
                <!--
                    contentdm datastream (if data from CONTENTdm is available)
                -->
                <xsl:if test="$haveContentdm">
                    <foxml:datastream ID="contentdm" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="contentdm.0"
                            LABEL="CONTENTdm Data for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$contentdmFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!--
                    marcXML datastream (if MARCXML data from Aleph is available)
                -->
                <xsl:if test="$haveMarcxml">
                    <foxml:datastream ID="marcXML" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="marcXML.0"
                            LABEL="MARCXML from Aleph for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$marcxmlFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    descMetadata datastream (if available)
                -->
                <xsl:if test="$haveMods">
                    <foxml:datastream ID="descMetadata" CONTROL_GROUP="M" STATE="A"
                        VERSIONABLE="true">
                        <foxml:datastreamVersion ID="descMetadata.0"
                            LABEL="Descriptive Metadata for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$modsFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
                <!-- 
                    tripodMets datastream (if Tripod METS data is available)
                -->
                <xsl:if test="$haveTripodmets">
                    <foxml:datastream ID="tripodMets" CONTROL_GROUP="M" STATE="A" VERSIONABLE="true">
                        <foxml:datastreamVersion ID="tripodMets.0"
                            LABEL="Tripod METS Data for this object" MIMETYPE="text/xml">
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$tripodmetsFileURI"/>
                            </foxml:contentLocation>
                        </foxml:datastreamVersion>
                    </foxml:datastream>
                </xsl:if>
            </foxml:digitalObject>
        </xsl:result-document>
    </xsl:template>
    <!-- writeFoxmlDoc -->

</xsl:stylesheet>
