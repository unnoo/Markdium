//
//  Markdium.swift
//  Markdium
//
//  Created by v on 2019/11/15.
//  Copyright © 2019 lvv. All rights reserved.
//

#import "Markdium.h"
#import <string>
#import <sstream>
#import "CMarkParser.h"
#import "MDNode_internal.h"

@interface Markdium ()

@property(nonatomic, assign) NSInteger options;
@property(nonatomic, unsafe_unretained) cmark_node *document;

@end

@implementation Markdium

- (void)dealloc {
    if (_document) {
        cmark_node_free(_document);
    }
}

- (instancetype)initWithString:(NSString *)string {
    return [self initWithString:string options:MDOptionDefault];
}

- (instancetype)initWithString:(NSString *)string options:(MDOptions)options {
    return [self initWithString:string options:options extensions:MDExtensionNone];
}

- (instancetype)initWithString:(NSString *)string options:(MDOptions)options extensions:(MDExtensions)extensions {
    if (!string) {
        return nil;
    }

    cmark_node *node = cmarkParseString(string, (int)options, (int)extensions);
    if (!node) {
        return nil;
    }

    if (self = [super init]) {
        _options = options;
        _document = node;
    }

    return self;
}

- (instancetype)initWithPath:(NSString *)path {
    return [self initWithPath:path options:MDOptionDefault];
}

- (instancetype)initWithPath:(NSString *)path options:(MDOptions)options {
    return [self initWithPath:path options:options extensions:MDExtensionNone];
}

- (instancetype)initWithPath:(NSString *)path options:(MDOptions)options extensions:(MDExtensions)extensions {
    if (!path) {
        return nil;
    }

    cmark_node *node = cmarkParsePath(path, (int)options, (int)extensions);
    if (!node) {
        return nil;
    }

    if (self = [super init]) {
        _options = options;
        _document = node;
    }

    return self;
}

@end

@implementation Markdium (split)

+ (nonnull NSArray<NSString *> *)splitByLines:(nonnull NSString *)markdown {
    NSMutableArray<NSString *> *lines = [NSMutableArray array];
    std::string source(markdown.UTF8String);
    std::istringstream iss(source);

    std::string line;
    while(std::getline(iss, line)) {
        [lines addObject:[NSString stringWithUTF8String:line.c_str()]];
    }

    return [lines copy];
}

@end

@implementation Markdium (enumeration)

+ (void)enumerateNode:(cmark_node *)node withBlock:(void (^NS_NOESCAPE)(cmark_node *))block {
    if (!node || !block) {
        return;
    }

    block(node);

    cmark_node *child = cmark_node_first_child(node);
    while (cmark_node *current = child) {
        [self enumerateNode:current withBlock:block];
        child = cmark_node_next(child);
    }
}

+ (void)parseMarkdown:(NSString *_Nonnull)markdown extensions:(MDExtensions)extensions nodeHandler:(void (^NS_NOESCAPE _Nullable)(cmark_node *_Nonnull))block {
    cmark_node *root = cmarkParseString(markdown, (int)(MDOptionHardBreaks | MDOptionUnsafe), (int)extensions);
    if (!root) {
        return;
    }

    if (block) {
        [self enumerateNode:root withBlock:block];
    }

    cmark_node_free(root);
}

@end

@implementation Markdium (parse)

- (nonnull NSArray<MDNode *> *)parseAsAST {
    NSMutableArray<MDNode *> *list = NSMutableArray.array;
    cmarkParseAsATS(_document, list, 0);

    return list;
}

@end

@implementation Markdium (render)

- (NSString *)renderAsHTML {
    NSString *output = nil;
    char *html = cmark_render_html(self.document, (int)self.options, NULL);
    if (html) {
        output = [NSString stringWithUTF8String:html];
        free(html);
    }

    return output;
}

- (NSString *)renderAsXML {
    NSString *output = nil;
    char *xml = cmark_render_xml(self.document, (int)self.options);
    if (xml) {
        output = [NSString stringWithUTF8String:xml];
        free(xml);
    }

    return output;
}

- (NSString *)renderAsMAN {
    NSString *output = nil;
    char *man = cmark_render_man(self.document, (int)self.options, (int)self.width);
    if (man) {
        output = [NSString stringWithUTF8String:man];
        free(man);
    }

    return output;
}

- (NSString *)renderAsLatex {
    NSString *output = nil;
    char *latex = cmark_render_latex(self.document, (int)self.options, (int)self.width);
    if (latex) {
        output = [NSString stringWithUTF8String:latex];
        free(latex);
    }

    return output;
}

- (NSString *)renderAsCommonMark {
    NSString *output = nil;
    char *md = cmark_render_commonmark(self.document, (int)self.options, (int)self.width);
    if (md) {
        output = [NSString stringWithUTF8String:md];
        free(md);
    }

    return output;
}

- (NSString *)renderAsPlaintext {
    NSString *output = nil;
    char *txt = cmark_render_plaintext(self.document, (int)self.options, (int)self.width);
    if (txt) {
        output = [NSString stringWithUTF8String:txt];
        free(txt);
    }

    return output;
}

@end

@implementation Markdium (version)

+ (NSString *)versionString {
    return [NSString stringWithUTF8String:cmark_version_string()];
}

+ (NSInteger)version {
    return cmark_version();
}

@end
