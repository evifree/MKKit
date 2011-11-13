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

@interface MKHTMLExtractor ()

- (void)findNextPage;
- (void)requestPage:(NSString *)url;

@end

@implementation MKHTMLExtractor

@synthesize requestHandler, requestType, delegate;

@dynamic results, numberOfPages;

- (id)initWithURL:(NSString *)aURL {
	if (self = [super init]) {
        if (aURL == nil) {
            MKHTMLExtractorNILURLExecption = @"MKHTMLExtractorNILURLExectption";
            NSException *ecxeption = [NSException exceptionWithName:MKHTMLExtractorNILURLExecption reason:@"URL cannot be a nil value." userInfo:nil];
            @throw ecxeption;
        }
		URL = [aURL copy];
        
        MKHTMLExtractorFlags.currentPage    = 1;
        MKHTMLExtractorFlags.numberOfPages  = 0;
        MKHTMLExtractorFlags.attemptCount   = 0;
        
        MKHTMLAttribueValue *first = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"class" value:@"article"] autorelease];
        MKHTMLAttribueValue *second = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"id" value:@"post"] autorelease];
        MKHTMLAttribueValue *third = [[[MKHTMLAttribueValue alloc] initWithAttribute:@"id" value:@"content"] autorelease];
        
        mAttributesArray = [[NSArray alloc] initWithObjects:first, second, third, nil];
    }
	return self; 
}

#pragma mark - Memory Mangament

- (void)dealloc {
    self.requestHandler = nil;
    self.delegate = nil;
    
    [mResultsDict release];
    [htmlParser release];
    [URL release];
    
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

#pragma mark - request

- (void)request {
	request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
	
	aConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (aConnection) {
		requestData = [[NSMutableData data] retain];
	} 
}

- (void)requestType:(MKHTMLExtractorRequestType)type withHandler:(MKHTMLExtractorRequestHandler)handler {
    self.requestHandler = handler;
    self.requestType = type;
    
    [self request];
}

- (void)requestPage:(NSString *)url {
    request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    aConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (aConnection) {
        requestData = [[NSMutableData data] retain];
    }
}

#pragma mark - Connection Delegate


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [requestData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [aConnection release];
	[request release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    ////////////////////////////////////////////////////////////
    // UNCOMMENT THESE LINES TO POST THE FEED DATA IN THE LOG //
    ////////////////////////////////////////////////////////////
    
	//NSString *data = [[NSString alloc] initWithData:requestData encoding:NSASCIIStringEncoding];
	//NSLog(@"%@", data);
    
    if (MKHTMLExtractorFlags.currentPage == 1) {
        if (!mResultsDict) {
            mResultsDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        }
    }
    
    htmlParser = [[MKHTMLParser alloc] initWithData:requestData];
    
	[aConnection release];
	[request release];
    [requestData release];
    
    MKHTMLExtractorFlags.requestComplete = YES;
    
    if (self.requestType == MKHTMLExtractorMainBodyHTMLRequest) {
        NSString *page = [NSString stringWithFormat:@"%i", MKHTMLExtractorFlags.currentPage];
        
        for (MKHTMLAttribueValue *attribute in mAttributesArray) {
            NSString *text = [self mainBodyHTML];
            if ([text length] > 1) {
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
            
                [self findNextPage];
            }
            else {
                MKHTMLExtractorFlags.attemptCount = (MKHTMLExtractorFlags.attemptCount + 1);
            }
        }
    }
}

#pragma mark - Extractor Methods
#pragma mark Main Body Text

- (NSString *)mainBodyHTML {
    NSMutableString *article = nil;
    
    if (MKHTMLExtractorFlags.requestComplete) {
        MKHTMLAttribueValue *attribute = (MKHTMLAttribueValue *)[mAttributesArray objectAtIndex:MKHTMLExtractorFlags.attemptCount];
        NSArray *elements = [[htmlParser body] childrenWithAttribute:attribute.attribute  value:attribute.value allowPartial:YES];
        
        article = [[[NSMutableString alloc] initWithCapacity:0] autorelease];
    
        for (MKHTMLNode *node in elements) {
            NSArray *children = [node children];
            for (MKHTMLNode *child in children) {
                switch ([child nodeType]) {
                    case MKHTMLNodeH1:          [article appendString:[child htmlString]];   break;
                    case MKHTMLNodeP:           [article appendString:[child htmlString]];   break;
                    case MKHTMLNodeBlockquote:  [article appendString:[child htmlString]];   break;
                    default: break;
                }
            }
        }
    }
    
    if ([article length] == 0) {
        
    }
    
    return article;
}

- (void)findNextPage {
    NSString *nextPageNumber = [NSString stringWithFormat:@"%i", (MKHTMLExtractorFlags.currentPage + 1)];
    NSArray *links = [[htmlParser body] childrenNamed:@"a"];
    
    for (MKHTMLNode *node in links) {
        if ([[node allText] isEqualToString:nextPageNumber]) {
            MKHTMLExtractorFlags.currentPage = [nextPageNumber intValue];
            
            NSString *url = [node valueOfAttribute:@"href"];
            
            if (![url hasPrefix:@"#"]) {
                NSString *baseURL = [[NSURL URLWithString:url] host];
                if (!baseURL) {
                    NSString *host = [[NSURL URLWithString:URL] host];
                    NSString *scheme = [[NSURL URLWithString:URL] scheme];
                    
                    url = [NSString stringWithFormat:@"%@://%@/%@", scheme, host, url];
                }
                [self requestPage:url];
                [htmlParser release];
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
