//
//  MKGraphPlotting.h
//  MKKit
//
//  Created by Matthew King on 9/5/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

#import <MKKit/MKGraphs/MKGraphsData/MKGraphDataSource.h>
#import "MKGraphDrawing.h"

struct MKGraphAxisPointLabel {
    CGPoint point;
    CFStringRef title;
} MKGraphAxisPointLabel MK_VISIBLE_ATTRIBUTE;

struct MKGraphAxisPointLabel MKGraphAxisPointLabelMake(CGPoint point, CFStringRef title);

CFMutableArrayRef CreateYAxisPoints(MKGraphScale scale, CGRect graphRect);
