//
//  MKHTMLParserDelegate.h
//  MKKit
//
//  Created by Matthew King on 10/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKHTMLParser;

@protocol MKHTMLParserDelegate <NSObject>

- (void)HTMLParserDidStart:(MKHTMLParser *)parser;

- (void)HTMLParserDidEnd:(MKHTMLParser *)parser;

- (void)HTMLParser:(MKHTMLParser *)parser didFindNodeNamed:(NSString *)name;

- (void)HTMLParser:(MKHTMLParser *)parser didFindString:(NSString *)string;

@optional

- (void)HTMLParser:(MKHTMLParser *)parser didEndNodeNamed:(NSString *)name;

@end
