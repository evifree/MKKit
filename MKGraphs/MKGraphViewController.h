//
//  MKGraphViewController.h
//  MKKit
//
//  Created by Matthew King on 9/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKGraphs/MKGraphView/MKGraphView.h>

@class MKGraphViewDataSet;

/**----------------------------------------------------------------------
 Provides a view controler for MKGraphView. This class is ment to be subclassed.
 MKGraphViewController conforms to the MKGraphDataSource protocol. You will 
 be required to provide the implementation of the the datasource methods.
 
 @warning *Prototype class. Not fully functional.*
-----------------------------------------------------------------------*/
@interface MKGraphViewController : UIViewController <MKGraphDataSource> {
    
}

/** The MKGraphView of the controller */
@property (nonatomic, retain) IBOutlet MKGraphView *graphView;

@end
