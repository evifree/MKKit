//
//  MKNotificationController.m
//  MKKit
//
//  Created by Matthew King on 12/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKNotificationController.h"


@implementation MKNotificationController

@synthesize noticeDate=_noticeDate, messageString=_messgaeString, actionButton=_actionButton, userInfoDic=_userInfoDic;

#pragma mark -
#pragma mark Initalizer

- (id)initWithDate:(NSDate *)date message:(NSString *)message actionButtonTitle:(NSString *)title userInfo:(NSDictionary *)userInfo {
	if (self = [super init]) {
		_noticeDate = [date retain];
		_messgaeString = [message retain];
		_actionButton = [title retain];
		_userInfoDic = [userInfo retain];
	}
	return self;
}

#pragma mark -
#pragma mark LocalMethods

- (void)commitWithBadgeNumber:(NSInteger)badgeNumber {
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	
	NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit ) fromDate:_noticeDate];
	NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:_noticeDate];
	
	NSDateComponents *dateComps = [[NSDateComponents alloc] init];
	[dateComps setDay:[dateComponents day]];
	[dateComps setMonth:[dateComponents month]];
	[dateComps setYear:[dateComponents year]];
	[dateComps setHour:[timeComponents hour]];
	[dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
	
	NSDate *itemDate = [calendar dateFromComponents:dateComps];
	
	[dateComps release];
	
	UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	localNotification.fireDate = itemDate;
	localNotification.applicationIconBadgeNumber = badgeNumber;
	localNotification.timeZone = [NSTimeZone localTimeZone];
	localNotification.alertBody = _messgaeString;
	localNotification.alertAction = _actionButton;
	localNotification.soundName = UILocalNotificationDefaultSoundName;
	localNotification.userInfo = _userInfoDic;
	
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
	[localNotification release];
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[super dealloc];
	
	[_noticeDate release];
	[_messgaeString release];
	[_actionButton release];
	[_userInfoDic release];
}

@end
