//
//  MDNode.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Markdium/MarkdiumTypes.h>

@interface MDNode : NSObject

@property(nonatomic, readonly) MDNodeType type;
@property(nonnull, nonatomic, readonly) NSString *typeString;

@property(nonatomic, readonly) NSInteger startLine;
@property(nonatomic, readonly) NSInteger startColumn;

@property(nonatomic, readonly) NSInteger endLine;
@property(nonatomic, readonly) NSInteger endColumn;

@property(nonnull, nonatomic, copy) NSString *content;

+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

@end

@interface MDDocumentNode : MDNode

@end

@interface MDBlockQuoteNode : MDNode

@end

@interface MDListNode : MDNode

@property(nonatomic, readonly) MDNodeListDelim listDelim;
@property(nonatomic, readonly) MDNodeListType listType;
@property(nonatomic, readonly) NSUInteger start;
@property(nonatomic, readonly) BOOL tight;

@end

@interface MDItemNode : MDNode

@end

@interface MDTextNode : MDNode

@property(nullable, nonatomic, readonly) NSString *literal;

@end

@interface MDCodeBlockNode : MDTextNode

@property(nullable, nonatomic, readonly) NSString *fenceInfo;

@end

@interface MDHTMLBlockNode : MDTextNode

@end

@interface MDCustomBlockNode : MDNode

@end

@interface MDParagraphNode : MDNode

@end

@interface MDHeadingNode : MDNode

@property(nonatomic, readonly) NSInteger level;

@end

@interface MDThematicBreakNode : MDNode

@end

@interface MDSoftBreakNode : MDNode

@end

@interface MDLineBreakNode : MDNode

@end

@interface MDCodeNode : MDTextNode

@end

@interface MDHTMLInlineNode : MDTextNode

@end

@interface MDCustomInlineNode : MDNode

@end

@interface MDEmphNode : MDNode

@end

@interface MDStrongNode : MDNode

@end

@interface MDURLNode : MDNode

@property(nullable, nonatomic, readonly) NSString *title;
@property(nullable, nonatomic, readonly) NSString *url;

@end

@interface MDLinkNode : MDURLNode

@end

@interface MDImageNode : MDURLNode

@end

@interface MDFootnoteReferenceNode : MDTextNode

@end
