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

@protocol MKRSSFeedDelegate;

/**---------------------------------------------------------------------------------
 *Overview*
 
 MKRSSFeed requests RSS feeds from the internet and pases them into an array for 
 use by your app.
 
 *Using Returned Data*
 
 Data can returned through ethier the MKRSSFeedDelegate or the MKRequestComplete block.
 Both methods pass an NSArray that holds the information from the RSS feed. The array
 contains NSDictonary objects, use the following keys to get the feed data from one of 
 the dictonaries.
 
 * `MKFeedRSSFeedTitle` : The title of the feed item -- NSString.
 * `MKFeedRSSFeedDescription` : The description\content of the feed item -- NSString.
 * `MKFeedRSSFeedLink` : The URL the feed item is linked to -- NSString.
 * `MKFeedRSSFeedPublicationDate` : The publication data of the feed item -- NSString.
 * `MKFeedRSSFeedGUID` : The GUID of the feed item -- NSString.
 
 *Requied Framworks*
 
 * Foundation
----------------------------------------------------------------------------------*/

@interface MKRSSFeed : NSObject <NSXMLParserDelegate> {
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
 
 @exception Missing-URL Exception is rasied if the aURL paramenter is nil
*/
- (id)initWithURL:(NSString *)aURL delegate:(id<MKRSSFeedDelegate>)theDelegate;

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
/// @name Feed URL
///-----------------------------------------------

/** The URL address of the feed. */
@property (nonatomic, copy, readonly) NSString *url;

///-----------------------------------------------
/// @name Delegate
///-----------------------------------------------

/** The MKRSSFeedDelegate */
@property (assign) id<MKRSSFeedDelegate> delegate;

///-----------------------------------------------
/// @name Blocks
///-----------------------------------------------

/** The request complete block. This block is ran when a request is finished. */
@property (nonatomic, copy) MKRequestComplete requestCompleteBlock;
 
@end

NSString *MKFeedRSSFeedItem MK_VISIBLE_ATTRIBUTE;

NSString *MKFeedRSSFeedTitle MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedDescription MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedLink MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedPublicationData MK_VISIBLE_ATTRIBUTE;
NSString *MKFeedRSSFeedGUID MK_VISIBLE_ATTRIBUTE;

/**-----------------------------------------------------------------------------------
 *Overview*
 
 The MKRSSFeedDelegate provides methods to observe the actions taken by the MKRSSFeed class.
------------------------------------------------------------------------------------*/
@protocol MKRSSFeedDelegate <NSObject>

///-----------------------------------------------
/// @name Required Methods
///-----------------------------------------------

/**
 Called when a request is finished.
 
 @param feed the MKRSSFeed instance that started the request.
 
 @param data the parsed RSS feed data.
*/
- (void)RSSFeed:(MKRSSFeed *)feed didReturnData:(NSArray *)data;


@end 