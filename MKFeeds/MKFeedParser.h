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
 Both methods pass an NSArray that holds the information from the feed. The array
 contains NSDictonary objects, use the following keys to get the feed data from one of 
 the dictonaries.
 
 *RSS Feed Keys*
 
 * `MKFeedRSSFeedTitle` : The title of the feed item -- NSString.
 * `MKFeedRSSFeedDescription` : The description\content of the feed item -- NSString.
 * `MKFeedRSSFeedDescriptionHTML` : A raw HTML representation of the feed content, if availible -- NSString.
 * `MKFeedRSSFeedLink` : The URL the feed item is linked to -- NSString.
 * `MKFeedRSSFeedPublicationDate` : The publication date of the feed item -- NSString.
 * `MKFeedRSSFeedGUID` : The GUID of the feed item -- NSString.
 
 *Atom Feed Keys*
 
 * `MKFeedAtomTitle` : The title of the feed item -- NSString.
 * `MKFeedAtomLink` : The URL the feed item is linked to -- NSString.
 * `MKFeedAtomID` : The uniquie id of the feed item -- NSString.
 * `MKFeedAtomUpdated` : The data the feed item was last updated -- NSString.
 * `MKFeedAtomSummary` : The summary of feed item -- NSString.
 * `MKFeedAtomSummaryHTML` : A raw HTML representation of the feed content, if availible -- NSString.
 * `MKFeedAtomAuthorName` : The name of the feed items author -- NSString.
 
 *Requied Framworks*
 
 * Foundation
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
    
    MKFeedContentType mContentType;
    MKFeedSourceType mSourceType;
    
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

NSString *MKFeedParserNILURLException MK_VISIBLE_ATTRIBUTE;

NSString *MKFeedRSSFeedStart MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedItem MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomFeedStart MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomFeedEntry MK_VISIBLE_ATTRIBUTE;

NSString *MKFeedRSSFeedTitle MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedDescription MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedDescriptionHTML MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedPublicationDate MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedGUID MK_VISIBLE_ATTRIBUTE;

NSString *MKFeedAtomTitle MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomID MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedAtomUpdated MK_VISIBLE_ATTRIBUTE;
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


