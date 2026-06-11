//
//  Markdium.h
//  Markdium
//
//  Created by v on 2019/11/15.
//  Copyright © 2019 lvv. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Markdium/config.h>
#import <Markdium/chunk.h>
#import <Markdium/buffer.h>
#import <Markdium/node.h>
#import <Markdium/cmark_ctype.h>
#import <Markdium/export.h>
#import <Markdium/cmark-gfm_version.h>
#import <Markdium/cmark-gfm.h>
#import <Markdium/cmark-gfm-extension_api.h>
#import <Markdium/cmark-gfm-core-extensions.h>
#import <Markdium/MarkdiumTypes.h>
#import <Markdium/MDNode.h>

extern cmark_node_type CMARK_NODE_TABLE, CMARK_NODE_TABLE_ROW,
    CMARK_NODE_TABLE_CELL;

@interface Markdium : NSObject

@property(nonatomic, assign) NSUInteger width;  // Specify wrap width (default 0 = nowrap)

+ (nullable instancetype)new NS_UNAVAILABLE;
- (nullable instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithString:(nonnull NSString *)string;
- (nullable instancetype)initWithString:(nonnull NSString *)string options:(MDOptions)options;
- (nullable instancetype)initWithString:(nonnull NSString *)string options:(MDOptions)options extensions:(MDExtensions)extensions;

- (nullable instancetype)initWithPath:(nonnull NSString *)path;
- (nullable instancetype)initWithPath:(nonnull NSString *)path options:(MDOptions)options;
- (nullable instancetype)initWithPath:(nonnull NSString *)path options:(MDOptions)options extensions:(MDExtensions)extensions;

@end

@interface Markdium (split)

/// 使用 C++ 的字符操作方式按换行符分割字符串，逻辑保持和 cmark 一致
+ (nonnull NSArray<NSString *> *)splitByLines:(nonnull NSString *)markdown;

@end

@interface Markdium (enumeration)

+ (void)parseMarkdown:(NSString *_Nonnull)markdown extensions:(MDExtensions)extensions nodeHandler:(void (^NS_NOESCAPE _Nullable)(cmark_node *_Nonnull))block;

@end

@interface Markdium (parse)

- (nonnull NSArray<MDNode *> *)parseAsAST;

@end

@interface Markdium (render)

- (nullable NSString *)renderAsHTML;

- (nullable NSString *)renderAsXML;

- (nullable NSString *)renderAsMAN;

- (nullable NSString *)renderAsLatex;

- (nullable NSString *)renderAsCommonMark;

- (nullable NSString *)renderAsPlaintext;

@end

@interface Markdium (version)

+ (nonnull NSString *)versionString;

+ (NSInteger)version;

@end
