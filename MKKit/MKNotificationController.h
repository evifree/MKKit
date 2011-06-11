//
//  MKNotificationController.h
//  MKKit
//
//  Created by Matthew King on 12/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**-------------------------------------------------------------------------------------------------
 The MKNotiificationContoller sets local notifications for you. All you have to do is provide some basic
 information and than commit the notification. The rest of the work is done for you.
 
 Here is how it works:
 
	MKNotificationController *notification = [[MKNotificationController alloc] initWithDate:aDate message:myMessage actionButtonTitle:title userInfo:myinfo];
	[notification commitWithBadgeNumber:4];
 
 A local notification is now set.
----------------------------------------------------------------------------------------------------*/

@interface MKNotificationController : NSObject {
	NSDate *_noticeDate;
	NSString *_messgaeString;
	NSString *_actionButton;
	NSDictionary *_userInfoDic;
}

///-----------------------------------------------
/// @name Initalizer
///-----------------------------------------------

/** Returns and intailized MKNotificationContoller object.
 
 @param date The date the notification should be sent to the user.
 @param title The action button title of the notification.
 @param userInfo A dictionary containing information that notification will need.
*/
- (id)initWithDate:(NSDate *)date message:(NSString *)message actionButtonTitle:(NSString *)title userInfo:(NSDictionary *)userInfo;

///----------------------------------------------
/// @name Notification Components
///----------------------------------------------

/** The date and time that notification will fire. */
@property (nonatomic, retain) NSDate *noticeDate;

/** The message that will be displayed on the notification. */
@property (nonatomic, retain) NSString *messageString;

/** The title of the notification's action button. */
@property (nonatomic, retain) NSString *actionButton;

/** A dictionany of the information needed by the notification. */
@property (nonatomic, retain) NSDictionary *userInfoDic;

///---------------------------------------------
/// @name Committing
///---------------------------------------------

/** Adds the notification to the to devices local que.
 
 @param badgeNumber The badge number that will be displayed on the application icon when the notificaion is posted.
 Set this value to zero for no badge number.
*/
- (void)commitWithBadgeNumber:(NSInteger)badgeNumber;

@end
