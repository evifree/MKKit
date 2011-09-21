//
//  MKGraphicsStructures.m
//  MKKit
//
//  Created by Matthew King on 9/18/11.
//  Copyright (c) 2010-2011 Matt King. All rights reserved.
//

#import "MKGraphicsStructures.h"

@implementation MKGraphicsStructures

@end

static const char *TopColorTag = "TopColorTag";
static const char *BottomColorTag = "BottomColorTag";

@implementation MKGraphicsStructures (LinearGradient)

@dynamic top, bottom;

#pragma mark - Creating

+ (id)linearGradientWithTopColor:(UIColor *)topColor bottomColor:(UIColor *)bottomColor {
    MKGraphicsStructures *gradient = [[[[self class] alloc] init] autorelease];
    gradient.top = topColor;
    gradient.bottom = bottomColor;
    
    return gradient;
}

#pragma mark - Accessor Methods
#pragma mark Setters

- (void)setTop:(UIColor *)topColor {
    objc_setAssociatedObject(self, TopColorTag, topColor, OBJC_ASSOCIATION_RETAIN);
}

- (void)setBottom:(UIColor *)bottomColor {
    objc_setAssociatedObject(self, BottomColorTag, bottomColor, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark Getters

- (UIColor *)top {
    return (UIColor *)objc_getAssociatedObject(self, TopColorTag);
}

- (UIColor *)bottom {
    return (UIColor *)objc_getAssociatedObject(self, BottomColorTag);
}

#pragma mark - Memory Managment

- (void)didRelease {
    objc_removeAssociatedObjects(self);
}

@end