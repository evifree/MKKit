//
//  MKGraphics.m
//  MKKit
//
//  Created by Matthew King on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKGraphics.h"

#pragma mark - gradients

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 1.0};
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinX(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

void drawGlossAndLinearGradient(CGContextRef conext, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    drawLinearGradient(conext, rect, startColor, endColor);
    
    UIColor *gloss1color = MK_COLOR_RGB(255.0, 255.0, 255.0, 0.35);
    UIColor *gloss2color = MK_COLOR_RGB(255.0, 255.0, 255.0, 0.1);
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, (rect.size.height / 2.0));
    
    drawLinearGradient(conext, topHalf, gloss1color.CGColor, gloss2color.CGColor);
}

#pragma mark - Rects

CGRect rectFor1pxStroke(CGRect rect) {
    return CGRectMake(rect.origin.x + 0.5, rect.origin.y + 0.5, rect.size.width - 1, rect.size.height - 1);
}

#pragma mark - Paths

CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect),CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    
    CGPathCloseSubpath(path);
    
    return path;      
}

CGMutablePathRef createCircularPathForRect(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddEllipseInRect(path, NULL, rect);
    CGPathCloseSubpath(path);
    
    return path;
}

CGMutablePathRef createPathForUpPointer(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    return path;
}

CGMutablePathRef createPathForDownPointer(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    return path;
}

void drawOutlinePath(CGContextRef context, CGPathRef path, CGFloat width, CGColorRef color) {
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, width);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma mark - Text

void drawText(CGContextRef context, CGRect rect, CFStringRef text, CGColorRef color, CGColorRef shadowColor, CGFloat size) {
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, color);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 1), 1.0, shadowColor);
    [(NSString *)text drawInRect:rect withFont:[UIFont fontWithName:VERDANA_BOLD_FONT size:size]];
    CGContextRestoreGState(context);
}

#pragma mark - Gloss

void drawCurvedGloss(CGContextRef context, CGRect rect, CGFloat radius) {
    
    CGColorRef glossStart = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6].CGColor;
    CGColorRef glossEnd = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    CGMutablePathRef glossPath = CGPathCreateMutable();
    
    CGContextSaveGState(context);
    CGPathMoveToPoint(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2);
    CGPathAddArc(glossPath, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect)-radius+rect.size.height/2, radius, 0.75f*M_PI, 0.25f*M_PI, YES); 
    CGPathCloseSubpath(glossPath);
    CGContextAddPath(context, glossPath);
    CGContextClip(context);
    CGContextAddPath(context, createRoundedRectForRect(rect, 6.0f));
    CGContextClip(context);
    
    CGRect half = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);    

    drawLinearGradient(context, half, glossStart, glossEnd);
    CGContextRestoreGState(context);
    
    CFRelease(glossPath);
}

void drawLinearGloss(CGContextRef context, CGRect rect) {
    UIColor *gloss1color = MK_COLOR_RGB(255.0, 255.0, 255.0, 0.35);
    UIColor *gloss2color = MK_COLOR_RGB(255.0, 255.0, 255.0, 0.1);
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, (rect.size.height / 2.0));
    
    drawLinearGradient(context, topHalf, gloss1color.CGColor, gloss2color.CGColor);
}