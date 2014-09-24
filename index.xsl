<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s3="http://s3.amazonaws.com/doc/2006-03-01/">
    <xsl:output method="text"/>

    <xsl:template match="/">
        <xsl:apply-templates select="//s3:Contents/s3:Key"/>
    </xsl:template>

    <xsl:template match="*">
        <xsl:value-of select="."/><xsl:text>
</xsl:text>
    </xsl:template>

</xsl:stylesheet>
