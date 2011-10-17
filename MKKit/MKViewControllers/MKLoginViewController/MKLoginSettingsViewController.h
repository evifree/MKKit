//
//  MKLoginSettingsViewController.h
//  MKKit
//
//  Created by Matthew King on 5/19/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCellHeaders.h>
#import <MKKit/MKKit/MKViews/MKViewHeader.h>
#import <MKKit/MKKit/MKMacros.h>
#import "MKLoginViewController.h"

/**------------------------------------------------------------------------------------------
 *Overview*
 
 MKLoginSettingsViewController is a sister object to MKLoginViewContorller. This drop in Table view
 controllers provides the mechanism and the interface to change PINs and set Challenge Questions and 
 answers.
 
 *Required Resources*
 
 MKLoginViewController looks in your applications bundle for a property list named `Questions.plist`. T
 he property list should contain an array of strings that are the last half of the question. The first half of 
 the questions are preset to "What's your ". 
 
 MKLoginSettingsViewController conforms to the MKTableCellDelegate.
 
 *Required Classes*
 
 * MKLoginViewController
 * MKMacros
 * MKTableCell
 * MKTableCellPickerControlled
 * MKTableCellTextEntry
 * MKView
 
 *Required Frameworks*
 
 * Foundation
 * UIKit
-------------------------------------------------------------------------------------------*/

@interface MKLoginSettingsViewController : UITableViewController <MKTableCellDelegate> {
    
}

@end
