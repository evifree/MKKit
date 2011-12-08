//
//  NSString+MKFeedParser_NSString.h
//  MKKit
//
//  Created by Matthew King on 11/13/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKFeedsAvailability.h"

/**--------------------------------------------------------------
 *Overview*
 
 This is a special catagory of NSString to help the parser parse the
 feed data.
---------------------------------------------------------------*/
@interface NSString (MKFeedParser)

///--------------------------------------
/// @name Parsing 
///--------------------------------------

/**
 Removes extra returns and whitespace that may have been added
 to during parsing.
 
 @return NSString
*/
- (NSString *)stringByRemovingNewLinesAndWhitespace;

/**
 Converts HTML entity encodings into a readable text.
 
 @return NSString
*/
- (NSString *)stringByDecodingHTMLEntities;

/**
 Removes any HTML tags from a string and returns the 
 resulting text.
 
 @return NSString
*/
-(NSString *) stringByStrippingHTML;

///---------------------------------------
/// @name Finding Code
///---------------------------------------

/**
 Determines if the string has any HTML text it.
 
 @return BOOL Yes if HTML is found, NO if not.
*/
- (BOOL)stringContainsHTMLTags;

@end
