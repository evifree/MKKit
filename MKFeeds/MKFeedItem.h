//
//  MKFeedItem.h
//  MKKit
//
//  Created by Matthew King on 11/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKFeedParser.h"

/**-------------------------------------------------------------------------
 *Overview*
 
 MKFeedItem class holds data from an RSS or ATOM feed. Each instance holds the
 the data of one feed item. This is default class for accessing data from a 
 MKFeedParser instace.  It can also be used independently.
 
 *Required Frameworks*
 
 * Foundation
 
 *Required Classes*
 
 * MKFeedParser
--------------------------------------------------------------------------*/

@interface MKFeedItem : NSObject <NSCoding> {
@private 
    MKFeedSourceType mContentType;
    NSString *mItemTitle;
    NSString *mItemContent;
    NSString *mItemLinkURL;
    NSString *mItemOriginalLinkURL;
    NSString *mItemAuthor;
    NSString *mItemPubDate;
    NSString *mItemGUID;
}

///---------------------------------------------
/// @name Creating Instances
///---------------------------------------------

/**
 Creates and instace of MKFeedItem with the given source
 type.
 
 @param MKFeedSourceType the type of feed, options are:
 
 * `MKFeedSourceTypeRSS` : a RSS feed
 * `MKFeedSourceTypeAtom` : an Atom feed
 * `MKFeedSourceTypeUnknown` : an unknown feed type
*/
- (id)initWithType:(MKFeedSourceType)type;

///---------------------------------------------
/// @name Adding Content
///---------------------------------------------

/**
 Adds a value for a feed element.
 
 @param value the value of the element. This will typically
 be a NSString.
 
 @param element the name of the feed element.
*/
- (void)addValue:(id)value forElement:(NSString *)element;

///---------------------------------------------
/// @name Accessing Content
///---------------------------------------------

/**
 The type of feed that is being used. This will return one
 of three possibilities:
 
 * `MKFeedSourceTypeRSS` : a RSS feed
 * `MKFeedSourceTypeAtom` : an Atom feed
 * `MKFeedSourceTypeUnknown` : an unknown feed type
*/
@property (nonatomic, readonly) MKFeedSourceType contentType;

/** The tilte of the feed item. */
@property (nonatomic, readonly) NSString *itemTitle;

/** The content of the feed item. */
@property (nonatomic, readonly) NSString *itemContent;

/** The URL link of the feed item. */
@property (nonatomic, readonly) NSString *itemLinkURL;

/** The original URL link of the feed item. */
@property (nonatomic, readonly) NSString *itemOriginalLinkURL;

/** The author of the feed item. */
@property (nonatomic, readonly) NSString *itemAuthor;

/** The GUID of the feed item. */
@property (nonatomic, readonly) NSString *itemGUID;

/** The published date of the feed item. */
@property (nonatomic, readonly) NSDate *itemPubDate;

@end
