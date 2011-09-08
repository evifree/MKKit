//
//  MKGraphDrawing.m
//  MKKit
//
//  Created by Matthew King on 9/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKGraphics/MKGraphics.h>
#import "MKGraphDrawing.h"

void drawHorizontalText(CGContextRef context, CGRect rect, CFStringRef text, CGFloat size, CGColorRef color, UITextAlignment alignement) {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color);
    [(NSString *)text drawInRect:rect withFont:[UIFont fontWithName:@"Verdana-Bold" size:size] lineBreakMode:UILineBreakModeClip alignment:alignement];
    CGContextRestoreGState(context);
}

void drawVerticalText(CGContextRef context, CGRect rect, CFStringRef text, CGFloat size, CGColorRef color, UITextAlignment alignement) {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGContextRotateCTM(context, MK_D2R(-90.0));
    CGContextTranslateCTM(context, -CGRectGetMidX(rect), -CGRectGetMidY(rect));
    CGContextSetFillColorWithColor(context, color);
    [(NSString *)text drawInRect:rect withFont:[UIFont fontWithName:@"Verdana-Bold" size:size] lineBreakMode:UILineBreakModeClip alignment:alignement];
    CGContextRestoreGState(context);
}