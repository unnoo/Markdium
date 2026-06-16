//
//  MarkdiumTypes.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#ifndef MarkdiumTypes_h
#define MarkdiumTypes_h

#import <Foundation/Foundation.h>

typedef NSInteger MDOptions;

/**
 * ## Options
 */

/** Default options.
 */
extern const MDOptions MDOptionDefault;

/**
 * ### Options affecting rendering
 */

/** Include a `data-sourcepos` attribute on all block elements.
 */
extern const MDOptions MDOptionSourcePos;

/** Render `softbreak` elements as hard line breaks.
 */
extern const MDOptions MDOptionHardBreaks;

/** `CMARK_OPT_SAFE` is defined here for API compatibility,
 but it no longer has any effect. "Safe" mode is now the default:
 set `CMARK_OPT_UNSAFE` to disable it.
 */
extern const MDOptions MDOptionSafe;

/** Render raw HTML and unsafe links (`javascript:`, `vbscript:`,
 * `file:`, and `data:`, except for `image/png`, `image/gif`,
 * `image/jpeg`, or `image/webp` mime types).  By default,
 * raw HTML is replaced by a placeholder HTML comment. Unsafe
 * links are replaced by empty strings.
 */
extern const MDOptions MDOptionUnsafe;

/** Render `softbreak` elements as spaces.
 */
extern const MDOptions MDOptionNoBreaks;

/**
 * ### Options affecting parsing
 */

/** Validate UTF-8 in the input before parsing, replacing illegal
 * sequences with the replacement character U+FFFD.
 */
extern const MDOptions MDOptionValidateUTF8;

/** Convert straight quotes to curly, --- to em dashes, -- to en dashes.
 */
extern const MDOptions MDOptionSmart;

/** Use GitHub-style <pre lang="x"> tags for code blocks instead of <pre><code
 * class="language-x">.
 */
extern const MDOptions MDOptionGithubPreLang;

/** Be liberal in interpreting inline HTML tags.
 */
extern const MDOptions MDOptionLiberalHTMLTag;

/** Parse footnotes.
 */
extern const MDOptions MDOptionFootnotes;

/** Only parse strikethroughs if surrounded by exactly 2 tildes.
 * Gives some compatibility with redcarpet.
 */
extern const MDOptions MDOptionStrikethroughDoubleTilde;

/** Use style attributes to align table cells instead of align attributes.
 */
extern const MDOptions MDOptionTablePreferStyleAttributes;

/** Include the remainder of the info string in code blocks in
 * a separate attribute.
 */
extern const MDOptions MDOptionFullInfoString;

typedef NSInteger MDExtensions;

extern const MDExtensions MDExtensionNone;
extern const MDExtensions MDExtensionTagFilter;
extern const MDExtensions MDExtensionAutolink;
extern const MDExtensions MDExtensionStrikethrough;
extern const MDExtensions MDExtensionTasklist;
extern const MDExtensions MDExtensionTable;
extern const MDExtensions MDExtensionAll;

typedef NSInteger MDNodeType;

/* Block */
extern const MDNodeType MDNodeTypeDocument;
extern const MDNodeType MDNodeTypeBlockQuote;
extern const MDNodeType MDNodeTypeList;
extern const MDNodeType MDNodeTypeItem;
extern const MDNodeType MDNodeTypeCodeBlock;
extern const MDNodeType MDNodeTypeHTMLBlock;
extern const MDNodeType MDNodeTypeCustomBlock;
extern const MDNodeType MDNodeTypeParagraph;
extern const MDNodeType MDNodeTypeHeading;
extern const MDNodeType MDNodeTypeThematicBreak;
extern const MDNodeType MDNodeTypeFootnoteDefinition;
extern const MDNodeType MDNodeTypeTable;
extern const MDNodeType MDNodeTypeTableRow;
extern const MDNodeType MDNodeTypeTableCell;

/* Inline */
extern const MDNodeType MDNodeTypeText;
extern const MDNodeType MDNodeTypeSoftBreak;
extern const MDNodeType MDNodeTypeLineBreak;
extern const MDNodeType MDNodeTypeCode;
extern const MDNodeType MDNodeTypeHTMLInline;
extern const MDNodeType MDNodeTypeCustomInline;
extern const MDNodeType MDNodeTypeEmph;
extern const MDNodeType MDNodeTypeStrong;
extern const MDNodeType MDNodeTypeLink;
extern const MDNodeType MDNodeTypeImage;
extern const MDNodeType MDNodeTypeFootnoteReference;
extern const MDNodeType MDNodeTypeStrikethrough;

typedef NSInteger MDNodeListType;

extern const MDNodeListType MDNodeBulletList;
extern const MDNodeListType MDNodeOrderedList;

typedef NSInteger MDNodeListDelim;

extern const MDNodeListDelim MDNodeListDelimParen;
extern const MDNodeListDelim MDNodeListDelimPeriod;

#endif /* MarkdiumTypes_h */
