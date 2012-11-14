<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Intended to be included in other stylesheets.  Provides a common default set of variables and 
    overrideable parameters for use by other stylesheets.
    
    Included XSL stylesheets:
        None
        
    Source XML document: None
    
    Parameters:
        collectioncode: A character string used in various file paths to distinguish the files
            relating to one collection from those of another collection during the ingest process.
            No default value.  E.g., KWL, VIC.
        windowsDrivePath: A character string prepended to various file paths to represent the 
            drive letter when using a Windows file system.  No default value; hence, by default,
            no drive letter string is prepended to file paths.  E.g., /g:
        ingestBase: The base file path used for the files relating to a collection to be ingested.
            Default value is the windowsDrivePath parameter (if any) followed by "/srv/fedora-working/ingest/"
            followed by the collectioncode parameter in upper case followed by "/".  E.g.,
            /g:/srv/fedora-working/ingest/KWL/
        haveChecksum: Boolean value indicating whether checksum data is available for use or not.
            Default is true().
        checksumFilename: Name of file containing checksum data.  Default is "checksums.xml".
        haveContent: Boolean value indicating whether the digital object file is available for use
            or not.  Default is true().
        haveContentdm:  Boolean value indicating whether CONTENTdm metadata is available for use or
            not.  Default is false().
        haveDigitizationguide: Boolean value indicating whether DPC digitization guide data is available
            for use or not.  Default is false().
        digitizationguideFilename: Name of file containing DPC digitization guide data.  Default is
            "digitizationguide.xml".
        haveDpcmetadata: Boolean value indicating whether additional DPC metadata is available for
            use or not.  Default is false().
        dpcmetadataFilename: Name of file containing additional DPC metadata.  Default is "dpcmetadata.xml".
        haveFmpexport: Boolean value indicating whether DPC FileMaker Pro export data is available for
            use or not.  Default is false().
        fmpexportFilename: Name of file containing DPC FileMaker Pro export data.  Default is 
            "fmpexport.xml".
        haveJhove: Boolean value indicating whether JHOVE data is available for use or not. Default
            is true().
        haveMarcxml: Boolean value indicating whether MARCXML data from Aleph is available for use or not.
            Default is false().
        haveMods: Boolean value indicating whether MODS data is available for use or not.  Default is
            false().
        haveTripodmets: Boolean value indicating whether Tripod2 METS metadata is available for use or
            not.  Default is false().
        autoParentId: Boolean value indicating whether the identifier of the parent of an object should
            be constructed algorithmically using a substring of the object's identifier.  Default is
            false().
        autoParentIdLength: The number of characters beginning from the start of an object's
            identifier to be used to construct the identifier of the parent of the object is the
            autoParentId parameter is set to true().  No default value.  E.g., 7.
        parentId: The identifier of the parent of the object if that identifier cannot be constructed
            algorithmically.  No default value.  E.g., kwilecki, vica.
        collectionEnumerationPath:
        collectionContentdmPath:
        collectionDigitizationguidePath:
        collectionDpcmetadataPath:
        collectionFmpexportPath:
        collectionFoxmlPath:
        collectionMarcxmlPath:
        collectionMasterPath:
        collectionModifyPath:
        collectionModsPath:
        collectionTripodmetsPath:
        itemEnumerationPath:
        itemContentdmPath:
        itemFoxmlPath:
        itemMarcxmlPath:
        itemMasterPath:
        itemModifyPath:
        itemModsPath:
        itemTripodmetsPath:
        componentEnumerationPath:
        componentChecksumPath:
        componentChecksumFile:
        componentDigitizationguidePath:
        componentDigitizationguideFile:
        componentDpcmetadataPath:
        componentDpcmetadataFile:
        componentFmpexportPath:
        componentFmpexportFile:
        componentFoxmlPath:
        componentJhovePath:
        componentMasterPath:
        componentModifyPath:
        componentModsPath:
        targetEnumerationPath:
        targetChecksumPath:
        targetChecksumFile:
        targetDigitizationguidePath:
        targetDigitizationguideFile:
        targetDpcmetadataPath:
        targetDpcmetadataFile:
        targetFmpexportPath:
        targetFmpexportFile:
        targetFoxmlPath:
        targetJhovePath:
        targetMasterPath:
        targetModifyPath:
        targetModsPath:
    
    Output XML document: None
    
    Additional results XML documents:
        None
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

    <xsl:variable name="externalControlGroupType" select="'E'"/>
    <xsl:variable name="inlineControlGroupType" select="'X'"/>
    <xsl:variable name="managedControlGroupType" select="'M'"/>
    <xsl:variable name="redirectControlGroupType" select="'R'"/>
    <xsl:variable name="activeState" select="'A'"/>
    <xsl:variable name="deletedState" select="'D'"/>
    <xsl:variable name="inactiveState" select="'I'"/>
    <xsl:variable name="md5ChecksumType" select="'MD5'"/>
    <xsl:variable name="sha1ChecksumType" select="'SHA-1'"/>
    <xsl:variable name="sha256ChecksumType" select="'SHA-256'"/>
    <xsl:variable name="sha384ChecksumType" select="'SHA-384'"/>
    <xsl:variable name="sha512ChecksumType" select="'SHA-512'"/>
    <xsl:variable name="disabledChecksumType" select="'DISABLED'"/>
    
    <xsl:variable name="defaultObjectState" select="$activeState"/>
    <xsl:variable name="defaultObjectOwner" select="'fedoraAdmin'"/>

    <xsl:variable name="fedoraURIPrefix" select="'info:fedora/'"/>
    <xsl:variable name="fileURIPrefix" select="'file://'"/>

    <xsl:variable name="pdfExtension" select="'.pdf'"/>
    <xsl:variable name="pdfMimetype" select="'application/pdf'"/>
    <xsl:variable name="xlsExtension" select="'.xls'"/>
    <xsl:variable name="xlsMimetype" select="'application/vnd.ms-excel'"/>
    <xsl:variable name="xlsxExtension" select="'.xlsx'"/>
    <xsl:variable name="xlsxMimetype"
        select="'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'"/>
    <xsl:variable name="xmlExtension" select="'.xml'"/>
    <xsl:variable name="xmlMimetype" select="'text/xml'"/>

    <!-- 
        <xsl:param name="collectioncode"/>
        <xsl:param name="windowsDrivePath"/>
        <xsl:param name="ingestBase"
        select="concat($windowsDrivePath,'/srv/fedora-working/ingest/',upper-case($collectioncode),'/')"/>
        
        
    <xsl:param name="haveChecksum" select="true()"/>
    <xsl:param name="checksumFilename" select="'checksums.xml'"/>
    <xsl:param name="haveContent" select="true()"/>
    <xsl:param name="haveContentdm" select="false()"/>
    <xsl:param name="haveDigitizationguide" select="false()"/>
    <xsl:param name="digitizationguideFilename" select="'digitizationguide.xml'"/>
    <xsl:param name="haveDpcmetadata" select="false()"/>
    <xsl:param name="dpcmetadataFilename" select="'dpcmetadata.xml'"/>
    <xsl:param name="haveFmpexport" select="false()"/>
    <xsl:param name="fmpexportFilename" select="'fmpexport.xml'"/>
    <xsl:param name="haveJhove" select="true()"/>
    <xsl:param name="haveMarcxml" select="false()"/>
    <xsl:param name="haveMods" select="false()"/>
    <xsl:param name="haveTripodmets" select="false()"/>

    <xsl:param name="autoParentId" select="false()"/>
    <xsl:param name="autoParentIdLength"/>
    <xsl:param name="parentId"/>


    <xsl:variable name="collectionPathPart" select="'collection/'"/>
    <xsl:variable name="itemPathPart" select="'item/'"/>
    <xsl:variable name="componentPathPart" select="'component/'"/>
    <xsl:variable name="targetPathPart" select="'target/'"/>
    <xsl:variable name="logsPathPart" select="'logs/'"/>

    <xsl:variable name="collectionPath" select="concat($ingestBase,$collectionPathPart)"/>
    <xsl:variable name="itemPath" select="concat($ingestBase,$itemPathPart)"/>
    <xsl:variable name="componentPath" select="concat($ingestBase,$componentPathPart)"/>
    <xsl:variable name="targetPath" select="concat($ingestBase,$targetPathPart)"/>
    <xsl:variable name="logsPath" select="concat($ingestBase,$logsPathPart)"/>

    <xsl:variable name="checksumPathPart" select="'checksum/'"/>
    <xsl:variable name="contentdmPathPart" select="'contentdm/'"/>
    <xsl:variable name="contentmetadataPathPart" select="'contentMetadata/'"/>
    <xsl:variable name="digitizationguidePathPart" select="'digitizationGuide/'"/>
    <xsl:variable name="dpcmetadataPathPart" select="'dpcMetadata/'"/>
    <xsl:variable name="fmpexportPathPart" select="'fmpExport/'"/>
    <xsl:variable name="foxmlPathPart" select="'foxml/'"/>
    <xsl:variable name="jhovePathPart" select="'jhove/'"/>
    <xsl:variable name="marcxmlPathPart" select="'marcXML/'"/>
    <xsl:variable name="masterPathPart" select="'master/'"/>
    <xsl:variable name="modifyPathPart" select="'modify/'"/>
    <xsl:variable name="modsPathPart" select="'mods/'"/>
    <xsl:variable name="tripodmetsPathPart" select="'tripodMets/'"/>

    <xsl:param name="collectionEnumerationPath" select="$collectionPath"/>
    <xsl:param name="collectionContentdmPath" select="concat($collectionPath,$contentdmPathPart)"/>
    <xsl:param name="collectionDigitizationguidePath"
        select="concat($collectionPath,$digitizationguidePathPart)"/>
    <xsl:param name="collectionDpcmetadataPath"
        select="concat($collectionPath,$dpcmetadataPathPart)"/>
    <xsl:param name="collectionFmpexportPath" select="concat($collectionPath,$fmpexportPathPart)"/>
    <xsl:param name="collectionFoxmlPath" select="concat($collectionPath,$foxmlPathPart)"/>
    <xsl:param name="collectionMarcxmlPath" select="concat($collectionPath,$marcxmlPathPart)"/>
    <xsl:param name="collectionMasterPath" select="concat($collectionPath,$masterPathPart)"/>
    <xsl:param name="collectionModifyPath" select="concat($collectionPath,$modifyPathPart)"/>
    <xsl:param name="collectionModsPath" select="concat($collectionPath,$modsPathPart)"/>
    <xsl:param name="collectionTripodmetsPath" select="concat($collectionPath,$tripodmetsPathPart)"/>

    <xsl:variable name="collectionEnumerationPathURI"
        select="concat($fileURIPrefix,$collectionEnumerationPath)"/>
    <xsl:variable name="collectionContentdmPathURI"
        select="concat($fileURIPrefix,$collectionContentdmPath)"/>
    <xsl:variable name="collectionDigitizationguidePathURI"
        select="concat($fileURIPrefix,$collectionDigitizationguidePath)"/>
    <xsl:variable name="collectionDpcmetadataPathURI"
        select="concat($fileURIPrefix,$collectionDpcmetadataPath)"/>
    <xsl:variable name="collectionFmpexportPathURI"
        select="concat($fileURIPrefix,$collectionFmpexportPath)"/>
    <xsl:variable name="collectionFoxmlPathURI" select="concat($fileURIPrefix,$collectionFoxmlPath)"/>
    <xsl:variable name="collectionMarcxmlPathURI"
        select="concat($fileURIPrefix,$collectionMarcxmlPath)"/>
    <xsl:variable name="collectionMasterPathURI"
        select="concat($fileURIPrefix,$collectionMasterPath)"/>
    <xsl:variable name="collectionModifyPathURI"
        select="concat($fileURIPrefix,$collectionModifyPath)"/>
    <xsl:variable name="collectionModsPathURI" select="concat($fileURIPrefix,$collectionModsPath)"/>
    <xsl:variable name="collectionTripodmetsPathURI"
        select="concat($fileURIPrefix,$collectionTripodmetsPath)"/>

    <xsl:param name="itemEnumerationPath" select="$itemPath"/>
    <xsl:param name="itemContentdmPath" select="concat($itemPath,$contentdmPathPart)"/>
    <xsl:param name="itemFoxmlPath" select="concat($itemPath,$foxmlPathPart)"/>
    <xsl:param name="itemMarcxmlPath" select="concat($itemPath,$marcxmlPathPart)"/>
    <xsl:param name="itemMasterPath" select="concat($itemPath,$masterPathPart)"/>
    <xsl:param name="itemModifyPath" select="concat($itemPath,$modifyPathPart)"/>
    <xsl:param name="itemModsPath" select="concat($itemPath,$modsPathPart)"/>
    <xsl:param name="itemTripodmetsPath" select="concat($itemPath,$tripodmetsPathPart)"/>

    <xsl:variable name="itemEnumerationPathURI" select="concat($fileURIPrefix,$itemEnumerationPath)"/>
    <xsl:variable name="itemContentdmPathURI" select="concat($fileURIPrefix,$itemContentdmPath)"/>
    <xsl:variable name="itemFoxmlPathURI" select="concat($fileURIPrefix,$itemFoxmlPath)"/>
    <xsl:variable name="itemMarcxmlPathURI" select="concat($fileURIPrefix,$itemMarcxmlPath)"/>
    <xsl:variable name="itemMasterPathURI" select="concat($fileURIPrefix,$itemMasterPath)"/>
    <xsl:variable name="itemModifyPathURI" select="concat($fileURIPrefix,$itemModifyPath)"/>
    <xsl:variable name="itemModsPathURI" select="concat($fileURIPrefix,$itemModsPath)"/>
    <xsl:variable name="itemTripodmetsPathURI" select="concat($fileURIPrefix,$itemTripodmetsPath)"/>

    <xsl:param name="componentEnumerationPath" select="$componentPath"/>
    <xsl:param name="componentChecksumPath" select="concat($componentPath,$checksumPathPart)"/>
    <xsl:param name="componentChecksumFile"
        select="concat($componentChecksumPath,$checksumFilename)"/>
    <xsl:param name="componentDigitizationguidePath"
        select="concat($componentPath,$digitizationguidePathPart)"/>
    <xsl:param name="componentDigitizationguideFile"
        select="concat($componentDigitizationguidePath,$digitizationguideFilename)"/>
    <xsl:param name="componentDpcmetadataPath" select="concat($componentPath,$dpcmetadataPathPart)"/>
    <xsl:param name="componentDpcmetadataFile"
        select="concat($componentDpcmetadataPath,$dpcmetadataFilename)"/>
    <xsl:param name="componentFmpexportPath" select="concat($componentPath,$fmpexportPathPart)"/>
    <xsl:param name="componentFmpexportFile"
        select="concat($componentFmpexportPath,$fmpexportFilename)"/>
    <xsl:param name="componentFoxmlPath" select="concat($componentPath,$foxmlPathPart)"/>
    <xsl:param name="componentJhovePath" select="concat($componentPath,$jhovePathPart)"/>
    <xsl:param name="componentMasterPath" select="concat($componentPath,$masterPathPart)"/>
    <xsl:param name="componentModifyPath" select="concat($componentPath,$modifyPathPart)"/>
    <xsl:param name="componentModsPath" select="concat($componentPath,$modsPathPart)"/>

    <xsl:variable name="componentEnumerationPathURI"
        select="concat($fileURIPrefix,$componentEnumerationPath)"/>
    <xsl:variable name="componentChecksumPathURI"
        select="concat($fileURIPrefix,$componentChecksumPath)"/>
    <xsl:variable name="componentChecksumFileURI"
        select="concat($fileURIPrefix,$componentChecksumFile)"/>
    <xsl:variable name="componentDigitizationguidePathURI"
        select="concat($fileURIPrefix,$componentDigitizationguidePath)"/>
    <xsl:variable name="componentDigitizationguideFileURI"
        select="concat($fileURIPrefix,$componentDigitizationguideFile)"/>
    <xsl:variable name="componentDpcmetadataPathURI"
        select="concat($fileURIPrefix,$componentDpcmetadataPath)"/>
    <xsl:variable name="componentDpcmetadataFileURI"
        select="concat($fileURIPrefix,$componentDpcmetadataFile)"/>
    <xsl:variable name="componentFmpexportPathURI"
        select="concat($fileURIPrefix,$componentFmpexportPath)"/>
    <xsl:variable name="componentFmpexportFileURI"
        select="concat($fileURIPrefix,$componentFmpexportFile)"/>
    <xsl:variable name="componentFoxmlPathURI" select="concat($fileURIPrefix,$componentFoxmlPath)"/>
    <xsl:variable name="componentJhovePathURI" select="concat($fileURIPrefix,$componentJhovePath)"/>
    <xsl:variable name="componentMasterPathURI" select="concat($fileURIPrefix,$componentMasterPath)"/>
    <xsl:variable name="componentModifyPathURI" select="concat($fileURIPrefix,$componentModifyPath)"/>
    <xsl:variable name="componentModsPathURI" select="concat($fileURIPrefix,$componentModsPath)"/>

    <xsl:param name="targetEnumerationPath" select="$targetPath"/>
    <xsl:param name="targetChecksumPath" select="concat($targetPath,$checksumPathPart)"/>
    <xsl:param name="targetChecksumFile" select="concat($targetChecksumPath,$checksumFilename)"/>
    <xsl:param name="targetDigitizationguidePath"
        select="concat($targetPath,$digitizationguidePathPart)"/>
    <xsl:param name="targetDigitizationguideFile"
        select="concat($targetDigitizationguidePath,$digitizationguideFilename)"/>
    <xsl:param name="targetDpcmetadataPath" select="concat($targetPath,$dpcmetadataPathPart)"/>
    <xsl:param name="targetDpcmetadataFile"
        select="concat($targetDpcmetadataPath,$dpcmetadataFilename)"/>
    <xsl:param name="targetFmpexportPath" select="concat($targetPath,$fmpexportPathPart)"/>
    <xsl:param name="targetFmpexportFile" select="concat($targetFmpexportPath,$fmpexportFilename)"/>
    <xsl:param name="targetFoxmlPath" select="concat($targetPath,$foxmlPathPart)"/>
    <xsl:param name="targetJhovePath" select="concat($targetPath,$jhovePathPart)"/>
    <xsl:param name="targetMasterPath" select="concat($targetPath,$masterPathPart)"/>
    <xsl:param name="targetModifyPath" select="concat($targetPath,$modifyPathPart)"/>
    <xsl:param name="targetModsPath" select="concat($targetPath,$modsPathPart)"/>

    <xsl:variable name="targetEnumerationPathURI"
        select="concat($fileURIPrefix,$targetEnumerationPath)"/>
    <xsl:variable name="targetChecksumPathURI" select="concat($fileURIPrefix,$targetChecksumPath)"/>
    <xsl:variable name="targetChecksumFileURI" select="concat($fileURIPrefix,$targetChecksumFile)"/>
    <xsl:variable name="targetDigitizationguidePathURI"
        select="concat($fileURIPrefix,$targetDigitizationguidePath)"/>
    <xsl:variable name="targetDigitizationguideFileURI"
        select="concat($fileURIPrefix,$targetDigitizationguideFile)"/>
    <xsl:variable name="targetDpcmetadataPathURI"
        select="concat($fileURIPrefix,$targetDpcmetadataPath)"/>
    <xsl:variable name="targetDpcmetadataFileURI"
        select="concat($fileURIPrefix,$targetDpcmetadataFile)"/>
    <xsl:variable name="targetFmpexportPathURI" select="concat($fileURIPrefix,$targetFmpexportPath)"/>
    <xsl:variable name="targetFmpexportFileURI" select="concat($fileURIPrefix,$targetFmpexportFile)"/>
    <xsl:variable name="targetFoxmlPathURI" select="concat($fileURIPrefix,$targetFoxmlPath)"/>
    <xsl:variable name="targetJhovePathURI" select="concat($fileURIPrefix,$targetJhovePath)"/>
    <xsl:variable name="targetMasterPathURI" select="concat($fileURIPrefix,$targetMasterPath)"/>
    <xsl:variable name="targetModifyPathURI" select="concat($fileURIPrefix,$targetModifyPath)"/>
    <xsl:variable name="targetModsPathURI" select="concat($fileURIPrefix,$targetModsPath)"/>
-->
</xsl:stylesheet>
