//
//  MKGraphDrawing.h
//  MKKit
//
//  Created by Matthew King on 9/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#if MKKIT_AVAILABLE_TO_MKGRAPHS
    #import <MKKit/MKKit/MKMacros.h>
#else
    #define PI                                      3.14159265359f
    #define MK_D2R(deg)                             ((deg) / 180.0f * PI)
    #define MK_VISIBLE_ATTRIBUTE                    __attribute__((visibility ("default")))
    #define MK_TEXT_WIDTH(string, font)             [(string) sizeWithFont:(font)].width
    #define VERDANA_BOLD(points)                    [UIFont fontWithName:@"Verdana-Bold" size:(points)]
#endif

void drawHorizontalText(CGContextRef context, CGRect rect, CFStringRef text, CGFloat size, CGColorRef color, UITextAlignment alignment);
void drawVerticalText(CGContextRef context, CGRect rect, CFStringRef text, CGFloat size, CGColorRef color, UITextAlignment alignment);