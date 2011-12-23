//
//  MKGraphicsStructures.m
//  MKKit
//
//  Created by Matthew King on 9/18/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import "MKGraphicsStructures.h"

@interface MKGraphicsStructures ()

- (id)initWithLinearGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor;

@end

@implementation MKGraphicsStructures

@synthesize fill;

@dynamic top, bottom;

#pragma mark - Creation

+ (id)graphicsStructure {
    return [[[[self class] alloc] init] autorelease];
}

+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    return [[[[self class] alloc] initWithLinearGradientTopColor:topColor bottomColor:bottomColor] autorelease];
}

- (id)initWithLinearGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    self = [super init];
    if (self) {
        mTopColor = [topColor retain];
        mBottomColor = [bottomColor retain];
    }
    return self;
}

#pragma mark - Memory Managment

- (void)dealloc {
    self.top = nil;
    self.bottom = nil;
    self.fill = nil;
    
    [mTopColor release];
    [mBottomColor release];
    
    [super dealloc];
}

#pragma mark - Adding Structures

- (void)assignGradientTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    self.top = topColor;
    self.bottom = bottomColor;
}

#pragma mark - Accessor Methods
#pragma mark Setters

- (void)setTop:(UIColor *)topColor {
    mTopColor = [topColor retain];
}

- (void)setBottom:(UIColor *)bottomColor {
    mBottomColor = [bottomColor retain];
}

#pragma mark Getters

- (UIColor *)top {
    return mTopColor;
}

- (UIColor *)bottom {
    return mBottomColor;
}

@end