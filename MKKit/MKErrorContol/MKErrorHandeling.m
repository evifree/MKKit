//
//  MKErrorHandeling.m
//  MKKit
//
//  Created by Matthew King on 1/15/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKErrorHandeling.h"


@implementation MKErrorHandeling

- (void)applicationDidError:(NSError *)error {
	NSString *details = [error localizedDescription];
    
    [MKPromptView promptWithType:MKPromptTypeAmber title:@"Error" message:details duration:5.0];
    
	//UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:details delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	//[errorAlert show];
	//[errorAlert release];
}

- (void)dealloc {
	[super dealloc];
	
}

@end
