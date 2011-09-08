//
//  MKGraphPlotting.m
//  MKKit
//
//  Created by Matthew King on 9/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKGraphPlotting.h"

struct MKGraphAxisPointLabel MKGraphAxisPointLabelMake(CGPoint point, CFStringRef title) {
    struct MKGraphAxisPointLabel pointLabel;
    
    pointLabel.point = point;
    pointLabel.title = title;
    
    return pointLabel;
}

CFMutableArrayRef CreateYAxisPoints(MKGraphScale scale, CGRect graphRect) {
    CFMutableArrayRef points = CFArrayCreateMutable(kCFAllocatorDefault, 4.0, &kCFTypeArrayCallBacks);
    
    CGFloat xPoint = CGRectGetMinX(graphRect);
    
    NSString *pointOneLabel = [NSString stringWithFormat:@"%f", scale.max];
    
    struct MKGraphAxisPointLabel pointOne = MKGraphAxisPointLabelMake(CGPointMake(xPoint, CGRectGetMinY(graphRect)), (CFStringRef)pointOneLabel);
    const struct MKGraphAxisPointLabel *pPointOne = &pointOne;
    
    CFArrayAppendValue(points, pPointOne);
    
    return points;
}
