//
//  MKGraphics.h
//  MKKit
//
//  Created by Matthew King on 6/14/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>

#import "MKGraphicsStructures.h"

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
void drawGlossAndLinearGradient(CGContextRef conext, CGRect rect, CGColorRef startColor, CGColorRef endColor);

CGRect rectFor1pxStroke(CGRect rect); 

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);
CGMutablePathRef createCircularPathForRect(CGRect rect);
CGMutablePathRef createPathForUpPointer(CGRect rect);
CGMutablePathRef createPathForDownPointer(CGRect rect);

void drawText(CGContextRef context, CGRect rect, CFStringRef text, CGColorRef color, CGColorRef shadowColor, CGFloat size);

void drawOutlinePath(CGContextRef context, CGPathRef path, CGFloat width, CGColorRef color);

void drawCurvedGloss(CGContextRef context, CGRect rect, CGFloat radius);
void drawLinearGloss(CGContextRef context, CGRect rect);