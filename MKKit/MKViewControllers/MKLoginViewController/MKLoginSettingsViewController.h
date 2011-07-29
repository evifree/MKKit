//
//  MKLoginSettingsViewController.h
//  MKKit
//
//  Created by Matthew King on 5/19/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCellHeaders.h>
#import <MKKit/MKKit/MKViews/MKViewHeader.h>
#import <MKKit/MKKit/MKMacros.h>
#import "MKLoginViewController.h"

/**------------------------------------------------------------------------------------------
 MKLoginSettingsViewController is a sister object to MKLoginViewContorller. This drop in Table view
 controllers provides the mechanism to change PINs and set Challenge Questions and answers.
 
 MKLoginViewController looks for an property list named `Questions.plist`. The property list
 should contain an array of strings that are the last half of the question. The first half of 
 the questions are preset to "Whats your ".
 
 MKLoginSettingsViewController conforms to the MKTableCellDelegate.
-------------------------------------------------------------------------------------------*/

@interface MKLoginSettingsViewController : UITableViewController <MKTableCellDelegate> {
    
}

@end
