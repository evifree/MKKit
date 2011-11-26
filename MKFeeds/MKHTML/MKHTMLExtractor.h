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
    MKHTMLExtractorMainBodyHTMLRequest,
    MKHTMLExtractorFirstParagraph,
} MKHTMLExtractorRequestType;

@class MKHTMLParser;

@protocol MKHTMLExtractorDelegate;

/**-----------------------------------------------------------------------------------
 *Overview*
 
 MKHTMLExtractor looks at given web pages and pulls out specific data. For example the 
 article from a web page containing a news story. MKHTMLExtractor has preset types of
 extraction types that can be used.
 
 * `MKHTMLExtactorMainBodyTextRequest` : Finds the main text of a web page and extacts it 
 as a NSString that is in an HTML format.
 
 *Request Handlers*
 
 MKHTMLExtractor supports the use of code blocks to handle responces from an extraction
 request. Call the requestType:withHandler: method to make use of the handler block.
 The handle block will pass an NSDictionay object with the extraction results. The results
 can be accesed with the following keys:
 
 * Each page that is found has the key for page number. For example page one's key is `1`.
------------------------------------------------------------------------------------*/

@interface MKHTMLExtractor : NSObject {
@private
    NSMutableURLRequest *request;
    NSURLConnection *aConnection;
    NSMutableData *requestData;
    NSMutableString *dataString;
    NSMutableDictionary *mResultsDict;
    NSArray *mAttributesArray;
    NSString *mHTMLHeaderString;
    NSString *mHTMLString;
    NSString *URL;
    struct {
        BOOL requestComplete;
        BOOL requestFromURL;
        BOOL usesCustomStyle;
        BOOL articalTitleSet;
        int currentPage;
        int numberOfPages;
        int attemptCount;
    } MKHTMLExtractorFlags;
}

///--------------------------------------------
/// @name Creating Instance
///--------------------------------------------

/**
 Creates an instance of MKHTMLExtractor
 
 @param aURL the address of the website that data
 will be extracted from. Cannot be nil.
 
 @exception MKHTMLExtractorNILURLException : exeption is raised if the aURL 
 parameter is nil. Execption is catchable.
 
 @return MKHTMLExtractor instance
*/
- (id)initWithURL:(NSString *)aURL;

/**
 Creates an instance of MKHTMLExtractor
 
 @param htmlString an NSString representation of an HTML file
 
 @exception MKHTMLExtractorNILHTMLException : exception is raised if the the 
 htmlString is nil
 
 @return MKHTMLExtractor instance
*/
- (id)initWithHTMLString:(NSString *)htmlString;

///--------------------------------------------
/// @name Customize Output
///--------------------------------------------

/**
 Set this property to `YES` to optimize the HTML output for display on 
 the iPhone. HTML code will be added inserted into the output to assist with
 display.
 
 When set to `YES` the delegate method extactorHTMLHeaderPath: method is called.
 If this method is not used or returns `nil`, generic HTML code will be added.
 
 @see MKHTMLExtractorDelegate for more information.
*/
@property (nonatomic, assign) BOOL optimizeOutputForiPhone;

/**
 Set a NSString to this property for the title of an article. If the property
 is set the extractor will not look for the title of an article, but use the 
 this property instead.
 
 @warning *Note* Setting this property does nothing if the requestType is not
 `MKHTMLExtractorMainBodyHTMLRequest`.
*/
@property (nonatomic, copy) NSString *articleTitle;

///--------------------------------------------
/// @name Preforming Requests
///--------------------------------------------

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
/// @name Using Data
///--------------------------------------------

/**
 An NSDictionary containing the results of an extraction. Keys for
 the dictionary are the corisponding page number. use the numberOfPages
 property to find how many pages were found.
*/
@property (nonatomic, readonly) NSDictionary *results;

/**
 The number of pages found during an extraction.
*/
@property (nonatomic, readonly) NSInteger numberOfPages;

///--------------------------------------------
/// @name Delegate
///--------------------------------------------

/**
 The MKHTMLExtractorDelegate
*/
@property (assign) id<MKHTMLExtractorDelegate> delegate;

///--------------------------------------------
/// @name Handeler Blocks
///--------------------------------------------

/** The request code block handler, called when a request is completed
 using the requestType:withHandler: method.
*/
@property (nonatomic, copy) MKHTMLExtractorRequestHandler requestHandler;

@end

NSString *MKHTMLExtractorNILURLExecption MK_VISIBLE_ATTRIBUTE;
NSString *MKHTMLExtractorNILHTMLStringException MK_VISIBLE_ATTRIBUTE;

@interface MKHTMLAttribueValue : NSObject 

- (id)initWithAttribute:(NSString *)attrib value:(NSString *)val;

@property (nonatomic, copy) NSString *attribute;
@property (nonatomic, copy) NSString *value;

@end
