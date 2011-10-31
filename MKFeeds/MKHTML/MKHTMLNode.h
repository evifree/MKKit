//
//  MKHTMLNode.h
//  MKKit
//
//  Created by Matthew King on 10/24/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//
//  MKHTMLNode is based on Ben Reeves HTMLNode object.
//  https://github.com/zootreeves/Objective-C-HMTL-Parser
//

#import <Foundation/Foundation.h>
#import <libxml/HTMLparser.h>

#import <MKKit/MKFeeds/MKFeedsAvailability.h>

typedef enum {
    MKHTMLNodeDiv,
    MKHTMLNodeP,
    MKHTMLNodeScript,
    MKHTMLNodeA,
    MKHTMLClosingNode,
    MKHTMLNodeUnknown,
} MKHTMLNodeType;

/**----------------------------------------------------------------------
 *Overview*
 
 MKHTMLNode provides access to the nodes of an web site. There are several 
 methods to navigate through the nodes and obtain information about the node.
 
 *Creating Instances*
 
 MKHTMLParser works with MKHTMLNode to create instances of MKHTMLNode. Using
 the MKHTMLParser is the prefered method for creating the first instance. After
 that use the Finding Nodes method of MKHTMLNode.
-----------------------------------------------------------------------*/

@interface MKHTMLNode : NSObject {
@private
    xmlNode *mNode;
}

///-----------------------------------------
/// @name Creating Instances
///-----------------------------------------

/**
 Creates an instance of MKHTMLNode. This method should not need to be called
 directly.
 
 @param xmlNode The node for the instance
 
 @return MKHtMLNode instance
*/
- (id)initWithNode:(xmlNode *)xmlNode;

///-----------------------------------------
/// @name Getting Text
///-----------------------------------------

/**
 Returns all the text in the node to include the text of all
 the children.
 
 @return NSString instance
*/
- (NSString *)allText;

/**
 Returns all the text from the first node with the specified name.
 
 @param name The name of the node. i.e. node <p> name would be p.
 
 @return NSString instance
*/
- (NSString *)allTextForNodesNamed:(NSString *)name;

/**
 Returns the html code of the node in a string format.
 
 @return NSString instance
*/
- (NSString *)htmlString;

///------------------------------------------
/// @name Finding Nodes
///------------------------------------------

/**
 Finds the first node has a given attribute matching the specified value.
 
 For exampe to find the node `<div class="article">`, call 
 `[someNode nodeWithAttribute:@"class" value:@"article" allowPartial:YES]`.
 
 @param attruibute The attribute to look for.
 
 @param value The value the attribute should have.
 
 @param partial `YES` if a partial match to the value is allow. `NO` if an exact match is needed.
 
 @return MKHTMLNode instance.
*/
- (MKHTMLNode *)nodeWithAttribute:(NSString *)attribute value:(NSString *)value allowPartial:(BOOL)partial;

/**
 Finds all nodes that have a given attribute matching the specified value.
 
 For exampe to find the node `<div class="article">`, call 
 `[someNode childrenWithAttribute:@"class" value:@"article" allowPartial:YES]`.
 
 @param attruibute The attribute to look for.
 
 @param value The value the attribute should have.
 
 @param partial `YES` if a partial match to the value is allow. `NO` if an exact match is needed.
 
 @return NSArray instance populated with MKHTMLNode objects.
*/
- (NSArray *)childrenWithAttribute:(NSString *)attribute value:(NSString *)value allowPartial:(BOOL)partial;

/**
 Finds the first node of the given name.
 
 @param name The name of the node to find.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)childNodeNamed:(NSString *)name;

/**
 Finds all the children nodes of the given name.
 
 @param name The name of the node to find.
 
 @return NSArray instance populated with MKHTMLNode objects.
*/
- (NSArray *)childrenNamed:(NSString *)name;

/**
 Finds all the children of the node.
 
 @return NSArray instance populated with MKHTMLNode objects.
*/
- (NSArray *)children;

/**
 Moves to the next child of the tree.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)nextChildNode;

/**
 Moves to the previous node of the tree.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)previousChildNode;

/**
 Moves to the parent Node of the tree.
 
 @return MKHTMLNode instance
*/
- (MKHTMLNode *)parentNode;

///-------------------------------------------
/// @name Node Attributes
///-------------------------------------------

/**
 Returns the name of the current node.
 
 @return NSString instance
*/
- (NSString *)nodeName;

///-------------------------------------------
/// @name Getting Node Types
///-------------------------------------------

/**
 Returns the type of the node. MKHTMLNode supports the following types:
 
 * `MKHTMLNodeDiv` : node with <div> name.
 * `MKHTMLNodeP` : node with <p> name.
 * `MKHTMLNodeScript` : node with <script> name.
 * `MKHTMLNodeA` : node with <a> name.
 * `MKHTMLClosingNode` : node that closes out another node </somenode>.
 * `MKHTMLNodeUnknown` : node that cannot be identified by one of the other types.
 
@return MKHTMLNodeType
*/
- (MKHTMLNodeType)nodeType;

@end