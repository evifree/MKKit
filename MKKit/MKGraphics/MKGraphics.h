//
//  MKGraphics.h
//  MKKit
//
//  Created by Matthew King on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor);
void drawGlossAndLinearGradient(CGContextRef conext, CGRect rect, CGColorRef startColor, CGColorRef endColor); 

CGRect rectFor1pxStroke(CGRect rect); 
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius);

void drawText(CGContextRef context, CGRect rect, CFStringRef text, CGColorRef color, CGColorRef shadowColor, CGFloat size);