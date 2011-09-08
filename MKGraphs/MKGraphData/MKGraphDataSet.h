//
//  MKGraphDataSet.h
//  MKKit
//
//  Created by Matthew King on 9/3/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

typedef struct {
    CFStringRef title;
    float value;
} MKGraphData;

MKGraphData MKGraphDataMake(CFStringRef title, float value);

/**--------------------------------------------------------------
 MKGraphData provides standardized data for a MKGraphView.
---------------------------------------------------------------*/
@interface MKGraphDataSet : NSObject {
    @private
    MKGraphData mData;
}

///-------------------------------------
/// @name Creating
///-------------------------------------

/**
 Creates an instance of MKGraphData to be used with an MKGraphView.
 
 @param title the title of the data field
 
 @param value the value of the data field
 
 @return MKGraphData instance
*/
- (id)initWithTitle:(NSString *)title value:(CGFloat)value;

///--------------------------------------
/// @name Accessing Data
///--------------------------------------

/** The data of the instance in MKGraphData struct defined as:
    
    typedef struct {
        CFStringRef title;
        float value;
    } MKGraphData;
*/
@property (nonatomic, readonly) MKGraphData data;

@end
