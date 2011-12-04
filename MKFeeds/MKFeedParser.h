//
//  MKRSSFeed.h
//  MKKit
//
//  Created by Matthew King on 8/13/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKFeedsAvailability.h"

typedef void (^MKRequestComplete)(NSArray *feedInfo, NSError *error);

typedef enum {
    MKFeedContentPlainText,
    MKFeedContentTypeHTMLEntities,
    MKFeedContentHTML,
} MKFeedContentType;

typedef enum {
    MKFeedSourceRSS,
    MKFeedSourceAtom,
    MKFeedSourceTypeUnknown,
} MKFeedSourceType;

@class MKFeedItem;
@protocol MKFeedParserDelegate;

/**---------------------------------------------------------------------------------
 *Overview*
 
 MKFeedParser requests RSS/ATOM feeds from the internet and pases them into an array for 
 use by your app. MKFeedParser will automaically detect what type of feed it is parsing.
 You can acess the type of feed using the sourceType property. This property will return
 one of two values:
 
 * `MKFeedSourceRSS` : Returned if the feed is in RSS format.
 * `MKFeedSourceAtom` : Returned if the feed is in an Atom format.
 
 It is important to know what type of feed is being parsed in order to retrive the 
 data from it.
 
 *Using Returned Data*
 
 Data can returned through ethier the MKFeedParserDelegate or the MKRequestComplete block.
 Both methods pass an NSArray that holds the information from the feed. The array is an array
 of MKFeedItem instaces. 
 
 *Requied Framworks*
 
 * Foundation
 
 *Requred Classes*
 
 * MKFeedItem
 
 *Required Protocols*
 
 * MKFeedParserDelegate
----------------------------------------------------------------------------------*/

@interface MKFeedParser : NSObject <NSXMLParserDelegate> {
	NSString *mUrl;
	id delegate;
    MKRequestComplete mRequestCompleteBlock;
	
@private
	NSMutableURLRequest *request; 
	NSMutableData *requestData;
    NSURLConnection *theConnection;
	NSXMLParser *theParser;
	NSMutableDictionary *feed;
	NSMutableArray *items;
	NSMutableString *currentString;
    NSString *currentElement;
    
    MKFeedContentType mContentType;
    MKFeedSourceType mSourceType;
    
    MKFeedItem *mFeedItem;
    
    struct {
        BOOL usesCompletionBlock;
    } MKRSSFeedTags;
}

///---------------------------------------------
/// @name Creating
///---------------------------------------------

/**
 Creates an instance of MKRSSFeed.
 
 @param aURL the URL of the feed you are requesting. Cannot be nil.
 
 @param delegate the MKRSSFeedDelegate. Set to nil if you are not using
 a delegate.
 
 @return MKRSSFeed instance
 
 @exception MKFeedParserNILURLException Exception is thrown if the aURL paramenter is nil.
 Exception is catchable.
*/
- (id)initWithURL:(NSString *)aURL delegate:(id<MKFeedParserDelegate>)theDelegate;

///----------------------------------------------
/// @name Preforming Requests
///----------------------------------------------

/**
 Starts the request for data from the provided URL, and returns the results
 through the MKRSSFeedDelegate.
*/
- (void)request;

/**
 Starts the request for data from the provided URL, and returns the results
 through the MKRequestComplete block.
 
 @param block the code block to run when the request is complete.
*/
- (void)requestWithCompletionBlock:(MKRequestComplete)block;

///-----------------------------------------------
/// @name Feed Information
///-----------------------------------------------

/** The URL address of the feed. */
@property (nonatomic, readonly) NSString *url;

/** The content type of the feed. This property will return one of the following:
 
 * `MKContentTypePlainText` : The content of the feed is in a Text String.
 * `MKContentTypeHTML` : The content of the feed is in a HTML String.
*/
@property (nonatomic, readonly) MKFeedContentType contentType;

/** The source type of the feed. This property will return one of the following:
 
 * `MKSourceTypeRSS` : The feed source is in a RSS format.
 * `MKSourceTypeAtom` : The feed source is in an Atom format.
*/
@property (nonatomic, readonly) MKFeedSourceType sourceType;

///-----------------------------------------------
/// @name Delegate
///-----------------------------------------------

/** The MKRSSFeedDelegate */
@property (assign) id<MKFeedParserDelegate> delegate;

///-----------------------------------------------
/// @name Blocks
///-----------------------------------------------

/** The request complete block. This block is ran when a request is finished. */
@property (nonatomic, copy) MKRequestComplete requestCompleteBlock;

@end

/// Exections
NSString *MKFeedParserNILURLException MK_VISIBLE_ATTRIBUTE;

/// Internal tags
NSString *MKFeedRSSFeedStart MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedItem MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomFeedStart MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomFeedEntry MK_VISIBLE_ATTRIBUTE;

/// RSS Feed Dictonary Keys
NSString *MKFeedRSSFeedTitle MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedDescription MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedDescriptionHTML MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedOriginalLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedPublicationDate MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedGUID MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedCreator MK_VISIBLE_ATTRIBUTE;

/// ATOM Feed Dictornary Keys
NSString *MKFeedAtomTitle MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomID MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomUpdated MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomContent MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomSummary MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomSummaryHTML MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomAuthorName MK_VISIBLE_ATTRIBUTE;

/**-----------------------------------------------------------------------------------
 *Overview*
 
 The MKRSSFeedDelegate provides methods to observe the actions taken by the MKRSSFeed class.
------------------------------------------------------------------------------------*/
@protocol MKFeedParserDelegate <NSObject>

///-----------------------------------------------
/// @name Required Methods
///-----------------------------------------------

/**
 Called when a request is finished.
 
 @param feed the MKRSSFeed instance that started the request.
 
 @param data the parsed RSS feed data.
*/
- (void)feed:(MKFeedParser *)feed didReturnData:(NSArray *)data;

@end


