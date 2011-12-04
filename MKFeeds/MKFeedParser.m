//
//  MKRSSFeed.m
//  MKKit
//
//  Created by Matthew King on 8/13/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKFeedParser.h"
#import "NSString+MKFeedParser.h"
#import "MKFeedItem.h"

@implementation MKFeedParser

@synthesize url=mUrl, delegate, requestCompleteBlock=mRequestCompleteBlock;

@dynamic sourceType, contentType; 

- (id)initWithURL:(NSString *)aURL delegate:(id<MKFeedParserDelegate>)theDelegate {
	if (self = [super init]) {
        if (aURL == nil) {
            MKFeedParserNILURLException = @"MKFeedParserNILURLException";
            NSException *exception = [NSException exceptionWithName:MKFeedParserNILURLException reason:@"URL cannot be a nil value." userInfo:nil];
            @throw exception;
        }
		mUrl = [aURL copy];
		delegate = theDelegate;
        
        MKFeedRSSFeedStart = @"rss";
        MKFeedRSSFeedItem = @"item";
        MKFeedAtomFeedStart = @"feed";
        MKFeedAtomFeedEntry = @"entry";
        
        MKFeedRSSFeedTitle = @"title";
        MKFeedRSSFeedDescription = @"description";
        MKFeedRSSFeedDescriptionHTML = @"descriptionHTML";
        MKFeedRSSFeedLink = @"link";
        MKFeedRSSFeedOriginalLink = @"originalLink";
        MKFeedRSSFeedPublicationDate = @"pubDate";
        MKFeedRSSFeedGUID = @"guid";
        MKFeedRSSFeedCreator = @"dc:creator";
        
        MKFeedAtomTitle = @"title";
        MKFeedAtomLink = @"link";
        MKFeedAtomID = @"id";
        MKFeedAtomUpdated = @"updated";
        MKFeedAtomContent = @"content";
        MKFeedAtomSummary = @"summary";
        MKFeedAtomSummaryHTML = @"summaryHTML";
        MKFeedAtomAuthorName = @"name";
	}
	return self; 
}

#pragma mark - Memory Management

-(void)dealloc {
    self.delegate = nil;
    self.requestCompleteBlock = nil;
    
	[super dealloc];
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
	request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:mUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
	
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
	
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
	[request release];
    
    if (MKRSSFeedTags.usesCompletionBlock) {
        self.requestCompleteBlock(nil, error);
    }
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    ////////////////////////////////////////////////////////////
    // UNCOMMENT THESE LINES TO POST THE FEED DATA IN THE LOG //
    ////////////////////////////////////////////////////////////
    
	//NSString *data = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
	//NSLog(@"%@", data);
	
	theParser = [[NSXMLParser alloc] initWithData:requestData];
    [theParser setShouldProcessNamespaces:YES];
	[theParser setDelegate:self];
	[theParser parse];
	
	[theConnection release];
	[requestData release];
    
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
	[request release];
}

#pragma mark parser

- (void)parserDidStartDocument:(NSXMLParser *)parser {
	items = [[[NSMutableArray alloc] initWithCapacity:15] retain];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([qualifiedName isEqualToString:MKFeedRSSFeedStart]) {
        mSourceType = MKFeedSourceRSS;
    }
    else if ([qualifiedName isEqualToString:MKFeedAtomFeedStart]) {
        mSourceType = MKFeedSourceAtom;
    }
    
    switch (mSourceType) {
        case MKFeedSourceRSS: {
            if ([qualifiedName isEqualToString:MKFeedRSSFeedItem]) {
                mFeedItem = [[MKFeedItem alloc] initWithType:MKFeedSourceRSS];
            }
            else {
                currentElement = [qualifiedName copy];
            }
        } break;
        case MKFeedSourceAtom: {
            if ([qualifiedName isEqualToString:MKFeedAtomFeedEntry]) {
                mFeedItem = [[MKFeedItem alloc] initWithType:MKFeedSourceAtom];
            } 
            else if ([qualifiedName isEqualToString:MKFeedAtomLink]) {
                currentElement = qualifiedName;
                NSString *link = (NSString *)[attributeDict objectForKey:@"href"];
                [mFeedItem addValue:link forElement:MKFeedAtomLink];
            }
            else {
                currentElement = [qualifiedName copy];
            }
        } break;
        default: break;
    }
    
    /*
    switch (mSourceType) {
        case MKFeedSourceRSS: {
            if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
                //mFeedItem = [[[MKFeedItem alloc] initWithType:MKFeedSourceRSS] retain];
                feed = [[NSMutableDictionary alloc] initWithCapacity:0];
            }
            else if ([qualifiedName isEqualToString:MKFeedRSSFeedTitle]) {
                currentElement = qualifiedName;
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedDescription]) {
                currentElement = elementName;
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedLink]) {
                currentElement = elementName;
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedOriginalLink]) {
                currentElement = elementName;
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedGUID]) {
                currentElement = elementName;
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedPublicationDate]) {
                currentElement = elementName;
            }
            else if ([qualifiedName isEqualToString:MKFeedRSSFeedCreator]) {
                currentElement = qualifiedName;
            }
        } break;
        case MKFeedSourceAtom: {
            if ([elementName isEqualToString:MKFeedAtomFeedEntry]) {
                //mFeedItem = [[[MKFeedItem alloc] initWithType:MKFeedSourceAtom] retain];
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
                    mContentType = MKFeedContentTypeHTMLEntities;
                }
                else if ([[attributeDict objectForKey:@"type"] isEqualToString:@"xhtml"]) {
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
        } break;
        default:
        break;
    }
    */
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!currentString) {
		currentString = [[NSMutableString alloc] initWithCapacity:100];
	}
	[currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    switch (mSourceType) {
        case MKFeedSourceRSS: {
            if ([qName isEqualToString:MKFeedRSSFeedItem]) {
                [items addObject:mFeedItem];
                [mFeedItem release];
            }  
            else { 
                [mFeedItem addValue:[currentString stringByRemovingNewLinesAndWhitespace] forElement:currentElement];
            }
        } break;
        case MKFeedSourceAtom: {
            if ([qName isEqualToString:MKFeedAtomFeedEntry]) {
                [items addObject:mFeedItem];
                [mFeedItem release];
            }
            else if (![qName isEqualToString:MKFeedAtomLink]) {
                [mFeedItem addValue:[currentString stringByRemovingNewLinesAndWhitespace] forElement:currentElement];
            }
        } break;
        default: break;
    }
    /*
    switch (mSourceType) {
        case MKFeedSourceRSS: {
            if ([elementName isEqualToString:MKFeedRSSFeedItem]) {
                [items addObject:feed];
                [feed release];
            }
            else if ([qName isEqualToString:MKFeedRSSFeedTitle]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedDescription]) {
                if (![currentString stringContainsHTMLTags]) {
                    NSString *decodeString = [currentString stringByDecodingHTMLEntities];
                    [feed setObject:[decodeString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
                }
                else {
                    [feed setObject:currentString forKey:MKFeedRSSFeedDescriptionHTML];
                    mContentType = MKFeedContentHTML;
                }
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedLink]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedOriginalLink]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedGUID]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedRSSFeedPublicationDate]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];           
            }
            else if ([qName isEqualToString:MKFeedRSSFeedCreator]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:MKFeedRSSFeedCreator];
            }
        } break;
        case MKFeedSourceAtom: {
            if ([elementName isEqualToString:MKFeedAtomFeedEntry]) {
                [items addObject:feed];
                [feed release];
            }
            else if ([elementName isEqualToString:MKFeedAtomTitle]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedAtomID]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedAtomSummary]) {
                if (![currentString stringContainsHTMLTags]) {
                    NSString *decodeString = [currentString stringByDecodingHTMLEntities];
                    [feed setObject:[decodeString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
                }
                else  {
                    [feed setObject:currentString forKey:MKFeedAtomSummaryHTML];
                    mContentType = MKFeedContentHTML;
                }
            }
            else if ([elementName isEqualToString:MKFeedAtomUpdated]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
            else if ([elementName isEqualToString:MKFeedAtomAuthorName]) {
                [feed setObject:[currentString stringByRemovingNewLinesAndWhitespace] forKey:currentElement];
            }
        } break;
        default:
        break;
    }
    */
    [currentString release];
	currentString = nil;
    
    [currentElement release];
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

@end
