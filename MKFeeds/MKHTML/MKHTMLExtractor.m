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
#import "MKHTMLExtractorDelegate.h"

#import <MKKit/MKFeeds/NSString+MKFeedParser.h>

@interface MKHTMLExtractor ()

- (id)init;
- (void)request;
- (NSString *)mainBodyHTMLFromParsedData:(MKHTMLParser *)parsedData;
- (void)extractFromData:(NSData *)data;
- (void)findNextPageFromParsedData:(MKHTMLParser *)parsedData;
- (void)requestPage:(NSString *)url;

- (NSString *)styledTitleFromNode:(MKHTMLNode *)node;
- (NSString *)styledParagraphFromNode:(MKHTMLNode *)node;
- (NSString *)styledEmbedFromNode:(MKHTMLNode *)node;

@end

@implementation MKHTMLExtractor

@synthesize articleTitle, requestHandler, requestType, delegate;

@dynamic results, numberOfPages, optimizeOutputForiPhone;

- (id)init {
    self = [super init];
    if (self) {
        MKHTMLExtractorFlags.articalTitleSet = NO;
        MKHTMLExtractorFlags.usesCustomStyle = NO;
        MKHTMLExtractorFlags.currentPage    = 1;
        MKHTMLExtractorFlags.numberOfPages  = 0;
        MKHTMLExtractorFlags.attemptCount   = 0;
        
        MKHTMLAttribueValue *first = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"id" value:@"text"] autorelease];
        MKHTMLAttribueValue *second = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"class" value:@"article"] autorelease];
        MKHTMLAttribueValue *third = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"id" value:@"post"] autorelease];
        MKHTMLAttribueValue *fourth = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"class" value:@"entry"] autorelease];
        MKHTMLAttribueValue *fifth = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"id" value:@"content"] autorelease];
        
        mAttributesArray = [[NSArray alloc] initWithObjects:first, second, third, fourth, fifth, nil];
    }
    return self;
}

- (id)initWithURL:(NSString *)aURL {
	if (self = [super init]) {
        if (aURL == nil) {
            MKHTMLExtractorNILURLExecption = @"MKHTMLExtractorNILURLExectption";
            NSException *ecxeption = [NSException exceptionWithName:MKHTMLExtractorNILURLExecption reason:@"URL cannot be a nil value." userInfo:nil];
            @throw ecxeption;
        }
		URL = [aURL copy];
        
        MKHTMLExtractorFlags.requestFromURL = YES;
        
        self = [self init];
    }
	return self; 
}

- (id)initWithHTMLString:(NSString *)htmlString {
    self = [super init];
    if (self) {
        if (htmlString == nil) {
            MKHTMLExtractorNILHTMLStringException = @"MKHTMLExtractorNILHTMLStringExeption";
            //NSException *exception = [NSException exceptionWithName:MKHTMLExtractorNILHTMLStringException reason:@"htmlString cannot be a nil value" userInfo:nil];
            //@throw exception;
        }
        mHTMLString = [htmlString copy];
        MKHTMLExtractorFlags.requestFromURL = NO;
        
        self = [self init];
    }
    return self;
}

#pragma mark - Memory Mangament

- (void)dealloc {
    self.articleTitle = nil;
    self.requestHandler = nil;
    self.delegate = nil;
    
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    [mResultsDict release];
    [aConnection release];
    [request release];
    [requestData release];
    [mHTMLHeaderString release];
    
    if (MKHTMLExtractorFlags.requestFromURL) {
        [URL release];
    }
    
    [super dealloc];
}

#pragma mark - Accessor Methods
#pragma mark Getters

- (NSDictionary *)results {
    return mResultsDict;
}

- (NSInteger)numberOfPages {
    return MKHTMLExtractorFlags.numberOfPages;
}

- (BOOL)optimizeOutputForiPhone {
    return MKHTMLExtractorFlags.usesCustomStyle;
}

#pragma mark Setters

- (void)setOptimizeOutputForiPhone:(BOOL)optomize {
    MKHTMLExtractorFlags.usesCustomStyle = optomize;
    if (optomize) {
        if ([self.delegate respondsToSelector:@selector(extratorHTMLHeaderPath:)]) {
            mHTMLHeaderString = [[NSString alloc] initWithContentsOfFile:[self.delegate extratorHTMLHeaderPath:self] encoding:NSUTF8StringEncoding error:nil];
        }
        else {
            mHTMLHeaderString = [[NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"initial-scale = 1.0, user-scalable = no, width = 320\"/><style type=\"text/css\">.title { font-size: 16pt; font-weight: bold;} .artical { font-size: 12pt; } </style><head><body>"] retain];
        }
    }
}

- (void)setArticleTitle:(NSString *)title {
    MKHTMLExtractorFlags.articalTitleSet = YES;
    
    mHTMLHeaderString = [[mHTMLHeaderString stringByAppendingFormat:@"<div class=\"title\">%@</div>", title] retain];
}

#pragma mark - Request Methods

- (void)request {
	request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
	aConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
    requestData = [[NSMutableData data] retain];
}

- (void)requestType:(MKHTMLExtractorRequestType)type withHandler:(MKHTMLExtractorRequestHandler)handler {
    self.requestHandler = handler;
    self.requestType = type;
    
    switch (type) {
        case MKHTMLExtractorMainBodyHTMLRequest: {
            [self request]; 
        } break;
        case MKHTMLExtractorFirstParagraph: {
            requestData = [(NSMutableData *)[mHTMLString dataUsingEncoding:[NSString defaultCStringEncoding]] retain];
            [self extractFromData:requestData];
            [mHTMLString release];
        } break;
        default:
            break;
    }
}

- (void)requestPage:(NSString *)url {
    URL = [url copy];
    [self request];
}

#pragma mark - Connection Delegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    //[aConnection release];
    //[request release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    ////////////////////////////////////////////////////////////
    // UNCOMMENT THESE LINES TO POST THE FEED DATA IN THE LOG //
    ////////////////////////////////////////////////////////////
    
	//NSString *data = [[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding];
	//NSLog(@"%@", data);
    
    [self extractFromData:requestData];
}

#pragma mark - Extractor Methods

- (void)extractFromData:(NSData *)data {
    if (MKHTMLExtractorFlags.currentPage == 1) {
        if (!mResultsDict) {
            mResultsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        }
    }
    
    MKHTMLParser *parsedData = nil;
    
    @try {
       parsedData = [[MKHTMLParser alloc] initWithData:data];
    }
    @catch (NSException *exception) {
        //NSLog(@"Catch : %@", [exception reason]);
    }
    @finally {}
    
    MKHTMLExtractorFlags.requestComplete = YES;
    
    switch (self.requestType) {
        case MKHTMLExtractorMainBodyHTMLRequest: {
            NSString *page = [NSString stringWithFormat:@"%i", MKHTMLExtractorFlags.currentPage];
            
            for (MKHTMLAttribueValue *attribute in mAttributesArray) {
                NSString *text = [self mainBodyHTMLFromParsedData:parsedData];
                if ([text length] > 1) {
                    if (MKHTMLExtractorFlags.usesCustomStyle) {
                        text = [mHTMLHeaderString stringByAppendingString:text];
                        text = [text stringByAppendingString:@"</body></html>"];
                    }
                    [mResultsDict setObject:text forKey:page];
                    
                    if (MKHTMLExtractorFlags.currentPage == 1) {
                        if (self.requestHandler) {
                            self.requestHandler(mResultsDict, nil);
                        }
                    }
                    
                    if ([self.delegate respondsToSelector:@selector(extactor:didFindPage:content:)]) {
                        [self.delegate extactor:self didFindPage:[page integerValue] content:text];
                    }
                    
                    MKHTMLExtractorFlags.numberOfPages = (MKHTMLExtractorFlags.numberOfPages + 1);
                    MKHTMLExtractorFlags.attemptCount = 0;
                    
                    [self findNextPageFromParsedData:parsedData];
                    break;
                }
                else {
                    MKHTMLExtractorFlags.attemptCount = (MKHTMLExtractorFlags.attemptCount + 1);
                }
            }
        } break;
        case MKHTMLExtractorFirstParagraph: {
            MKHTMLNode *firstp = [[parsedData root] childNodeNamed:@"p"];
            NSString *firstpText = [firstp allText];
            NSString *text = [firstpText stringByRemovingNewLinesAndWhitespace];
            
            if (text) {
                [mResultsDict setObject:text forKey:@"text"];
                if (self.requestHandler) {
                    self.requestHandler(mResultsDict, nil);
                }
            }
            else {
                if (self.requestHandler) {
                    NSError *error = [NSError errorWithDomain:@"No Text Found" code:1001 userInfo:nil];
                    self.requestHandler(nil, error);
                }
            }
        } break;
        default:
            break;
    }
    
    [parsedData release];
}

#pragma mark Main Body Text

- (NSString *)mainBodyHTMLFromParsedData:(MKHTMLParser *)parsedData; {
    NSMutableString *article = nil;
    
    if (MKHTMLExtractorFlags.requestComplete) {
        MKHTMLAttribueValue *attribute = nil;
        BOOL attemptsLeft = YES;
        @try {
            attribute = (MKHTMLAttribueValue *)[mAttributesArray objectAtIndex:MKHTMLExtractorFlags.attemptCount];
        }
        @catch (NSException *exception) {
            attemptsLeft = NO;
        }
        @finally {
        }
        
        NSArray *elements = [[parsedData body] childrenNamed:@"article"];
        
        if (attemptsLeft) {
            if ([elements count] == 0) {
                elements = [[parsedData body] childrenWithAttribute:attribute.attribute  value:attribute.value allowPartial:YES];
            }
            article = [[[NSMutableString alloc] initWithCapacity:0] autorelease];
            
            for (MKHTMLNode *node in elements) {
                NSArray *children = [node children];
                for (MKHTMLNode *child in children) {
                    switch ([child nodeType]) {
                        case MKHTMLNodeH1: {
                            if (MKHTMLExtractorFlags.articalTitleSet == NO) {
                                if (self.optimizeOutputForiPhone) {
                                    [article appendString:[self styledTitleFromNode:child]];
                                }
                                else {
                                    [article appendString:[child htmlString]]; 
                                }
                            }
                        } break;
                        case MKHTMLNodeP: {
                            if (self.optimizeOutputForiPhone) {
                                [article appendString:[self styledParagraphFromNode:child]];
                            }
                            else {
                                [article appendString:[child htmlString]];
                            }
                        } break;
                            
                        case MKHTMLNodeBlockquote: {
                            [article appendString:[child htmlString]];
                        } break;
                        default: break;
                    }
                }
            }
        }
    }
    return article;
}

#pragma mark Main Body Helpers

- (NSString *)styledTitleFromNode:(MKHTMLNode *)node {
    NSMutableString *rtn = [NSMutableString string];
    
    [rtn appendString:@"<div class=\"title\">"];
    [rtn appendString:[node allText]];
    [rtn appendString:@"</div>"];

    return rtn;
}

- (NSString *)styledParagraphFromNode:(MKHTMLNode *)node {
    NSMutableString *rtn = [NSMutableString string];
    
    if ([node childNodeNamed:@"iframe"]) {
        [rtn appendString:[self styledEmbedFromNode:[node childNodeNamed:@"iframe"]]];
    }
    
    else if ([node childNodeNamed:@"img"]) {
        [rtn appendString:[self styledEmbedFromNode:[node childNodeNamed:@"img"]]];
    }
    else {
        [rtn appendString:@"<div class=\"article\">"];
        [rtn appendString:[node htmlString]];
        [rtn appendString:@"</div>"];
    }

    return rtn;
}

- (NSString *)styledEmbedFromNode:(MKHTMLNode *)node {
    NSMutableString *rtn = [NSMutableString string];
    
    NSString *src = [node valueOfAttribute:@"src"];
    
    NSString *baseURL = [[NSURL URLWithString:src] host];
    
    if (!baseURL) {
        NSString *host = [[NSURL URLWithString:URL] host];
        NSString *scheme = [[NSURL URLWithString:URL] scheme];
        src = [NSString stringWithFormat:@"%@://%@%@", scheme, host, src];
        src = [src stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    switch ([node nodeType]) {
        case MKHTMLNodeIFrame:  [rtn appendFormat:@"<iframe allowfullscreen=\"\" frameborder=\"0\" heigh=\"\" width=\"300\" src=\"%@\"></iframe>", src]; break;
        case MKHTMLNodeImg:     [rtn appendFormat:@"<img src=\"%@\" width=\"300\" />", src]; break;
        default:                [rtn appendString:[node htmlString]]; break;
    }
    
    return rtn;
}

- (void)findNextPageFromParsedData:(MKHTMLParser *)parsedData {
    NSString *nextPageNumber = [NSString stringWithFormat:@"%i", (MKHTMLExtractorFlags.currentPage + 1)];
    NSArray *links = [[parsedData body] childrenNamed:@"a"];
    
    for (MKHTMLNode *node in links) {
        if ([[node allText] isEqualToString:nextPageNumber]) {
            MKHTMLExtractorFlags.currentPage = [nextPageNumber intValue];
            
            NSString *url = [node valueOfAttribute:@"href"];
            
            if (![url hasPrefix:@"#"]) {
                NSString *baseURL = [[NSURL URLWithString:url] host];
                if (!baseURL) {
                    NSString *host = [[NSURL URLWithString:URL] host];
                    NSString *scheme = [[NSURL URLWithString:URL] scheme];
                    url = [NSString stringWithFormat:@"%@://%@%@", scheme, host, url];
                }
                [self requestPage:url];
            }
        }
    }
}

@end

@implementation MKHTMLAttribueValue

@synthesize attribute, value;

- (id)initWithAttribute:(NSString *)attrib value:(NSString *)val {
    self = [super init];
    if (self) {
        self.attribute = attrib;
        self.value = val;
    }
    return self;
}


- (void)dealloc {
    self.attribute = nil;
    self.value = nil;
    
    [super dealloc];
}

@end
