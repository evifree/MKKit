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