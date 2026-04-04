//
//  CMarkParser.m
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "CMarkParser.h"
#import "MarkdiumTypes.h"
#import "MDNode_internal.h"
#import "cmark-gfm.h"

NSString *_Nullable getNodeTypeString(cmark_node *node) {
    NSString *output = nil;
    const char *ptr = cmark_node_get_type_string(node);
    if (ptr) {
        output = [NSString stringWithUTF8String:ptr];
    }

    return output;
}

NSString *_Nullable getNodeLiteral(cmark_node *node) {
    NSString *output = nil;
    const char *ptr = cmark_node_get_literal(node);
    if (ptr) {
        output = [NSString stringWithUTF8String:ptr];
    }

    return output;
}

NS_INLINE void cmarkAttachSyntaxExtension(cmark_parser *parser, const char *extName) {
    cmark_syntax_extension *ext = cmark_find_syntax_extension(extName);
    if (ext) {
        cmark_parser_attach_syntax_extension(parser, ext);
    }
}

void cmarkEnableGFM(cmark_parser *parser, int extensions) {
    if (extensions & MDExtensionTagFilter) {
        cmarkAttachSyntaxExtension(parser, "tagfilter");
    }

    if (extensions & MDExtensionAutolink) {
        cmarkAttachSyntaxExtension(parser, "autolink");
    }

    if (extensions & MDExtensionStrikethrough) {
        cmarkAttachSyntaxExtension(parser, "strikethrough");
    }

    if (extensions & MDExtensionTasklist) {
        cmarkAttachSyntaxExtension(parser, "tasklist");
    }

    if (extensions & MDExtensionTable) {
        cmarkAttachSyntaxExtension(parser, "table");
    }
}

cmark_node *_Nullable cmarkParseString(NSString *string, int options, int extensions) {
    if (!string) {
        return NULL;
    }

    cmark_gfm_core_extensions_ensure_registered();

    cmark_parser *parser = cmark_parser_new(options);
    if (!parser) {
        return NULL;
    }

    cmarkEnableGFM(parser, extensions);

    const char *utf8String = string.UTF8String;
    cmark_parser_feed(parser, utf8String, strlen(utf8String));
    cmark_node *node = cmark_parser_finish(parser);
    cmark_parser_free(parser);

    return node;
}

cmark_node *_Nullable cmarkParsePath(NSString *path, int options, int extensions) {
    if (!path || ![NSFileManager.defaultManager fileExistsAtPath:path]) {
        return NULL;
    }

    NSDictionary *fileAttrs = [NSFileManager.defaultManager attributesOfItemAtPath:path error:NULL];
    NSNumber *fileSize = fileAttrs[NSFileSize];
    if (fileSize.unsignedLongLongValue == 0) {
        return NULL;
    }

    cmark_gfm_core_extensions_ensure_registered();

    cmark_parser *parser = cmark_parser_new(options);
    if (!parser) {
        return NULL;
    }

    cmarkEnableGFM(parser, extensions);

    NSInputStream *fd = [NSInputStream inputStreamWithFileAtPath:path];
    [fd open];
    uint8_t *buffer = (uint8_t *)malloc(MIN(fileSize.unsignedLongLongValue, 1024));
    
    while (fd.hasBytesAvailable) {
        NSInteger len = [fd read:buffer maxLength:1024];
        if (len > 0) {
            cmark_parser_feed(parser, (const char *)buffer, len);
        } else {
            break;
        }
    }

    free(buffer);
    [fd close];

    cmark_node *node = cmark_parser_finish(parser);
    cmark_parser_free(parser);

    return node;
}

void cmarkParseAsATS(cmark_node *node, NSMutableArray<MDNode *> *list, int lvl) {
    while (node) {
        MDNode *last = list.lastObject;
        MDNode *cur = [MDNode nodeWithCMarkNode:node];
        cur.lvl = lvl;
        [list addObject:cur];

        if (lvl > last.lvl) {
            [last addChild:cur];
        } else {
            [last.parent addChild:cur];
            last.next = cur;
        }

        cmark_node *child = cmark_node_first_child(node);
        cmarkParseAsATS(child, list, ++lvl);

        node = cmark_node_next(node);
    }
}
