//
//  MKAlerts.h
//  MKKit
//
//  Created by Matthew King on 2/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum  {
	MKAlertTypeNotify,								//Alert View with one OK button (no owner needed)
	MKAlertTypeYesNo,								//Alert View with YES[0], NO[1] buttons and "Just Checking" title
	MKAlertTypeTryAgain,							//Alert View with Try Again[0], Restart[1] buttons and "Sorry" title
} MKAlertType;

/**-----------------------------------------------------------------------------------------------------------
 The MKAlert returns pre set UIAlertViews.  Setting the MKAlert type will return one of the specified alerts.

 Here are the values accepted as an MKAlertType :
 
 * `MKAlertTypeNotify` : Returns an alert view with a Success tilte on one OK button (owner can be nil for
 this type.
 * `MKAlertTypeYesNo` : Returns an alert view with a Just Checking title, a YES[0] and NO[1] buttons.
 * `MKAlertTypeTryAgain` : Returns an alert view a Sorry title, a Try Again[0], and Restart[1] buttons.
 
 This class does not show the alert for you. It is up to when to display it.
 
 Here is an example:
 
	MKAlerts *alert = [[MKAlerts alloc] initWithType:MKAlertTypeYesNo owner:self message:@"my message"];
	[alert show];
	[alert release];
-------------------------------------------------------------------------------------------------------------*/

@interface MKAlerts : UIAlertView {
}

/** Returns an intialized MKAlerts object.
 
 @param type An MKAlertType that tells what kind of alert show.
 @param owner The owner is used to set the delegate of the UIAlertyView.
 @param message The message to display on the alert view.
*/
- (id)initWithType:(MKAlertType)type owner:(id)owner message:(NSString*)message; 

@end
