<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template match="/templateForm">
        <html>
            <head>
                <title>
                    <xsl:value-of select="@title"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@data"/>
                </title>
                <link rel="stylesheet" href="/default.css"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="form">
        <xsl:if test="object/@aliasName != ''"><xsl:comment>aliasName=<xsl:value-of select="object/@aliasName"/></xsl:comment></xsl:if>
        <xsl:if test="object/@SQLReq != ''"><xsl:comment>SQLReq=<xsl:value-of select="object/@SQLReq"/></xsl:comment></xsl:if>
        <xsl:if test="object/@name != ''"><xsl:comment>name=<xsl:value-of select="object/@name"/></xsl:comment></xsl:if>
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="object">
        <xsl:element name="div">
            <xsl:call-template name="objectStyleAttributes"/>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="label">
        <xsl:for-each select="object">
            <xsl:element name="div">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:value-of select="@caption"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="button">
        <xsl:for-each select="object">
            <xsl:element name="button">
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@event != ''"><xsl:comment>event=<xsl:value-of select="@event"/></xsl:comment></xsl:if>
                <xsl:value-of select="@caption"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="speedButton">
        <xsl:for-each select="object">
            <xsl:element name="input">
                <xsl:attribute name="type">image</xsl:attribute>
                <xsl:attribute name="src">
                    <xsl:choose>
                        <xsl:when test="@imagepath != ''">
                            <xsl:value-of select="@imagepath"/>
                        </xsl:when>
                        <xsl:otherwise>data:image/png;base64,<xsl:value-of select="."/></xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@event != ''"><xsl:comment>event=<xsl:value-of select="@event"/></xsl:comment></xsl:if>
                <xsl:value-of select="@caption"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="pageControl">
        <xsl:for-each select="object">
            <xsl:element name="button">
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:value-of select="@caption"/>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="edit">
        <xsl:for-each select="object">
            <xsl:element name="input">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:attribute name="value">
                    <xsl:value-of select="@text"/>
                </xsl:attribute>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@readonly != ''"><xsl:comment>readonly=<xsl:value-of select="@readonly"/></xsl:comment></xsl:if>
                <xsl:if test="@table != ''"><xsl:comment>table=<xsl:value-of select="@table"/></xsl:comment></xsl:if>
                <xsl:if test="@field != ''"><xsl:comment>field=<xsl:value-of select="@field"/></xsl:comment></xsl:if>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="richEdit">
        <xsl:for-each select="object">
            <xsl:element name="input">
                <xsl:if test="@text != ''"><xsl:attribute name="value"><xsl:value-of select="@text"/></xsl:attribute></xsl:if>
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@readonly != ''"><xsl:comment>readonly=<xsl:value-of select="@readonly"/></xsl:comment></xsl:if>
                <xsl:if test="@table != ''"><xsl:comment>table=<xsl:value-of select="@table"/></xsl:comment></xsl:if>
                <xsl:if test="@field != ''"><xsl:comment>field=<xsl:value-of select="@field"/></xsl:comment></xsl:if>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="image">
        <xsl:for-each select="object">
            <xsl:element name="img">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:attribute name="src">
                    <xsl:value-of select="@imagepath"/>
                </xsl:attribute>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@table != ''"><xsl:comment>table=<xsl:value-of select="@table"/></xsl:comment></xsl:if>
                <xsl:if test="@field != ''"><xsl:comment>field=<xsl:value-of select="@field"/></xsl:comment></xsl:if>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="comboBox">
        <xsl:for-each select="object">
            <xsl:element name="select">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:if test="@cbSQLRec != ''"><xsl:comment>cbSQLRec=<xsl:value-of select="@cbSQLRec"/></xsl:comment></xsl:if>
                <xsl:if test="@table != ''"><xsl:comment>table=<xsl:value-of select="@table"/></xsl:comment></xsl:if>
                <xsl:if test="@field != ''"><xsl:comment>field=<xsl:value-of select="@field"/></xsl:comment></xsl:if>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="groupBox">
        <xsl:for-each select="object">
            <xsl:element name="fieldset">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:call-template name="objectStyleAttributes"/>
                <legend><xsl:value-of select="@caption"/></legend>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="stringGrid">
        <xsl:for-each select="object">
            <xsl:element name="div">
                <xsl:if test="@name != ''"><xsl:attribute name="id"><xsl:value-of select="@name"/></xsl:attribute></xsl:if>
                <xsl:attribute name="class">scrollableTable</xsl:attribute>
                <xsl:call-template name="objectStyleAttributes"/>
                <xsl:element name="table">
                    <xsl:call-template name="tr-recursive">
                    </xsl:call-template>
                </xsl:element>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="tr-recursive">
        <xsl:param name="i" select="1"/>
        <tr>
            <xsl:call-template name="td-recursive">
                <xsl:with-param name="i" select="1"/>
            </xsl:call-template>
        </tr>
        <xsl:if test="$i &lt; @fixedRows + 1">
            <xsl:call-template name="tr-recursive">
                <xsl:with-param name="i" select="$i + 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="td-recursive">
        <xsl:param name="i" select="1"/>
        <xsl:element name="td">
            <xsl:attribute name="style">min-width:<xsl:value-of select="@defaultColWidth"/>px;height:<xsl:value-of select="@defaultRowHeight"/>px;</xsl:attribute>
        </xsl:element>
        <xsl:if test="$i &lt; @colCount">
            <xsl:call-template name="td-recursive">
                <xsl:with-param name="i" select="$i + 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template name="objectStyleAttributes">
        <xsl:variable name="color" select="translate(@color, 'cl', '')"/>
        <xsl:variable name="fontColor" select="translate(@fontColor, 'cl', '')"/>
        <xsl:variable name="fontStyle" select="@fontStyle"/>
        <xsl:variable name="font-weight">
            <xsl:choose>
                <xsl:when test="contains($fontStyle, 'Bold')">bold</xsl:when>
                <xsl:otherwise>normal</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="font-style">
            <xsl:choose>
                <xsl:when test="contains($fontStyle, 'Italic')">italic</xsl:when>
                <xsl:otherwise>normal</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="text-decoration">
            <xsl:choose>
                <xsl:when test="contains($fontStyle, 'StrikeOut') and contains($fontStyle, 'Underline')">line-through underline</xsl:when>
                <xsl:when test="contains($fontStyle, 'StrikeOut')">line-through</xsl:when>
                <xsl:when test="contains($fontStyle, 'Underline')">underline</xsl:when>
                <xsl:otherwise>none</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:attribute name="style">position: absolute; display: block;<xsl:if test="$color != ''">background-color: <xsl:value-of select = "$color"/>;</xsl:if>
            <xsl:if test="$fontColor != ''">color: <xsl:value-of select = "$fontColor"/>;</xsl:if>
            <xsl:if test="@textHeight != ''">font-size: <xsl:value-of select = "@textHeight"/>pt;</xsl:if>
            <xsl:if test="@fontName != ''">font-family: <xsl:value-of select = "@fontName"/>, sans-serif;</xsl:if>
            <xsl:if test="$font-weight != ''">font-weight: <xsl:value-of select = "$font-weight"/>;</xsl:if>
            <xsl:if test="$font-style != ''">font-style: <xsl:value-of select = "$font-style"/>;</xsl:if>
            <xsl:if test="@top != '' and @left != ''">margin: <xsl:value-of select = "@top"/>px <xsl:value-of select = "@left"/>px;</xsl:if>
            <xsl:if test="@width != ''">width: <xsl:value-of select = "@width"/>px;</xsl:if>
            <xsl:if test="@height != ''">height: <xsl:value-of select = "@height"/>px;</xsl:if>
            <xsl:if test="$text-decoration != ''">text-decoration: <xsl:value-of select = "$text-decoration"/>;</xsl:if>
            <xsl:if test="@wordwrap = 'false'">white-space: nowrap;overflow:auto</xsl:if>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>