//
//  MKAlerts.m
//  MKKit
//
//  Created by Matthew King on 2/18/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKAlerts.h"

@implementation MKAlerts

- (id)initWithType:(MKAlertType)type owner:(id)owner message:(NSString*)message {
	//** MKAlertTypeNofify **//
	if (type == MKAlertTypeNotify) {
		self = (MKAlerts *)[[UIAlertView alloc] initWithTitle:@"Success" message:message delegate:owner cancelButtonTitle:@"OK" otherButtonTitles:nil];
	}
	
	//** MKAlertTypeYesNo **//
	if (type == MKAlertTypeYesNo) {
		self = (MKAlerts *)[[UIAlertView alloc] initWithTitle:@"Just Checking" message:message delegate:owner cancelButtonTitle:nil otherButtonTitles:nil];
		[self addButtonWithTitle:@"YES"];
		[self addButtonWithTitle:@"NO"];
	}
	
	//** MKAlertTypeTryAgain **//
	if (type == MKAlertTypeTryAgain) {
		self = (MKAlerts *)[[UIAlertView alloc] initWithTitle:@"Sorry" message:message delegate:owner cancelButtonTitle:nil otherButtonTitles:nil];
		[self addButtonWithTitle:@"Try Again"];
		[self addButtonWithTitle:@"Reset"];
	}
	
	return self;
}

#pragma mark -
#pragma mark memory managment

- (void)dealloc {
	[super dealloc];
}

@end
