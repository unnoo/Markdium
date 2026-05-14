//
//  MDNode.m
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "MDNode.h"
#import "MDNode_internal.h"

static Class classForNodeType(MDNodeType type) {
    Class cls = @{
        @(MDNodeTypeDocument): MDDocumentNode.class,
        @(MDNodeTypeBlockQuote): MDBlockQuoteNode.class,
        @(MDNodeTypeList): MDListNode.class,
        @(MDNodeTypeItem): MDItemNode.class,
        @(MDNodeTypeCodeBlock): MDCodeBlockNode.class,
        @(MDNodeTypeHTMLBlock): MDHTMLBlockNode.class,
        @(MDNodeTypeCustomBlock): MDCustomBlockNode.class,
        @(MDNodeTypeParagraph): MDParagraphNode.class,
        @(MDNodeTypeHeading): MDHeadingNode.class,
        @(MDNodeTypeThematicBreak): MDThematicBreakNode.class,
        @(MDNodeTypeText): MDTextNode.class,
        @(MDNodeTypeSoftBreak): MDSoftBreakNode.class,
        @(MDNodeTypeLineBreak): MDLineBreakNode.class,
        @(MDNodeTypeCode): MDCodeNode.class,
        @(MDNodeTypeHTMLInline): MDHTMLInlineNode.class,
        @(MDNodeTypeCustomInline): MDCustomInlineNode.class,
        @(MDNodeTypeEmph): MDEmphNode.class,
        @(MDNodeTypeStrong): MDStrongNode.class,
        @(MDNodeTypeLink): MDLinkNode.class,
        @(MDNodeTypeImage): MDImageNode.class,
        @(MDNodeTypeFootnoteReference): MDFootnoteReferenceNode.class
    }[@(type)];

    return cls ? : MDNode.class;
}

@implementation MDNode

+ (instancetype)nodeWithCMarkNode:(cmark_node *)node {
    MDNodeType type = (MDNodeType)cmark_node_get_type(node);
    Class nodeClass = classForNodeType(type);

    return [[nodeClass alloc] initWithNode:node];
}

- (instancetype)initWithNode:(cmark_node *)node {
    if (!node) {
        return nil;
    }

    if (self = [super init]) {
        _type = (MDNodeType)cmark_node_get_type(node);
        _typeString = [NSString stringWithUTF8String:cmark_node_get_type_string(node)];
        _startLine = cmark_node_get_start_line(node);
        _startColumn = cmark_node_get_start_column(node);

        _endLine = cmark_node_get_end_line(node);
        _endColumn = cmark_node_get_end_column(node);

        const char *str = cmark_node_get_string_content(node);
        _content = [NSString stringWithUTF8String:str];
    }

    return self;
}

- (void)setNext:(MDNode *)next {
    _next = next;
    next.prev = self;
}

- (void)addChild:(MDNode *)node {
    if (node) {
        node.parent = self;
    }
}

@end

@implementation MDDocumentNode

@end

@implementation MDBlockQuoteNode

@end

@implementation MDListNode

- (instancetype)initWithNode:(cmark_node *)node {
    if (self = [super initWithNode:node]) {
        _listType = (MDNodeListType)cmark_node_get_list_type(node);
        _listDelim = (MDNodeListDelim)cmark_node_get_list_delim(node);
        _start = cmark_node_get_list_start(node);
        _tight = (BOOL)cmark_node_get_list_tight(node);
    }

    return self;
}

@end

@implementation MDItemNode

@end

@implementation MDCodeBlockNode

- (instancetype)initWithNode:(cmark_node *)node {
    if (self = [super initWithNode:node]) {
        const char *str = cmark_node_get_fence_info(node);
        _fenceInfo = [NSString stringWithUTF8String:str];
    }

    return self;
}

@end

@implementation MDHTMLBlockNode

@end

@implementation MDCustomBlockNode

@end

@implementation MDParagraphNode

@end

@implementation MDHeadingNode

- (instancetype)initWithNode:(cmark_node *)node {
    if (self = [super initWithNode:node]) {
        _level = cmark_node_get_heading_level(node);
    }

    return self;
}

@end

@implementation MDThematicBreakNode

@end

@implementation MDTextNode

- (instancetype)initWithNode:(cmark_node *)node {
    if (self = [super initWithNode:node]) {
        const char *str = cmark_node_get_literal(node);
        _literal = [NSString stringWithUTF8String:str];
    }

    return self;
}

@end

@implementation MDSoftBreakNode

@end

@implementation MDLineBreakNode

@end

@implementation MDCodeNode

@end

@implementation MDHTMLInlineNode

@end

@implementation MDCustomInlineNode

@end

@implementation MDEmphNode

@end

@implementation MDStrongNode

@end

@implementation MDURLNode

- (instancetype)initWithNode:(cmark_node *)node {
    if (self = [super initWithNode:node]) {
        const char *str = cmark_node_get_url(node);
        _url = [NSString stringWithUTF8String:str];

        str = cmark_node_get_title(node);
        _title = [NSString stringWithUTF8String:str];
    }

    return self;
}

@end

@implementation MDLinkNode

@end

@implementation MDImageNode

@end

@implementation MDFootnoteReferenceNode

@end
