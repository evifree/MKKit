//
//  MKHTMLExtractorDelegate.h
//  MKKit
//
//  Created by Matthew King on 11/11/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MKHTMLExtractor;

/**-------------------------------------------------------------------------
 The MKHTMLExtractorDelegate send messages from the the MKHTMLExtractor class.
--------------------------------------------------------------------------*/

@protocol MKHTMLExtractorDelegate <NSObject>

@optional

/**
 Called when a page of contents is found by an extractor.
 
 @param extractor the MKHTMLExtractor instance that found a page.
 
 @param page the page number that was found
 
 @param the extacted contents of the page
*/
- (void)extactor:(MKHTMLExtractor *)extactor didFindPage:(NSInteger)page content:(NSString *)htmlString;

@end
