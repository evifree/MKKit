//
//  MKTableCellIAP.h
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>
#import "MKIAPController.h"
#import "MKIAPObserver.h"

typedef enum {
    MKButtonStatePrice,
    MKButtonStateInstalling,
    MKButtonStateComplete,
    MKButtonStateRetry,
} MKButtonState;

@protocol MKIAPObserver;

/**-------------------------------------------------------------------------
 MKTableCellIAP provides an interface for In App Purchases. The cell has a 
 a label and a purchase button. This cell works with MKIAPController to make
 purchases via the inApp Purchase API. 
 
 If you are using this cell directly you need to provide a MKIAPObserver and 
 follow its protocol.
--------------------------------------------------------------------------*/

@interface MKTableCellIAP : MKTableCell <MKControlDelegate> {
    id mObserver;
    
    NSString *mPrice;
    NSString *mIAPIdentifier;
    
@private
    MKButton *mButton;
}

///------------------------------------------------------------------------
/// @name Product Details
///------------------------------------------------------------------------

/** The price of the IAP */
@property (nonatomic, copy) NSString *price;

/** The identifier of the product **/
@property (nonatomic, copy) NSString *IAPIdentifier;

///------------------------------------------------------------------------
/// @name Transactions Observer
///------------------------------------------------------------------------

/** The IAP Transaction observer. If you are using MKIAPViewController this is
 set for you */
@property (nonatomic, assign) id<MKIAPObserver> observer;

@end
