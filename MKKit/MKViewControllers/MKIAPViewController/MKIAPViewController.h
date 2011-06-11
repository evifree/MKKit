//
//  MKIAPViewController.h
//  MKKit
//
//  Created by Matthew King on 5/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCellHeaders.h>
#import <MKKit/MKKit/MKStrings.h>

#import "MKIAPController.h"
#import "MKIAPObserver.h"

@protocol MKIAPObserver;

/**---------------------------------------------------------------------------
 MKIAPViewController provides a store front interface for your inApp Purchases.
 This is drop in store front, just call the default initalizer and place the
 instance in your view controller stack.  
 
 Results of purchase and request are sent to the MKIAPObserver. The MKIAPObserver
 has one required method.
 
 This class works along with MKIAPController and MKTableCellIAP.
 ---------------------------------------------------------------------------*/

@interface MKIAPViewController : UITableViewController <MKTableCellDelegate> {
    id mObserver;
    NSArray *mItems;
    
@private
    BOOL mProductsSet;
    NSSet *mIdentifiers;
}

///---------------------------------------------------------------------------
/// @name Creating Instances
///---------------------------------------------------------------------------

/**
 Returns an intialized instance of the MKIAPViewController Class.
 
 @param identifiers a set of your inApp Purchase identifiers. `Required`
 
 @param observer a designated observer. The observer must meet the 
 MKIAPObserver protocol. `Required`
 
*/
- (id)initWithIdentifiers:(NSSet *)identifiers observer:(id<MKIAPObserver>)observer;

///---------------------------------------------------------------------------
/// @name Products
///---------------------------------------------------------------------------

/** An array of the availble inApp Purchase Items */
@property (nonatomic, copy) NSArray *items;

///---------------------------------------------------------------------------
/// @name Observer
///---------------------------------------------------------------------------

/** The MKIAPViewController observer */
@property (nonatomic, assign) id<MKIAPObserver> observer;

@end
