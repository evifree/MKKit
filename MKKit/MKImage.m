//
//  MKImage.m
//  MKKit
//
//  Created by Matthew King on 12/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKImage.h"

@interface MKImage () 

- (id)initWithName:(NSString *)name color:(UIColor *)color;
- (MKImage *)maskFromImage:(UIImage *)image color:(UIColor *)color;

@end

@implementation MKImage 

#pragma mark - Creation

+ (id)imagedNamed:(NSString *)imageName maskedColor:(UIColor *)color {
    return [[[self alloc] initWithName:imageName color:color] autorelease];
}

- (id)initWithName:(NSString *)name color:(UIColor *)color {
    self = [super init];
    if (self) {
        self = [self maskFromImage:[UIImage imageNamed:name] color:color];
    }
    return self;
}

- (id)initWithContentsOfFile:(NSString *)path maskedColor:(UIColor *)color {
    self = [super initWithContentsOfFile:path];
    if (self) {
        self = [self maskFromImage:self color:color];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

#pragma mark - Masking

- (MKImage *)maskFromImage:(UIImage *)image color:(UIColor *)color {
    CGContextRef context = createBitmapContext(image.size.width, image.size.height);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    CGImageRef imageRef = image.CGImage;
    CGColorRef imageColor = color.CGColor;
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, imageColor);
    CGContextClipToMask(context, imageRect, imageRef);
    CGContextTranslateCTM(context, 0.0, image.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);
    CGContextFillRect(context, imageRect);
    CGContextSaveGState(context);

    CGImageRef maskedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    MKImage *rtnImage = (MKImage *)[UIImage imageWithCGImage:maskedImage];
    CGImageRelease(maskedImage);
    
    return rtnImage;
}

@end
