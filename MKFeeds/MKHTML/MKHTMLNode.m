//
//  MKHTMLElement.m
//  MKKit
//
//  Created by Matthew King on 10/24/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKHTMLNode.h"
#import <libxml/HTMLtree.h>

static const char *kDivNode             = "div";
static const char *kPNode               = "p";
static const char *kScriptNode          = "script";
static const char *kANode               = "a";
static const char *kLiNode              = "li";
static const char *kBlockquoteNode      = "blockquote";
static const char *kH1                  = "h1";
static const char *kClosingNode         = "text";
static const char *kImg                 = "img";

@interface MKHTMLNode () 

- (MKHTMLNode *)nodeWithAttribute:(const char*)attribute value:(const char*)name XMLNode:(xmlNode *)node allowPartial:(BOOL)partial;
- (MKHTMLNode *)childNodeNamed:(NSString *)name XMLNode:(xmlNode *)node;

- (void)findChildrenWithAttribute:(const char*)attribute matchingName:(const char*)className inXMLNode:(xmlNode *)node inArray:(NSMutableArray*)array allowPartial:(BOOL)partial;
- (void)childNamed:(NSString *)name XMLNode:(xmlNode *)node array:(NSMutableArray *)array;

@end

@implementation MKHTMLNode

NSString * allNodeContents(xmlNode *node);
NSString * allContentsForNodesNamed(xmlNode *node, const char *name);
NSString * rawContentsOfNode(xmlNode *node);
NSString * getAttributeNamed(xmlNode *node, const char *nameStr);
MKHTMLNodeType nodeType(xmlNode *node);

#pragma mark - Initalizing

- (id)initWithNode:(xmlNode *)xmlNode {
    self = [super init];
    if (self) {
        mNode = xmlNode;
    }
    return self;
}

#pragma mark - Attributes

- (NSString *)nodeName {
    return [NSString stringWithCString:(void *)mNode->name encoding:NSUTF8StringEncoding];
}

- (NSString *)valueOfAttribute:(NSString *)attribute {
    const char * nameStr = [attribute UTF8String];
	return getAttributeNamed(mNode, nameStr);
}

#pragma mark - Getting Text

- (NSString *)allText {
    return allNodeContents(mNode);
}

- (NSString *)allTextForNodesNamed:(NSString *)name {
    return allContentsForNodesNamed(mNode, [name UTF8String]);
}

- (NSString *)htmlString {
    return rawContentsOfNode(mNode);
}

#pragma mark - Finding Nodes

- (MKHTMLNode *)nodeWithAttribute:(NSString *)attribute value:(NSString *)value allowPartial:(BOOL)partial {
	return [self nodeWithAttribute:[attribute UTF8String] value:[value UTF8String] XMLNode:mNode->children allowPartial:partial];
}

- (MKHTMLNode *)nodeWithAttribute:(const char*)attribute value:(const char*)name XMLNode:(xmlNode *)node allowPartial:(BOOL)partial {
    xmlNode *cur_node = NULL;
    const char *classNameStr = name;
        
    if (node == NULL)
        return NULL;
        
    for (cur_node = node; cur_node; cur_node = cur_node->next) {		
        for(xmlAttrPtr attr = cur_node->properties; NULL != attr; attr = attr->next) {			
            if (strcmp((char*)attr->name, attribute) == 0) {				
                for(xmlNode * child = attr->children; NULL != child; child = child->next) {
                        
                    BOOL match = NO;
                        
                    if (!partial && strcmp((char*)child->content, classNameStr) == 0) {
                        match = YES;
                    }
                        
                    else if (partial && strstr ((char*)child->content, classNameStr) != NULL) {
                        match = YES;
                    }
                    
                    if (match) {
                        return [[[MKHTMLNode alloc] initWithNode:cur_node] autorelease];
                    }
                }
                break;
            }
        }
            
        MKHTMLNode *cNode = [self nodeWithAttribute:attribute value:name XMLNode:cur_node->children allowPartial:partial];
        
        if (cNode != NULL) {
            return cNode;
        }
    }	
    return NULL;
}

- (NSArray *)childrenWithAttribute:(NSString *)attribute value:(NSString *)value allowPartial:(BOOL)partial {
    NSMutableArray * array = [NSMutableArray array];
    
	[self findChildrenWithAttribute:[attribute UTF8String] matchingName:[value UTF8String] inXMLNode:mNode->children inArray:array allowPartial:partial];
    
	return array;
}

- (void)findChildrenWithAttribute:(const char*)attribute matchingName:(const char*)className inXMLNode:(xmlNode *)node inArray:(NSMutableArray*)array allowPartial:(BOOL)partial {
	xmlNode *cur_node = NULL;
	const char * classNameStr = className;
	//BOOL found = NO;
    
    for (cur_node = node; cur_node; cur_node = cur_node->next) {				
		for(xmlAttrPtr attr = cur_node->properties; NULL != attr; attr = attr->next){
            
			if (strcmp((char*)attr->name, attribute) == 0){				
				for(xmlNode * child = attr->children; NULL != child; child = child->next){
                    
					BOOL match = NO;
					if (!partial && strcmp((char*)child->content, classNameStr) == 0)
						match = YES;
					else if (partial && strstr ((char*)child->content, classNameStr) != NULL)
						match = YES;
                    
					if (match){
						//Found node
						MKHTMLNode * nNode = [[[MKHTMLNode alloc] initWithNode:cur_node] autorelease];
						[array addObject:nNode];
						break;
					}
				}
				break;
			}
		}
        
		[self findChildrenWithAttribute:attribute matchingName:className inXMLNode:cur_node->children inArray:array allowPartial:partial];
	}	
    
}

- (MKHTMLNode *)childNodeNamed:(NSString *)name {
    return [self childNodeNamed:name XMLNode:mNode->children];
}

- (MKHTMLNode *)childNodeNamed:(NSString *)name XMLNode:(xmlNode *)node {
    xmlNode *cur_node = NULL;
	const char * tagNameStr =  [name UTF8String];
    
    for (cur_node = node; cur_node; cur_node = cur_node->next) {				
		if (cur_node && cur_node->name && strcmp((char*)cur_node->name, tagNameStr) == 0) {
			return [[[MKHTMLNode alloc] initWithNode:cur_node] autorelease];
		}
        
		MKHTMLNode * cNode = [self childNodeNamed:name XMLNode:cur_node->children];
		if (cNode != NULL) {
			return cNode;
		}
	}	
    
	return NULL;
}

- (NSArray *)childrenNamed:(NSString *)name {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    [self childNamed:name XMLNode:mNode array:array];
    
    return array;
}

- (void)childNamed:(NSString *)name XMLNode:(xmlNode *)node array:(NSMutableArray *)array {
    xmlNode *cur_node = NULL;
	const char * tagNameStr =  [name UTF8String];
    
	if (tagNameStr == nil) {
		return;
    }
    
    for (cur_node = node; cur_node; cur_node = cur_node->next) {				
		if (cur_node->name && strcmp((char*)cur_node->name, tagNameStr) == 0) {
			MKHTMLNode *nodeObj = [[[MKHTMLNode alloc] initWithNode:cur_node] autorelease];
			[array addObject:nodeObj];
            
		}
        
		[self childNamed:name XMLNode:cur_node->children array:array];
	}	
}

- (NSArray *)children {
    xmlNode *cur_node = NULL;
	NSMutableArray * array = [NSMutableArray array]; 
    
	for (cur_node = mNode->children; cur_node; cur_node = cur_node->next) {	
		MKHTMLNode * node = [[[MKHTMLNode alloc] initWithNode:cur_node] autorelease];
		[array addObject:node];
	}
    
	return array;
}

- (MKHTMLNode *)nextChildNode {
    return [[[MKHTMLNode alloc] initWithNode:mNode->next] autorelease];
}

- (MKHTMLNode *)previousChildNode {
    return [[[MKHTMLNode alloc] initWithNode:mNode->prev] autorelease];
}

- (MKHTMLNode *)parentNode {
    return [[[MKHTMLNode alloc] initWithNode:mNode->parent] autorelease];
}

#pragma mark - Node Types

- (MKHTMLNodeType)nodeType {
    return nodeType(mNode);
}

#pragma mark - C helpers

NSString * allNodeContents(xmlNode *node) {
	if (node == NULL) {
		return nil;
    }
    
	void * contents = xmlNodeGetContent(node);
	if (contents) {
		NSString * string = [NSString stringWithCString:contents encoding:NSUTF8StringEncoding];
		xmlFree(contents);
		return string;
	}
    
	return @"";
}

NSString * allContentsForNodesNamed(xmlNode *node, const char *name) {
    if (node == NULL) {
		return nil;
    }
    const char * tagName = (const char *)node->name;
    
    if (strcmp(tagName, name) == 0) {
        void * contents = xmlNodeGetContent(node);
        if (contents) {
            NSString * string = [NSString stringWithCString:contents encoding:NSUTF8StringEncoding];
            xmlFree(contents);
            return string;
        }
    }
    
	return @"";
}

NSString * rawContentsOfNode(xmlNode * node) {	
	xmlBufferPtr buffer = xmlBufferCreateSize(1000);
	xmlOutputBufferPtr buf = xmlOutputBufferCreateBuffer(buffer, NULL);
    
	htmlNodeDumpOutput(buf, node->doc, node, (const char*)node->doc->encoding);
    
	xmlOutputBufferFlush(buf);
    
	NSString * string = nil;
    
	if (buffer->content) {
		string = [[[NSString alloc] initWithBytes:(const void *)xmlBufferContent(buffer) length:xmlBufferLength(buffer) encoding:NSUTF8StringEncoding] autorelease];
	}
    
	xmlOutputBufferClose(buf);
	xmlBufferFree(buffer);
    
	return string;
}

NSString * getAttributeNamed(xmlNode *node, const char *nameStr) {
	for(xmlAttrPtr attr = node->properties; NULL != attr; attr = attr->next) {
		if (strcmp((char*)attr->name, nameStr) == 0) {				
			for(xmlNode * child = attr->children; NULL != child; child = child->next) {
				return [NSString stringWithCString:(void*)child->content encoding:NSUTF8StringEncoding];
			}
			break;
		}
	}
    
	return NULL;
}


MKHTMLNodeType nodeType(xmlNode *node) {
    if (node == NULL || node->name == NULL)
		return MKHTMLNodeUnknown;
    
	const char * tagName = (const char *)node->name;
	
    if (strcmp(tagName, kDivNode) == 0) {
        return MKHTMLNodeDiv;
    }
    else if (strcmp(tagName, kPNode) == 0) {
        return MKHTMLNodeP;
    }
    else if (strcmp(tagName, kScriptNode) == 0) {
        return MKHTMLNodeScript;
    }
    else if (strcmp(tagName, kANode) == 0) {
        return MKHTMLNodeA;
    }
    else if (strcmp(tagName, kLiNode) == 0) {
        return MKHTMLNodeLi;
    }
    else if (strcmp(tagName, kBlockquoteNode) == 0) {
        return MKHTMLNodeBlockquote;
    }
    else if (strcmp(tagName, kH1) == 0) {
        return MKHTMLNodeH1;
    }
    else if (strcmp(tagName, kImg) == 0) {
        return MKHTMLNodeImg;
    }
    else if (strcmp(tagName, kClosingNode) == 0) {
        return MKHTMLClosingNode;
    }
    
    return MKHTMLNodeUnknown;
}

@end