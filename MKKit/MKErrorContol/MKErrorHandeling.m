//
//  MKErrorHandeling.m
//  MKKit
//
//  Created by Matthew King on 1/15/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKErrorHandeling.h"


@implementation MKErrorHandeling

- (void)applicationDidError:(NSError *)error {
	NSString *details = [error localizedDescription];
    
    [MKPromptView promptWithType:MKPromptTypeAmber title:@"Error" message:details duration:5.0];
}

+ (void)applicationDidError:(NSError *)error {
    NSString *details = [error localizedDescription];
    
    [MKPromptView promptWithType:MKPromptTypeAmber title:@"Error" message:details duration:5.0];
    
    [self autorelease];
}

- (void)dealloc {
	[super dealloc];
	
}

@end
