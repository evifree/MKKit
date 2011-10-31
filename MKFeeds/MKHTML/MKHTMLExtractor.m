//
//  MKTextExtractor.m
//  MKKit
//
//  Created by Matthew King on 10/23/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKHTMLExtractor.h"
#import "MKHTMLParser.h"
#import "MKHTMLNode.h"

@implementation MKHTMLExtractor

@synthesize requestHandler, requestType;

- (id)initWithURL:(NSString *)aURL {
	if (self = [super init]) {
        if (aURL == nil) {
            NSException *ecxeption = [NSException exceptionWithName:@"nil URL" reason:@"URL cannot be a nil value." userInfo:nil];
            [ecxeption raise];
        }
		URL = [aURL copy];
        
        MKHTMLExtractorMainBodyText = @"MKHTMLExtractorMainBodyText";
    }
	return self; 
}


#pragma mark - request

- (void)request {
	request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
	
	aConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (aConnection) {
		requestData = [[NSMutableData data] retain];
	} 
	[URL release];
}

- (void)requestType:(MKHTMLExtractorRequestType)type withHandler:(MKHTMLExtractorRequestHandler)handler {
    self.requestHandler = handler;
    self.requestType = type;
    
    [self request];
}

#pragma mark - Connection Delegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [aConnection release];
	[requestData release];
	
	[request release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    ////////////////////////////////////////////////////////////
    // UNCOMMENT THESE LINES TO POST THE FEED DATA IN THE LOG //
    ////////////////////////////////////////////////////////////
    
	//NSString *data = [[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding];
	//NSLog(@"%@", data);
    
    htmlParser = [[MKHTMLParser alloc] initWithData:requestData];
    
	[aConnection release];
	[request release];
    
    MKHTMLExtractorFlags.requestComplete = YES;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (self.requestType == MKHTMLExtractorMainBodyTextRequest) {
        NSString *text = [self mainBodyText];
        
        if (text) {
            [dict setObject:text forKey:MKHTMLExtractorMainBodyText];
        }
        
        if (self.requestHandler) {
            self.requestHandler(dict, nil);
        }
    }
}

#pragma mark - Extractor Methods

- (NSString *)mainBodyText {
    NSMutableString *artical = nil;
    
    if (MKHTMLExtractorFlags.requestComplete) {
        NSArray *elements = nil;
    
        elements = [[htmlParser body] childrenWithAttribute:@"class" value:@"article" allowPartial:YES];
    
        artical = [[[NSMutableString alloc] initWithCapacity:0] autorelease];
    
        for (MKHTMLNode *node in elements) {
            NSArray *children = [node children];
            for (MKHTMLNode *child in children) {
                if ([[child nodeName] isEqualToString:@"p"]) {
                    [artical appendString:[child allText]];
                    [artical appendString:@"\n"];
                }
            }
        }
    }
    return artical;
}

#pragma mark - Memory Mangament

- (void)dealloc {
    self.requestHandler = nil;
    [htmlParser release];
    [requestData release];
    
    [super dealloc];
}

@end
