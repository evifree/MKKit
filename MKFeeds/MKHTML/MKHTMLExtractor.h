//
//  MKTextExtractor.h
//  MKKit
//
//  Created by Matthew King on 10/23/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <MKKit/MKFeeds/MKFeedsAvailability.h>

typedef void (^MKHTMLExtractorRequestHandler)(NSDictionary *results, NSError *error);

typedef enum {
    MKHTMLExtractorRequestNone,
    MKHTMLExtractorMainBodyTextRequest,
} MKHTMLExtractorRequestType;

@class MKHTMLParser;

/**-----------------------------------------------------------------------------------
 *Overview*
 
 MKHTMLExtractor looks at given web pages and pulls out specific data. For example the 
 artical from a web page containing a news story. MKHTMLExtractor has preset types of
 extraction types that can be used.
 
 * MKHTMLExtactorMainBodyTextRequest : Finds the main text of a web page and extacts it 
 as a NSString
 
 *Request Handlers*
 
 MKHTMLExtractor supports the use of code blocks to handle responces from an extraction
 request. Call the requestType:withHandler: method to make use of the handler block.
 The handle block will pass an NSDictionay object with the extraction results. The results
 can be accesed with the following keys:
 
 * MKHTMLExtractorMainBodyText : key that holds the main body text of the web site.
------------------------------------------------------------------------------------*/

@interface MKHTMLExtractor : NSObject {
@private
    MKHTMLParser *htmlParser;
    NSMutableURLRequest *request;
    NSURLConnection *aConnection;
    NSMutableData *requestData;
    NSMutableString *dataString;
    NSString *URL;
    struct {
        BOOL requestComplete;
    } MKHTMLExtractorFlags;
}

///--------------------------------------------
/// @name Creating Instance
///--------------------------------------------

/**
 Creates an instance of MKHTMLExtractor
 
 @param aURL the address of the website that data
 will be extracted from. Cannot be nil.
 
 @exception No URL : exeption is raised if the aURL 
 parameter is nil.
 
 @return MKHTMLExtractor instance
*/
- (id)initWithURL:(NSString *)aURL;

///--------------------------------------------
/// @name Preforming Requests
///--------------------------------------------

/**
 Makes a request to the supplied URL and stores the 
 data returned from the web site.
*/
- (void)request;

/**
 Makes a request from the supplied URL, preforms an extraction, and
 passes the results through the handler block.
 
 @param type The type of extraction to preform. Optional types are:
 
 * MKHTMLExtractorMainBodyText : Extracts the main text of the web site.
 This most suttable for getting a news article out of a page.
 
 @param handler The code block to preform when the request is complete.
 The block will pass to parameters (NSDictionary *results, NSError *error).
 The results can accessed from the dictionary by using the following keys:
 
 * MKHTMLExtractorMainBodyText : key to the main text of the web site -- NSString.
*/
- (void)requestType:(MKHTMLExtractorRequestType)type withHandler:(MKHTMLExtractorRequestHandler)handler;

/** The request that is currently being used. */
@property (nonatomic, assign) MKHTMLExtractorRequestType requestType;

///--------------------------------------------
/// @name Extraction Methods
///--------------------------------------------

/**
 Returns the main text of a web page. This is most ideal for getting
 the article from a news story. 
 
 @warning *Note* This method will return `nil` if no request has been
 completed.
*/
- (NSString *)mainBodyText;

///--------------------------------------------
/// @name Handeler Blocks
///--------------------------------------------

/** The request code block handler, called when a request is completed
 using the requestType:withHandler: method.
*/
@property (nonatomic, copy) MKHTMLExtractorRequestHandler requestHandler;

@end

NSString *MKHTMLExtractorMainBodyText MK_VISIBLE_ATTRIBUTE;
