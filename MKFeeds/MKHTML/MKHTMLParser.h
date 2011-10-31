//
//  MKHTMLParser.h
//  MKKit
//
//  Created by Matthew King on 10/24/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//
//  MKHTMLParser is based on Ben Reeves HTMLParser object.
//  https://github.com/zootreeves/Objective-C-HMTL-Parser
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>

@class MKHTMLNode;

//@protocol MKHTMLParserDelegate;

/**---------------------------------------------------------------------------------
 *Overview*
 
 MKHTMLParser works in conjuction with MKHTMLNode. The methods of this class are the 
 prefered means of getting the first level of the node tree. 
----------------------------------------------------------------------------------*/

@interface MKHTMLParser : NSObject {
@private
    MKHTMLNode *mCurrentNode;
    htmlDocPtr htmlDoc;
}

///---------------------------------------------------------
/// @name Creating Instances
///---------------------------------------------------------

/**
 Creates an instance of MKHTMLParser with the given data.
 
 @param data This prarameter should contain the data that 
 was recived from an NSURLConnection.
 
 @return MKHTMLParser instance
*/
- (id)initWithData:(NSData *)data;

///---------------------------------------------------------
/// @name Getting Base Nodes
///---------------------------------------------------------

/**
 Returns the MKHTMLNode that contains the entire HTML document.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)root;

/**
 Returns the an MKHTMLNode with the <body> tag at the top of the 
 tree.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)body;

//- (void)parseNode:(MKHTMLNode *)node;

//@property (assign) id<MKHTMLParserDelegate> delegate;

@end
