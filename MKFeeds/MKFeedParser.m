//
//  MKRSSFeed.m
//  MKKit
//
//  Created by Matthew King on 8/13/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKFeedParser.h"

@implementation MKFeedParser

@synthesize url=mUrl, delegate, requestCompleteBlock=mRequestCompleteBlock;

@dynamic sourceType, contentType; 

static NSString *currentElement = nil;

- (id)initWithURL:(NSString *)aURL delegate:(id<MKFeedParserDelegate>)theDelegate {
	if (self = [super init]) {
        if (aURL == nil) {
            NSException *ecxeption = [NSException exceptionWithName:@"nil URL" reason:@"URL cannot be a nil value." userInfo:nil];
            [ecxeption raise];
        }
		mUrl = [aURL copy];
		delegate = theDelegate;
        
        MKFeedRSSFeedStart = @"rss";
        MKFeedRSSFeedItem = @"item";
        MKFeedAtomFeedStart = @"feed";
        MKFeedAtomFeedEntry = @"entry";
        
        MKFeedRSSFeedTitle = @"title";
        MKFeedRSSFeedDescription = @"description";
        MKFeedRSSFeedLink = @"link";
        MKFeedRSSFeedPublicationDate = @"pubDate";
        MKFeedRSSFeedGUID = @"guid";
        
        MKFeedAtomTitle = @"title";
        MKFeedAtomLink = @"link";
        MKFeedAtomID = @"id";
        MKFeedAtomUpdated = @"updated";
        MKFeedAtomSummary = @"summary";
        MKFeedAtomAuthorName = @"name";
	}
	return self; 
}

#pragma mark - Accessor Methods
#pragma mark Getters

- (MKFeedContentType)contentType {
    return mContentType;
}

- (MKFeedSourceType)sourceType {
    return mSourceType;
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
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [theConnection release];
	[requestData release];
	
	[request release];
    
    if (MKRSSFeedTags.usesCompletionBlock) {
        self.requestCompleteBlock(nil, error);
    }
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    ////////////////////////////////////////////////////////////
    // UNCOMMENT THESE LINES TO POST THE FEED DATA IN THE LOG //
    ////////////////////////////////////////////////////////////
    
	NSString *data = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
	NSLog(@"%@", data);
	
	theParser = [[NSXMLParser alloc] initWithData:requestData];
	[theParser setDelegate:self];
	[theParser parse];
	
	[theConnection release];
	[requestData release];
	[request release];
}

#pragma mark parser

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	items = [[[NSMutableArray alloc] initWithCapacity:15] retain];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	if ([elementName isEqualToString:MKFeedRSSFeedStart]) {
        mSourceType = MKFeedSourceRSS;
    }
    else if ([elementName isEqualToString:MKFeedAtomFeedStart]) {
        mSourceType = MKFeedSourceAtom;
    }
    
    //////// RSS FEED PROCESSING
    //////////////////////////////////////////////////////////////////////////////////////
    if (mSourceType == MKFeedSourceRSS) {
        if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
            feed = [[NSMutableDictionary alloc] initWithCapacity:0];
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
        else if ([elementName isEqualToString:MKFeedRSSFeedGUID]) {
            currentElement = elementName;
        }
        else if ([elementName isEqualToString:MKFeedRSSFeedPublicationDate]) {
            currentElement = elementName;
        }
    }
    
    //////// ATOM FEED PROCESSING
    ////////////////////////////////////////////////////////////////////////////////////////
    if (mSourceType == MKFeedSourceAtom) {
        if ([elementName isEqualToString:MKFeedAtomFeedEntry]) {
            feed = [[NSMutableDictionary alloc] initWithCapacity:0];
        }
        else if ([elementName isEqualToString:MKFeedAtomTitle]) {
            currentElement = elementName;
        }
        else if ([elementName isEqualToString:MKFeedAtomID]) {
            currentElement = elementName;
        }
        else if ([elementName isEqualToString:MKFeedAtomSummary]) {
            currentElement = elementName;
            if ([[attributeDict objectForKey:@"type"] isEqualToString:@"html"]) {
                mContentType = MKFeedContentHTML;
            }
            else {
                mContentType = MKFeedContentPlainText;
            }
        }
        else if ([elementName isEqualToString:MKFeedAtomUpdated]) {
            currentElement = elementName;
        }
        else if ([elementName isEqualToString:MKFeedAtomLink]) {
            currentElement = elementName;
            NSString *link = (NSString *)[attributeDict objectForKey:@"href"];
            [feed setObject:link forKey:MKFeedAtomLink];
        }
        else if ([elementName isEqualToString:MKFeedAtomAuthorName]) {
            currentElement = elementName;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!currentString) {
		currentString = [[NSMutableString alloc] initWithCapacity:100];
	}
	[currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	////////////////// RSS FEED PROCESSING
    ///////////////////////////////////////////////////////////////////////////////////////////
    if (mSourceType == MKFeedSourceRSS) {
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
        else if ([elementName isEqualToString:MKFeedRSSFeedLink]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *link = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:link forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedRSSFeedGUID]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *guid = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:guid forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedRSSFeedPublicationDate]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *pubDate = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:pubDate forKey:currentElement];
        }
    }
    
    /////////////////// ATOM FEED PROCESSING
    ////////////////////////////////////////////////////////////////////////////////////////////////
    if (mSourceType == MKFeedSourceAtom) {
        if ([elementName isEqualToString:MKFeedAtomFeedEntry]) {
            [items addObject:feed];
            [feed release];
        }
        else if ([elementName isEqualToString:MKFeedAtomTitle]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *title = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:title forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedAtomID]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *feedID = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:feedID forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedAtomSummary]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *summary = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:summary forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedAtomUpdated]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *updated = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:updated forKey:currentElement];
        }
        else if ([elementName isEqualToString:MKFeedAtomAuthorName]) {
            NSString *formatString = [currentString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *authorName = [formatString stringByReplacingOccurrencesOfString:@"  " withString:@""];
            [feed setObject:authorName forKey:currentElement];
        }

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
        [delegate feed:self didReturnData:items];
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
