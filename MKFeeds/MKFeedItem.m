//
//  MKFeedItem.m
//  MKKit
//
//  Created by Matthew King on 11/26/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKFeedItem.h"
#import "NSString+MKFeedParser.h"

@implementation MKFeedItem

@dynamic contentType, itemTitle, itemContent, itemLinkURL, itemOriginalLinkURL, itemAuthor, itemGUID, itemPubDate;

static NSString *MKFeedItemTitle = @"MKFeedItemTitle";
static NSString *MKFeedItemContent = @"MKFeedItemContent";
static NSString *MKFeedItemLinkURL = @"MKFeedItemLinkURL";
static NSString *MKFeedItemOriginalLinkURL = @"MKFeedItemLinkURL";
static NSString *MKFeedItemAuthor = @"MKFeedItemAuthor";
static NSString *MKFeedItemGUID = @"MKFeedItemGUID";
static NSString *MKFeedItemPubDate = @"MKFeedItemPubDate";

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        
        mItemTitle = [[aDecoder decodeObjectForKey:MKFeedItemTitle] copy];
        mItemContent = [[aDecoder decodeObjectForKey:MKFeedItemContent] copy];
        mItemLinkURL = [[aDecoder decodeObjectForKey:MKFeedItemLinkURL] copy];
        mItemOriginalLinkURL = [[aDecoder decodeObjectForKey:MKFeedItemOriginalLinkURL] copy];
        mItemAuthor = [[aDecoder decodeObjectForKey:MKFeedItemAuthor] copy];
        mItemGUID = [[aDecoder decodeObjectForKey:MKFeedItemGUID] copy];
        mItemPubDate = [[aDecoder decodeObjectForKey:MKFeedItemPubDate] copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:mItemTitle forKey:MKFeedItemTitle];
    [aCoder encodeObject:mItemContent forKey:MKFeedItemContent];
    [aCoder encodeObject:mItemLinkURL forKey:MKFeedItemLinkURL];
    [aCoder encodeObject:mItemOriginalLinkURL forKey:MKFeedItemOriginalLinkURL];
    [aCoder encodeObject:mItemAuthor forKey:MKFeedItemAuthor];
    [aCoder encodeObject:mItemGUID forKey:MKFeedItemGUID];
    [aCoder encodeObject:mItemPubDate forKey:MKFeedItemPubDate];
}

#pragma mark - Creating Instances

- (id)initWithType:(MKFeedSourceType)type {
    self = [super init];
    if (self) {
        mContentType = type;
    
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mItemTitle release];
    [mItemContent release];
    [mItemLinkURL release];
    [mItemOriginalLinkURL release];
    [mItemAuthor release];
    [mItemGUID release];
    [mItemPubDate release];
    
    [super dealloc];
}

#pragma mark - Setting Content

- (void)addValue:(id)value forElement:(NSString *)element {
    if ([element isEqualToString:MKFeedRSSFeedTitle] || [element isEqualToString:MKFeedAtomTitle]) {
        mItemTitle = [(NSString *)value copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedDescription] || [element isEqualToString:MKFeedAtomSummary] || [element isEqualToString:MKFeedAtomContent]) {
        mItemContent = [(NSString *)value stringByStrippingHTML];
        mItemContent = [mItemContent stringByDecodingHTMLEntities]; 
        mItemContent = [mItemContent stringByRemovingNewLinesAndWhitespace];
        
        if ([mItemContent length] > 499) {
            mItemContent = [mItemContent substringToIndex:500];
            mItemContent = [mItemContent stringByAppendingString:@"..."];
        }
        
        [mItemContent copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedLink] || [element isEqualToString:MKFeedAtomLink]) {
        mItemLinkURL = [(NSString *)value copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedOriginalLink]) {
        mItemOriginalLinkURL = [(NSString *)value copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedCreator] || [element isEqualToString:MKFeedAtomAuthorName]) {
        mItemAuthor = [(NSString *)value copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedGUID] || [element isEqualToString:MKFeedAtomID]) {
        mItemGUID = [(NSString *)value copy];
    }
    else if ([element isEqualToString:MKFeedRSSFeedPublicationDate] || [element isEqualToString:MKFeedAtomUpdated]) {
        mItemPubDate = [(NSString *)value copy];
    }
}

#pragma mark - Accessor Methods
#pragma mark Getters

- (MKFeedSourceType)contentType {
    return mContentType;
}

- (NSString *)itemTitle {
    return mItemTitle;
}

- (NSString *)itemContent {
    return mItemContent;
}

- (NSString *)itemLinkURL {
    return mItemLinkURL;
}

- (NSString *)itemOriginalLinkURL {
    return mItemOriginalLinkURL;
}

- (NSString *)itemAuthor {
    return mItemAuthor;
}

- (NSString *)itemGUID {
    return mItemGUID;
}

- (NSDate *)itemPubDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = [formatter dateFromString:mItemPubDate];
    
    return date;
}

@end
