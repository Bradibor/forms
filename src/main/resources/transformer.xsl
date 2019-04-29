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
                <link rel="stylesheet" href="default.css"/>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="form">
        <div class="form">
            <xsl:variable name="color" select="translate(object/@color, 'cl', '')"/>
            <xsl:variable name="fontColor" select="translate(object/@fontColor, 'cl', '')"/>
            <xsl:variable name="left" select="object/@left"/>
            <xsl:variable name="top" select="object/@top"/>
            <xsl:variable name="width" select="object/@width"/>
            <xsl:variable name="height" select="object/@height"/>
            <xsl:variable name="fontName" select="object/@fontName"/>
            <xsl:variable name="fontStyle" select="object/@fontStyle"/>
            <xsl:variable name="textHeight" select="object/@textHeight"/>
            <xsl:variable name="caption" select="object/@caption"/>
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

            <div class="caption" style="margin: {$top - 20}px {$left}px">
                <xsl:value-of select="object/@caption"/>
            </div>
            <div class="object" style="position: absolute;background-color: {$color}; color: {$fontColor}; font-size: {$textHeight}px; font-family: {$fontName}, sans-serif;font-weight: {$font-weight};font-style: {$font-style};margin: {$top}px {$left}px;width: {$width}px;height: {$height}px;text-decoration: {$text-decoration}">
                <xsl:apply-templates/>
            </div>
        </div>
    </xsl:template>

    <xsl:template match="label">
        <div class="label">
            <xsl:apply-templates select="object"/>
        </div>
    </xsl:template>

    <xsl:template match="object">
        <xsl:call-template name="object">
            <xsl:with-param name="color" select="translate(@color, 'cl', '')"/>
            <xsl:with-param name="fontColor" select="translate(@fontColor, 'cl', '')"/>
            <xsl:with-param name="fontName" select="@fontName"/>
            <xsl:with-param name="textHeight" select="@textHeight"/>
            <xsl:with-param name="fontStyle" select="@fontStyle"/>
            <xsl:with-param name="caption" select="@caption"/>
            <xsl:with-param name="left" select="@left"/>
            <xsl:with-param name="top" select="@top"/>
            <xsl:with-param name="width" select="@width"/>
            <xsl:with-param name="height" select="@height"/>
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="object">
        <xsl:param name="color"/>
        <xsl:param name="fontColor"/>
        <xsl:param name="left"/>
        <xsl:param name="top"/>
        <xsl:param name="width"/>
        <xsl:param name="height"/>
        <xsl:param name="fontName"/>
        <xsl:param name="fontStyle"/>
        <xsl:param name="textHeight"/>
        <xsl:param name="caption"/>
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
        <div class="object" style="position: absolute;background-color: {$color}; color: {$fontColor}; font-size: {$textHeight}px; font-family: {$fontName}, sans-serif;font-weight: {$font-weight};font-style: {$font-style};margin: {$top}px {$left}px;width: {$width}px;height: {$height}px;text-decoration: {$text-decoration}">
            <div class="caption">
                <xsl:value-of select="@caption"/>
            </div>
        </div>
    </xsl:template>


    <!--<xsl:template match="@* | node()" name="identity">-->
        <!--<xsl:copy>-->
            <!--<xsl:apply-templates select="@* | node()"/>-->
        <!--</xsl:copy>-->
    <!--</xsl:template>-->

    <!--<xsl:template match="/organization/ogrn"/>-->

    <!--<xsl:template match="/organization/okveds/okved_main">-->
        <!--<okved version="2001" main="true">-->
            <!--<xsl:copy-of select="node()"/>-->
        <!--</okved>-->
    <!--</xsl:template>-->

    <!--<xsl:template match="/organization/okveds/okved">-->
        <!--<okved version="2001" main="false">-->
            <!--<xsl:copy-of select="node()"/>-->
        <!--</okved>-->
    <!--</xsl:template>-->

    <!--<xsl:template match="/organization/entities">-->
        <!--<xsl:copy-of select="node()"/>-->
    <!--</xsl:template>-->

    <!--<xsl:template match="/organization/status">-->
        <!--<status>-->
            <!--<xsl:choose>-->
                <!--<xsl:when test=".=1">active</xsl:when>-->
                <!--<xsl:otherwise>eliminated</xsl:otherwise>-->
            <!--</xsl:choose>-->
        <!--</status>-->
    <!--</xsl:template>-->
</xsl:stylesheet>