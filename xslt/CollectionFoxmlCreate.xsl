<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Creates a FOXML document representing a Collection object for ingest for ingest into Fedora, along with certain
    related files.
    
    Included XSL stylesheets:
        Common.xsl
    
    Source XML document: A collection enumeration file identifying the collection to be ingested.  The file will typically
        contain one object element (representing the collection).  The file is typically constructed by hand.  Format of the
        collection enumeration file is as follows:
        <objects>
            <object>
                <identifier/> # Required.  Collection identifier.  E.g., kwilecki, viccb.
                # Optional.  Any of the elements below, if the indicated file exists and has a file name other than
                    the collection identifier with an .xml extension.  If used, the element contains the file name plus extension
                    but no path.
                <contentdmFilename/> # Name of the file comprising CONTENTdm metadata about the collection itself. E.g., 
                    cdm_coll.xml.
                <digitizationguideFilename/> # Name of the file containing the DPC digitization guide for the collection as a
                    whole (i.e., all components).  E.g., digguide_kwilecki_photographs.xls, Vica_Items.xls.
                <dpcmetadataFilename/> # Name of the file containing additional DPC metadata for the collection as whole
                    (i.e., all components).  E.g., Kwilecki_10_24_2012.xls.
                <fmpexportFilename/> # Name of the file containing a FileMaker Pro export for the collection as a whole (i.e.,
                    all components).  E.g., Kwilecki_10_24_2012.xml.
                <marcxmlFilename/>  # Name of the file comprising metadata about the collection in MARCXML format.  E.g.,
                    002510132.xml.
                <modsFilename/> # Name of the file comprising metadata about the collection in MODS format.  E.g., vica.xml.
                <tripodmetsFilename/> # Name of the file comprising metadata about the collection from Tripod2 in METS format.  E.g.,
                    vica.xml.
            <object>
        <objects>
        
    Parameters:
        label: The label to be for the collection object in Fedora.  Default is "Collection".
        objectContentModel: The content model to be added as an attribute to the "object" element in the output XML document
            (the collection master file).  Default is "info:fedora/afmodel:Collection".
        [For additional parameters that can be provided, see included Common.xsl stylesheet.]
        
    Output XML document: The collection master file.  The file is essentially a copy of the source XML document (the collection
        enumeration file) with the addition of a "model" attribute to the "object" element and, optionally, an identifier for
        the "parent" of the collection if one is provided (usually not relevant for a collection, which typically has no parent).
        
    Additional results XML documents:
        FOXML document: To be used by Fedora batch ingest process to add the collection object to the repository.
-->
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:marcxml="http://www.loc.gov/MARC21/slim" xmlns:mods="http://www.loc.gov/mods/v3"
    xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchMerge.xsd"
    exclude-result-prefixes="marcxml mods xlink">

    <xsl:include href="Common.xsl"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="label">Collection</xsl:param>
    <xsl:param name="objectContentModel">info:fedora/afmodel:Collection</xsl:param>

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
            select="concat($collectionContentdmPathURI,$contentdmFilename)"/>
        <xsl:variable name="digitizationguideFileURI"
            select="concat($collectionDigitizationguidePathURI,$digitizationguideFilename)"/>
        <xsl:variable name="dpcmetadataFileURI"
            select="concat($collectionDpcmetadataPathURI,$dpcmetadataFilename)"/>
        <xsl:variable name="fmpexportFileURI"
            select="concat($collectionFmpexportPathURI,$fmpexportFilename)"/>
        <xsl:variable name="foxmlFileURI" select="concat($collectionFoxmlPathURI,$foxmlFilename)"/>
        <xsl:variable name="marcxmlFileURI"
            select="concat($collectionMarcxmlPathURI,$marcxmlFilename)"/>
        <xsl:variable name="modsFileURI" select="concat($collectionModsPathURI,$modsFilename)"/>
        <xsl:variable name="tripodmetsFileURI"
            select="concat($collectionTripodmetsPathURI,$tripodmetsFilename)"/>
        <xsl:call-template name="writeFoxmlDoc">
            <xsl:with-param name="identifier" select="$identifier"/>
            <xsl:with-param name="foxmlFileURI" select="$foxmlFileURI"/>
            <xsl:with-param name="haveContentdm" select="$haveContentdm"/>
            <xsl:with-param name="contentdmFileURI" select="$contentdmFileURI"/>
            <xsl:with-param name="haveDigitizationguide" select="$haveDigitizationguide"/>
            <xsl:with-param name="digitizationguideFileURI" select="$digitizationguideFileURI"/>
            <xsl:with-param name="haveDpcmetadata" select="$haveDpcmetadata"/>
            <xsl:with-param name="dpcmetadataFileURI" select="$dpcmetadataFileURI"/>
            <xsl:with-param name="haveFmpexport" select="$haveFmpexport"/>
            <xsl:with-param name="fmpexportFileURI" select="$fmpexportFileURI"/>
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
        <xsl:param name="haveDigitizationguide"/>
        <xsl:param name="digitizationguideFileURI"/>
        <xsl:param name="haveDpcmetadata"/>
        <xsl:param name="dpcmetadataFileURI"/>
        <xsl:param name="haveFmpexport"/>
        <xsl:param name="fmpexportFileURI"/>
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
                    digitizationGuide datastream (if digitization guide data is available)
                -->
                <xsl:if test="$haveDigitizationguide">
                    <foxml:datastream ID="digitizationGuide" CONTROL_GROUP="M" STATE="A"
                        VERSIONABLE="true">
                        <foxml:datastreamVersion ID="digitizationGuide.0"
                            LABEL="Digitization Guide Data for this object">
                            <xsl:attribute name="MIMETYPE">
                                <xsl:choose>
                                    <xsl:when
                                        test="ends-with($digitizationguideFileURI,$xlsExtension)">
                                        <xsl:value-of select="$xlsMimetype"/>
                                    </xsl:when>
                                    <xsl:when
                                        test="ends-with($digitizationguideFileURI,$xlsxExtension)">
                                        <xsl:value-of select="$xlsxMimetype"/>
                                    </xsl:when>
                                    <xsl:when
                                        test="ends-with($digitizationguideFileURI,$xmlExtension)">
                                        <xsl:value-of select="$xmlMimetype"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
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
                            LABEL="DPC Metadata for this object">
                            <xsl:attribute name="MIMETYPE">
                                <xsl:choose>
                                    <xsl:when test="ends-with($dpcmetadataFileURI,$xlsExtension)">
                                        <xsl:value-of select="$xlsMimetype"/>
                                    </xsl:when>
                                    <xsl:when test="ends-with($dpcmetadataFileURI,$xlsxExtension)">
                                        <xsl:value-of select="$xlsxMimetype"/>
                                    </xsl:when>
                                    <xsl:when test="ends-with($dpcmetadataFileURI,$xmlExtension)">
                                        <xsl:value-of select="$xmlMimetype"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
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
                            LABEL="FileMaker Pro Export Data for this object">
                            <xsl:attribute name="MIMETYPE">
                                <xsl:choose>
                                    <xsl:when test="ends-with($fmpexportFileURI,$xlsExtension)">
                                        <xsl:value-of select="$xlsMimetype"/>
                                    </xsl:when>
                                    <xsl:when test="ends-with($fmpexportFileURI,$xlsxExtension)">
                                        <xsl:value-of select="$xlsxMimetype"/>
                                    </xsl:when>
                                    <xsl:when test="ends-with($fmpexportFileURI,$xmlExtension)">
                                        <xsl:value-of select="$xmlMimetype"/>
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:attribute>
                            <foxml:contentDigest TYPE="SHA-256"/>
                            <foxml:contentLocation TYPE="URL">
                                <xsl:attribute name="REF" select="$fmpexportFileURI"/>
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
