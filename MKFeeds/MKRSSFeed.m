//
//  MKRSSFeed.m
//  MKKit
//
//  Created by Matthew King on 8/13/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKRSSFeed.h"

@implementation MKRSSFeed

@synthesize url=mUrl, delegate, requestCompleteBlock=mRequestCompleteBlock;

static NSString *currentElement = nil;

- (id)initWithURL:(NSString *)aURL delegate:(id<MKRSSFeedDelegate>)theDelegate {
	if (self = [super init]) {
        if (aURL == nil) {
            NSException *ecxeption = [NSException exceptionWithName:@"nil URL" reason:@"URL cannot be a nil value." userInfo:nil];
            [ecxeption raise];
        }
		mUrl = [aURL copy];
		delegate = theDelegate;
        
        MKFeedRSSFeedItem = @"item";
        MKFeedRSSFeedTitle = @"title";
        MKFeedRSSFeedDescription = @"description";
        MKFeedRSSFeedLink = @"link";
	}
	return self; 
}

#pragma mark - request

- (void)request {
	request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:mUrl]];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (theConnection) {
		requestData = [[NSMutableData data] retain];
	} else{
	}
	[mUrl release];
}

- (void)requestWithCompletionBlock:(MKRequestComplete)block {
    self.requestCompleteBlock = block;
    MKRSSFeedTags.usesCompletionBlock = YES;
    [self request];
}

#pragma mark -
#pragma mark Connection Delegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    //[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	// append the new data to the receivedData
	// receivedData is declared as a method instance elsewhere
	[requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// release the connection, and the data object
	[theConnection release];
	// receivedData is declared as a method instance elsewhere
	[requestData release];
	
	[request release];
	
    // inform the user
    
    if (MKRSSFeedTags.usesCompletionBlock) {
        self.requestCompleteBlock(nil, error);
    }
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//NSString *data = [[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding];
	//NSLog(@"%@", data);
	
	theParser = [[NSXMLParser alloc] initWithData:requestData];
	[theParser setDelegate:self];
	[theParser parse];
	
	// release the connection, and the data object
	[theConnection release];
	[requestData release];
	[request release];
}

#pragma mark parser

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	items = [[[NSMutableArray alloc] initWithCapacity:15] retain];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
		feed = [[NSMutableDictionary alloc] initWithCapacity:3];
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedTitle]) {
		currentElement = elementName;
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedDescription]) {
		currentElement = elementName;
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedLink]) {
		currentElement = elementName;
	}

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!currentString) {
		currentString = [[NSMutableString alloc] initWithCapacity:100];
	}
	[currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
		[items addObject:feed];
		[feed release];
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedTitle]) {
		NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		NSString *title = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
		[feed setObject:title forKey:currentElement];
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedDescription]) {
		NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		NSString *discription = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
		[feed setObject:discription forKey:currentElement];
	}
	else if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
		[feed setObject:currentString forKey:currentElement];
	}
	
	[currentString release];
	currentString = nil;
	currentElement = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (MKRSSFeedTags.usesCompletionBlock) {
        self.requestCompleteBlock(items, nil);
    }
    else {
        [delegate RSSFeed:self didReturnData:items];
    }
	
	[items release];
	[theParser release];
}

-(void)dealloc {
    self.delegate = nil;
    self.requestCompleteBlock = nil;

	[super dealloc];
}

@end
