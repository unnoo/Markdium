//
//  MDNode_internal.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#ifndef MDNode_internal_h
#define MDNode_internal_h

#import "MDNode.h"

@interface MDNode ()

@property(nonatomic, assign) NSInteger lvl;

@property(nonatomic, assign) MDNodeType type;
@property(nonnull, nonatomic, copy) NSString *typeString;

@property(nonatomic, assign) NSInteger startLine;
@property(nonatomic, assign) NSInteger endLine;

@property(nonatomic, assign) NSInteger startColumn;
@property(nonatomic, assign) NSInteger endColumn;

@property(nullable, nonatomic) MDNode *prev;
@property(nullable, nonatomic) MDNode *next;
@property(nullable, nonatomic) MDNode *parent;

+ (nonnull instancetype)nodeWithCMarkNode:(cmark_node * _Nonnull)node;
- (nonnull instancetype)initWithNode:(cmark_node * _Nonnull)node;

- (void)addChild:(MDNode * _Nonnull)node;

@end

@interface MDDocumentNode ()

@end

@interface MDBlockQuoteNode ()

@end

@interface MDListNode ()

@property(nonatomic, assign) MDNodeListDelim listDelim;
@property(nonatomic, assign) MDNodeListType listType;
@property(nonatomic, assign) NSUInteger start;
@property(nonatomic, assign) BOOL tight;

@end

@interface MDItemNode ()

@end

@interface MDCodeBlockNode ()

@property(nullable, nonatomic, copy) NSString *fenceInfo;

@end

@interface MDHTMLBlockNode ()

@end

@interface MDCustomBlockNode ()

@end

@interface MDParagraphNode ()

@end

@interface MDHeadingNode ()

@property(nonatomic, assign) NSInteger level;

@end

@interface MDThematicBreakNode ()

@end

@interface MDTextNode ()

@property(nullable, nonatomic, copy) NSString *literal;

@end

@interface MDSoftBreakNode ()

@end

@interface MDLineBreakNode ()

@end

@interface MDCodeNode ()

@end

@interface MDHTMLInlineNode ()

@end

@interface MDCustomInlineNode ()

@end

@interface MDEmphNode ()

@end

@interface MDStrongNode ()

@end

@interface MDURLNode ()

@property(nullable, nonatomic, copy) NSString *title;
@property(nullable, nonatomic, copy) NSString *url;

@end

@interface MDLinkNode ()

@end

@interface MDImageNode ()

@end

@interface MDFootnoteReferenceNode ()

@end

#endif /* MDNode_internal_h */
