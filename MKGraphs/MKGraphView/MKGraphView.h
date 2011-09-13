//
//  MKGraphView.h
//  MKKit
//
//  Created by Matthew King on 9/7/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKGraphs/MKGraphData/MKGraphDataSource.h>
#import <MKKit/MKGraphs/MKGraphData/MKGraphDataSet.h>
#import <MKKit/MKGraphs/MKGraphsAvailability.h>

#import "MKGraphDrawing.h"
#import "MKGraphPlotting.h"

#if MKKIT_ALLOWED <= MKKIT_MAX_ALLOWED
#import <MKKit/MKKit/MKViews/MKLoadingView.h>
#endif

typedef enum {
    MKGraphTypeNone,
    MKGraphTypeBar,
} MKGraphType;

typedef struct {
    float value;
    CGColorRef color;
    CFStringRef label;
} MKLimitLine;

MKGraphScale MKGraphScaleMake(float max, float min);
MKLimitLine MKLimitLineMake(float value, CGColorRef color, CFStringRef label);

static const float kBarPadding = 2.0;

@protocol MKGraphDataSource;

/**---------------------------------------------------------------
 MKGraphView is a superclass for other MKGraphViewInstances.
----------------------------------------------------------------*/
@interface MKGraphView : UIView {
    id datasource;
    MKGraphScale mScale;
    MKLimitLine mLimit;
    NSInteger dataSetsCount;
    NSMutableArray *dataSets;
    bool hasGraphData;
}

///----------------------------
/// @name Creating
///----------------------------

/**
 Returns and instance of a MKGraphView.
 
 @param frame the frame of the graph
 
 @param type the type of graph to use available types are:
 
 * `MKGraphTypeBar` : creats a bar graph.
*/
- (id)initWithFrame:(CGRect)frame type:(MKGraphType)type;

///-----------------------------
/// @name Loading Data
///-----------------------------

/**
 Call this method after all the graphs view properties have been set.
*/
- (void)buildGraph;

///-----------------------------
/// @name Settings
///-----------------------------

/** Scale of the graph. Set through the delegate. */
@property (nonatomic, assign, readonly) MKGraphScale scale;

/** Draws a line across the the x Axis at a given point */
@property (nonatomic, assign) MKLimitLine limitLine;

/** Title of the x Axis */
@property (nonatomic, copy) NSString *xAxisTitle;

/** Title of the y Axis */
@property (nonatomic, copy) NSString *yAxisTitle;

///----------------------------
/// @name Datasource
///----------------------------

/** Datasource for the graph view */
@property (nonatomic, assign) IBOutlet id<MKGraphDataSource> datasource;

@end
