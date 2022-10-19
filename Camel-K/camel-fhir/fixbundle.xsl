<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:array="http://www.w3.org/2005/xpath-functions/array"
                xmlns:map="http://www.w3.org/2005/xpath-functions/map"
                xmlns:math="http://www.w3.org/2005/xpath-functions/math"
                xmlns:fhir="http://hl7.org/fhir"
                exclude-result-prefixes="#all"
                expand-text="yes"
                version="3.0">

    <xsl:output method="xml" indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="/*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="@*, node()" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="fhir:request|fhir:search" >
      <request xmlns="http://hl7.org/fhir">
         <method value="POST" />
         <url><xsl:value-of select="../fhir:resource/local-name(*[1])"/></url>
      </request>
    </xsl:template>

    <xsl:template match="fhir:Condition" mode="#default">
     <xsl:element name="Condition" namespace="http://hl7.org/fhir">
        <xsl:apply-templates select="@*, node()"/>
        <xsl:element name="clinicalStatus" namespace="http://hl7.org/fhir">
            <xsl:element name="coding" namespace="http://hl7.org/fhir"> 
                <xsl:element name="system" namespace="http://hl7.org/fhir">http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical</xsl:element>
                <xsl:element name="code" namespace="http://hl7.org/fhir">active</xsl:element>
                <xsl:element name="display" namespace="http://hl7.org/fhir">Active</xsl:element>
            </xsl:element>
        </xsl:element>
     </xsl:element>
    </xsl:template>

    <!-- <xsl:template match="fhir:managingOrganization|fhir:serviceProvider|fhir:insurer" mode="#default">
       <xsl:comment>
           Remove external reference
       </xsl:comment>
    </xsl:template> -->
    <xsl:template match="fhir:reference" mode="#default">
       <xsl:choose>
         <xsl:when test="starts-with(@value, 'http')">
            <xsl:comment>Remove external reference</xsl:comment>            
         </xsl:when>
         <xsl:otherwise>
           <xsl:element name="reference" namespace="http://hl7.org/fhir">
                <xsl:apply-templates select="@*, node()"/>
           </xsl:element>
         </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>