//
//  MKPaging.h
//  MKKit
//
//  Created by Matthew King on 12/4/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "MKControl.h"

/**---------------------------------------------------------------
 *Overview*
 
 MKPaging provieds an interface for navigating between pages of an app.
 The interface is long bar with an arrow on either side and dots in the
 middle. The arrows respond to touches and the dots represent the pages
 of the document. 
 
 MKPaging only provieds an interface and sends events, it does not 
 preform any transitions between pages.
 
 *Usage Notes*
 
 Since MKPaging does not preform an transitions, it does not update
 the numberOfPages or currentPage properties. For the proper function
 of the interface, these properties should be updated when transitions
 are completed.
 
 *Dispatched Actions*
 
 MKPaging dispatches two types of actions:
 
 * `MKActionValueIncreased` : Sent when a touch on the right arrow ends.
 * `MKActionValueDecreased` : Sent when a touch on the left arrow ends.
----------------------------------------------------------------*/

@interface MKPaging : MKControl {
@private
    CGRect leftArrowRect;
    CGRect rightArrowRect;
    struct {
        BOOL leftArrowActive;
        BOOL rightArrowActive;
        int currentPage;
        int pages;
    } MKPagingFlags;
}

///-----------------------------------------
/// @name Creating
///-----------------------------------------

/**
 Creates an instance of MKPaging for the given 
 number of Pages. The number of pages can be 
 changed using the numberOfPages property.
 
 @param numOfPages The number of pages (dots) the
 interface will display.
 
 @return MKPaging instance
*/
- (id)initWithPages:(NSInteger)numOfPages;

///-----------------------------------------
/// @name Page Control
///-----------------------------------------

/** The number of pages (dots) the interface will display */
@property (nonatomic, assign) NSInteger numberOfPages;

/** The current page (dot) that is highlighted */
@property (nonatomic, assign) NSInteger currentPage;

@end
