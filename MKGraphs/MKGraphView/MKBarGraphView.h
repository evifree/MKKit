//
//  MKGraphView.h
//  MKKit
//
//  Created by Matthew King on 9/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <MKKit/MKGraphs/MKGraphView/MKGraphView.h>

@protocol MKGraphDataSource;

/**----------------------------------------------------
 MKBarGraphView is a subclass of MKGraphView. The class
 handels the drawing when the MKGraphTypeBar is used.
 ----------------------------------------------------*/
@interface MKBarGraphView : MKGraphView {
    @private
    CFStringRef mXAxisTitle;
    CFStringRef mYAxisTitle;
    struct {
        bool hasXAxis;
        bool hasYAxis;
        bool hasXAxisTitle;
        bool hasYAxisTitle;
        bool showHorizontalGridLines;
        bool showVerticalGridLines;
        int numberOfDataSets;
    } MKGraphViewFlags;
}

@end
