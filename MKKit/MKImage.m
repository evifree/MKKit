//
//  MKImage.m
//  MKKit
//
//  Created by Matthew King on 12/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKImage.h"

@interface MKImage () 

- (id)initWithName:(NSString *)name graphicStruct:(MKGraphicsStructures *)graphicStruct;
- (MKImage *)maskFromImage:(UIImage *)image graphicStruct:(MKGraphicsStructures *)graphicStruct;

@end

@implementation MKImage 

#pragma mark - Creation

+ (id)imagedNamed:(NSString *)imageName graphicStruct:(MKGraphicsStructures *)graphicStruct {
    return [[[self alloc] initWithName:imageName graphicStruct:graphicStruct] autorelease];
}

- (id)initWithName:(NSString *)name graphicStruct:(MKGraphicsStructures *)graphicStruct {
    self = [super init];
    if (self) {
        self = [self maskFromImage:[UIImage imageNamed:name] graphicStruct:graphicStruct];
        [self retain];
    }
    return self;
}

- (id)initWithContentsOfFile:(NSString *)path graphicStruct:(MKGraphicsStructures *)graphicStruct {
    self = [super initWithContentsOfFile:path];
    if (self) {
        self = [self maskFromImage:self graphicStruct:graphicStruct];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Masking

- (MKImage *)maskFromImage:(UIImage *)image graphicStruct:(MKGraphicsStructures *)graphicStruct {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width, image.size.height), NO, 2.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    CGImageRef imageRef = image.CGImage;
    
    CGContextTranslateCTM(context, 0.0, image.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextClipToMask(context, imageRect, imageRef);
    drawWithGraphicsStructure(context, imageRect, graphicStruct);
    
    UIImage *maskedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
       
    MKImage *rtnImage = (MKImage *)maskedImage;
        
    return rtnImage;
}

@end
