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
- (void)extractor:(MKHTMLExtractor *)extactor didFindPage:(NSInteger)page content:(NSString *)htmlString;

/**
 Called when the optimizedOutputForiPhone property is set to `YES`.
 
 @param extractor the instance of MKHTMLExtractor that called this method
 
 This method should return the path to an HTML file containing information of
 the <head> tag. This can be used to style the output from MKHTMLExtractor. 
 If the optimizedOutputForiPhone property of MKHTMLExtractor is set `YES`, HTML 
 code is added to the output to support styling of the page. 
 
 * Titles will be wraped in `<div class="title"></div>` tags.
 * Paragaraphs will be wraped in `<div class="article"></di>` tags.
 
 @return NSString The path to an HTML file containg <head> tag information.
*/
- (NSString *)extractorHTMLHeaderPath:(MKHTMLExtractor *)extractor;

/**
 Called if an extractor errors
 
 @param extractor the extractor instance that encountered an error.
 
 @param error the error that was encountered.
*/
- (void)extractor:(MKHTMLExtractor *)extractor didError:(NSError *)error;

@end
