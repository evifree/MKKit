//
//  MKGraphDataSource.h
//  MKKit
//
//  Created by Matthew King on 9/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//


typedef struct {
    float max;
    float min;
} MKGraphScale;

@class MKGraphView, MKGraphDataSet;

/**-----------------------------------------------------------------
 Provides the data for a MKGraphView. All methods are required for 
 the graph view to work correcly.
 -----------------------------------------------------------------*/
@protocol MKGraphDataSource <NSObject>

@required

///---------------------------
/// @name Set Up
///---------------------------

/** 
 Return the nuber of data sets that your graph will use. 
 
 @param graphView the MKGraphView instance that is asking for the data.
 
 @exception Too many data sets : An execption will be rasied if there are 
 too many data sets to fit on the graph area.
*/
- (NSInteger)numberOfDataSetsForGraphView:(MKGraphView *)graphView;

/**
 Retrun the scale of the graph. Scales can be made using the
 `MKGraphScaleMake(float max, float min)` funtion.
 
 @param graphView the MKGraphView instance that is asking for the data.
*/
- (MKGraphScale)scaleForGraphView:(MKGraphView *)graphView;

///---------------------------
/// @name Providing Data
///---------------------------

/**
 Return a MKGraphDataSet for each set of data in the graph.
 
 @param graphView the MKGraphView instance that is asking for the data.
 
 @param index the index of the data set. Index 0 is closest to the origin of the graph.
*/
- (MKGraphDataSet *)graphView:(MKGraphView *)graphview dataSetForIndex:(NSInteger)index;

@end
