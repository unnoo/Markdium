//
//  CMarkParser.h
//  Markdium
//
//  Created by v on 2019/11/16.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDNode.h"

NSString *_Nullable getNodeTypeString(cmark_node *_Nonnull node);

NSString *_Nullable getNodeLiteral(cmark_node *_Nonnull node);

cmark_node *_Nullable cmarkParseString(NSString *_Nonnull string, int options, int extensions);

cmark_node *_Nullable cmarkParsePath(NSString *_Nonnull path, int options, int extensions);

void cmarkParseAsATS(cmark_node *_Nonnull node, NSMutableArray<MDNode *> *_Nonnull list, int lvl);
