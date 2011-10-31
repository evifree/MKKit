//
//  MKHTMLParser.m
//  MKKit
//
//  Created by Matthew King on 10/24/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKHTMLParser.h"

#import "MKHTMLParserDelegate.h"
#import "MKHTMLNode.h"

/*
@interface MKHTMLParser ()

- (void)nextNode;

@end
*/

@implementation MKHTMLParser

//@synthesize delegate;

#pragma mark - Initalizer

-(id)initWithData:(NSData *)data {
	self = [super init];
    if (self) {
		htmlDoc = NULL;
        
		if (data) {
			CFStringEncoding cfenc = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
			CFStringRef cfencstr = CFStringConvertEncodingToIANACharSetName(cfenc);
			const char *enc = CFStringGetCStringPtr(cfencstr, 0);
            
			htmlDoc = htmlReadDoc((xmlChar*)[data bytes], "", enc, XML_PARSE_NOERROR | XML_PARSE_NOWARNING);
		}
		else {
		}
	}
	return self;
}

#pragma mark - Base Nodes

- (MKHTMLNode *)root {
    if (htmlDoc == NULL)
		return NULL;
    
	return [[[MKHTMLNode alloc] initWithNode:(xmlNode*)htmlDoc] autorelease];
}

- (MKHTMLNode *)body {
    if (htmlDoc == NULL) {
        return NULL;
    }
    
    return [[self root] childNodeNamed:@"body"]; 
}

/*
#pragma mark - Pasing

- (void)parseNode:(MKHTMLNode *)node {
    mCurrentNode = [node retain];
    [self.delegate HTMLParserDidStart:self];
    
    [self nextNode];
}

- (void)nextNode {
    if (mCurrentNode != nil || mCurrentNode != NULL) {
        [self.delegate HTMLParser:self didFindNodeNamed:[mCurrentNode nodeName]];
        NSString *string = [mCurrentNode allText];
        
        if ([string length] > 0) {
            [self.delegate HTMLParser:self didFindString:string];
        }
        
        if ([self.delegate respondsToSelector:@selector(HTMLParser:didEndNodeNamed:)]) {
            [self.delegate HTMLParser:self didEndNodeNamed:[mCurrentNode nodeName]];
        }
        
        [self parseNode:[mCurrentNode nextChildNode]];
        
        [mCurrentNode release];
        mCurrentNode = nil;
    }
    else {
        [self.delegate HTMLParserDidEnd:self];
    }
}
*/
 
#pragma mark - Memory Managment

- (void)dealloc {
    //self.delegate = nil;
    
    if (htmlDoc) {
        xmlFreeDoc(htmlDoc);
    }
    
    [super dealloc];
}

@end
