//
//  MKGraphView.m
//  MKKit
//
//  Created by Matthew King on 9/7/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKGraphView.h"
#import "MKBarGraphView.h"

MKGraphScale MKGraphScaleMake(float max, float min) {
    MKGraphScale iScale;
    
    iScale.max = max;
    iScale.min = min;
    
    return iScale;
}

MKLimitLine MKLimitLineMake(float value, CGColorRef color, CFStringRef label) {
    MKLimitLine limit;
    
    limit.value = value;
    limit.color = color;
    limit.label = label;
    
    return limit;
}

@implementation MKGraphView

@synthesize xAxisTitle, yAxisTitle, scale=mScale, datasource, limitLine=mLimit;

- (id)initWithFrame:(CGRect)frame type:(MKGraphType)type {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        hasGraphData = NO;
        
        if (type == MKGraphTypeBar) {
            [self release];
            
            self = [[MKBarGraphView alloc] initWithFrame:frame];
        }
    }
    return self;
}

#pragma mark - Building

- (void)buildGraph {
#if MKKIT_ALLOWED <= MKKIT_MAX_ALLOWED
    MKLoadingView *loadingView = [[MKLoadingView alloc] initWithType:MKLoadingViewTypeIndicator status:@"Loading"];
    [loadingView showWithAnimationType:MKViewAnimationTypeFadeIn];
    [loadingView release];
#endif
    
    mScale = [self.datasource scaleForGraphView:self];
    dataSetsCount = [self.datasource numberOfDataSetsForGraphView:self];
    
    dataSets = [[NSMutableArray alloc] initWithCapacity:dataSetsCount];
    
    for (int i = 0; i < dataSetsCount; i++) {
        MKGraphDataSet *data = [self.datasource graphView:self dataSetForIndex:i];
        [dataSets addObject:data];
    }
    
    hasGraphData = YES;
    [self performSelector:@selector(setNeedsDisplay) onThread:[NSThread mainThread] withObject:nil waitUntilDone:YES];
}

#pragma mark - Memory Management

- (void)dealloc {
    [xAxisTitle release];
    [yAxisTitle release];
    
    [super dealloc];
}
@end
