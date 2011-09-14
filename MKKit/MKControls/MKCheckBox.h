//
//  MKCheckBox.h
//  MKKit
//
//  Created by Matthew King on 10/3/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MKControl.h"

typedef enum {
    MKCheckBoxRoundedRect,
    MKCheckBoxRound,
} MKCheckBoxType;

/**----------------------------------------------------------------------------------------
 The MKCheckBox class creates a 30x30 checkbox object. When the user touches the check box it is toggled
 on and off.
 
 MKCheckBox dispatches the MKActionValueChanged
-------------------------------------------------------------------------------------------*/

@interface MKCheckBox : MKControl {
@private
    MKCheckBoxType mType;
    struct {
        bool isChecked;
    } MKCheckBoxFlags;
}

///------------------------------------
/// @name Creating
///------------------------------------

/** 
 Returns an instance of MKCheckBox.
 
 @param type the MKCheckBoxType to uses
 
 * `MKCheckBoxRoundedRect` : A rounded rect outline for the check box.
 * `MKCheckBoxRound` : A round outline for the check box.
 
 @return MKCheckBox instance.
*/
- (id)initWithType:(MKCheckBoxType)type;

///------------------------------------
/// @name Control
///------------------------------------

/** `YES` if the box is checked, `NO` if it is not */
@property (nonatomic, assign) BOOL boxChecked;

///------------------------------------
/// @name Apperance
///------------------------------------

/** Sets the type of check box that is used.
 
 * `MKCheckBoxRoundedRect` : A rounded rect outline for the check box.
 * `MKCheckBoxRound` : A round outline for the check box.
*/
@property (nonatomic, assign) MKCheckBoxType type;

@end
