<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fbm="http://www.fedora.info/definitions/">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:param name="fedorauriprefix" select="'info:fedora/'"/>
    <xsl:param name="parentpidmasterfile"/>
    <xsl:param name="relationshiptoparent"/>
    <xsl:param name="contentModels"/>
    <xsl:param name="contentModelsDelimiter" select="';'"/>
    <xsl:param name="adminPolicy"/>
    
    <xsl:variable name="parentPidMaster" select="document($parentpidmasterfile)"/>        

    <xsl:template match="/">
        <fbm:batchModify xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                         xsi:schemaLocation="http://www.fedora.info/definitions/ http://www.fedora.info/definitions/1/0/api/batchModify.xsd">
            <xsl:apply-templates/>
        </fbm:batchModify>     
    </xsl:template>
    
    <xsl:template match="//object">
        <xsl:variable name="parentId" select="parentid"/>
        <xsl:variable name="parentPid">
            <xsl:if test="$parentId!=''">
                <xsl:value-of select="$parentPidMaster/objects/object[identifier=$parentId]/pid"/>
            </xsl:if>
        </xsl:variable>
        <xsl:variable name="targetId" select="targetid"/>
        <xsl:variable name="targetPid">
            <xsl:if test="$targetId != ''">
                <xsl:value-of select="'TODO'"/>
            </xsl:if>
        </xsl:variable>
        <xsl:call-template name="addRELSEXTdatastream">
            <xsl:with-param name="pid" select="pid"/>
            <xsl:with-param name="parentPid" select="$parentPid"/>
            <xsl:with-param name="targetPid" select="$targetPid"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="addRELSEXTdatastream">
        <xsl:param name="pid"/>
        <xsl:param name="parentPid"/>
        <xsl:param name="targetPid"/>
        <fbm:addDatastream dsID="RELS-EXT" 
                           dsLabel="RDF Statements about this object" 
                           dsMIME="application/rdf+xml"
                           formatURI="info:fedora/fedora-system:FedoraRELSExt-1.0"
                           dsControlGroupType="X"
                           dsState="A"
                           logMessage="Create RELS-EXT datastream">
            <xsl:attribute name="pid">
                <xsl:value-of select="$pid"/>
            </xsl:attribute>
            <fbm:xmlData>
                <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns="http://www.fedora.info/definitions/">
                    <rdf:Description>
                        <xsl:attribute name="rdf:about" select="concat($fedorauriprefix,$pid)"/>
                        <xsl:for-each select="tokenize($contentModels,$contentModelsDelimiter)">
                            <xsl:element name="hasModel" namespace="info:fedora/fedora-system:def/model#">
                                <xsl:attribute name="rdf:resource" select="concat($fedorauriprefix,.)"/>
                            </xsl:element>
                        </xsl:for-each>
                        <xsl:if test="$adminPolicy!=''">
                            <xsl:element name="isGovernedBy" namespace="http://projecthydra.org/ns/relations#">
                                <xsl:attribute name="rdf:resource" select="concat($fedorauriprefix,$adminPolicy)"/>
                            </xsl:element>
                        </xsl:if>
                        <xsl:if test="$parentPid!=''">
                            <xsl:element name="{$relationshiptoparent}" 
                                namespace="info:fedora/fedora-system:def/relations-external#">
                                <xsl:attribute name="rdf:resource" select="concat($fedorauriprefix,$parentPid)"/>                                
                            </xsl:element>
                        </xsl:if>
                        <!--
                        <xsl:if test="$targetPid!=''">
                            <duke:hasTarget xmlns:duke="http://library.duke.edu/repository-namespace">
                                <xsl:attribute name="rdf:resource" select="concat($fedorauriprefix,$targetPid)"/>
                            </duke:hasTarget>
                        </xsl:if>
                        -->
                    </rdf:Description>
                </rdf:RDF>
            </fbm:xmlData>
        </fbm:addDatastream>
    </xsl:template>
    
</xsl:stylesheet>
