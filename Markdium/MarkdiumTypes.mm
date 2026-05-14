//
//  MarkdiumTypes.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "MarkdiumTypes.h"

const MDOptions MDOptionDefault = CMARK_OPT_DEFAULT;
const MDOptions MDOptionSourcePos = CMARK_OPT_SOURCEPOS;
const MDOptions MDOptionHardBreaks = CMARK_OPT_HARDBREAKS;
const MDOptions MDOptionSafe = CMARK_OPT_SAFE;
const MDOptions MDOptionUnsafe = CMARK_OPT_UNSAFE;
const MDOptions MDOptionNoBreaks = CMARK_OPT_NOBREAKS;
const MDOptions MDOptionValidateUTF8 = CMARK_OPT_VALIDATE_UTF8;
const MDOptions MDOptionSmart = CMARK_OPT_SMART;
const MDOptions MDOptionGithubPreLang = CMARK_OPT_GITHUB_PRE_LANG;
const MDOptions MDOptionLiberalHTMLTag = CMARK_OPT_LIBERAL_HTML_TAG;
const MDOptions MDOptionFootnotes = CMARK_OPT_FOOTNOTES;
const MDOptions MDOptionStrikethroughDoubleTilde = CMARK_OPT_STRIKETHROUGH_DOUBLE_TILDE;
const MDOptions MDOptionTablePreferStyleAttributes = CMARK_OPT_TABLE_PREFER_STYLE_ATTRIBUTES;
const MDOptions MDOptionFullInfoString = CMARK_OPT_FULL_INFO_STRING;

const MDExtensions MDExtensionNone = 0;
const MDExtensions MDExtensionTagFilter = (1 << 1);
const MDExtensions MDExtensionAutolink = (1 << 2);
const MDExtensions MDExtensionStrikethrough = (1 << 3);
const MDExtensions MDExtensionTasklist = (1 << 4);
const MDExtensions MDExtensionTable = (1 << 5);
const MDExtensions MDExtensionAll = MDExtensionTagFilter | MDExtensionAutolink | MDExtensionStrikethrough |
                                    MDExtensionTasklist | MDExtensionTable;

/* Block */
const MDNodeType MDNodeTypeDocument = CMARK_NODE_DOCUMENT;
const MDNodeType MDNodeTypeBlockQuote = CMARK_NODE_BLOCK_QUOTE;
const MDNodeType MDNodeTypeList = CMARK_NODE_LIST;
const MDNodeType MDNodeTypeItem = CMARK_NODE_ITEM;
const MDNodeType MDNodeTypeCodeBlock = CMARK_NODE_CODE_BLOCK;
const MDNodeType MDNodeTypeHTMLBlock = CMARK_NODE_HTML_BLOCK;
const MDNodeType MDNodeTypeCustomBlock = CMARK_NODE_CUSTOM_BLOCK;
const MDNodeType MDNodeTypeParagraph = CMARK_NODE_PARAGRAPH;
const MDNodeType MDNodeTypeHeading = CMARK_NODE_HEADING;
const MDNodeType MDNodeTypeThematicBreak = CMARK_NODE_THEMATIC_BREAK;
const MDNodeType MDNodeTypeFootnoteDefinition = CMARK_NODE_FOOTNOTE_DEFINITION;

/* Inline */
const MDNodeType MDNodeTypeText = CMARK_NODE_TEXT;
const MDNodeType MDNodeTypeSoftBreak = CMARK_NODE_SOFTBREAK;
const MDNodeType MDNodeTypeLineBreak = CMARK_NODE_LINEBREAK;
const MDNodeType MDNodeTypeCode = CMARK_NODE_CODE;
const MDNodeType MDNodeTypeHTMLInline = CMARK_NODE_HTML_INLINE;
const MDNodeType MDNodeTypeCustomInline = CMARK_NODE_CUSTOM_INLINE;
const MDNodeType MDNodeTypeEmph = CMARK_NODE_EMPH;
const MDNodeType MDNodeTypeStrong = CMARK_NODE_STRONG;
const MDNodeType MDNodeTypeLink = CMARK_NODE_LINK;
const MDNodeType MDNodeTypeImage = CMARK_NODE_IMAGE;
const MDNodeType MDNodeTypeFootnoteReference = CMARK_NODE_FOOTNOTE_REFERENCE;

const MDNodeListType MDNodeBulletList = CMARK_BULLET_LIST;
const MDNodeListType MDNodeOrderedList = CMARK_ORDERED_LIST;

const MDNodeListDelim MDNodeListParenDelim = CMARK_PAREN_DELIM;
const MDNodeListDelim MDNodeListPeriodDelim = CMARK_PERIOD_DELIM;
