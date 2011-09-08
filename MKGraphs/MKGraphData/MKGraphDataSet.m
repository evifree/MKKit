//
//  MKGraphDataSet.m
//  MKKit
//
//  Created by Matthew King on 9/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKGraphDataSet.h"

MKGraphData tempData;

MKGraphData MKGraphDataMake(CFStringRef title, float value) {
    tempData.title = title;
    tempData.value = value;
    
    return tempData;
}

@implementation MKGraphDataSet

@synthesize data=mData;

- (id)initWithTitle:(NSString *)title value:(CGFloat)value {
    self = [super init];
    if (self) {
        mData = MKGraphDataMake((CFStringRef)title, value);
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
