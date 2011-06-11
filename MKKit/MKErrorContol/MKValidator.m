//
//  MKValidator.m
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MKValidator.h"

@implementation MKValidator

- (BOOL)inputIsaNumber:(NSString *)text {
	BOOL validated = NO;
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		
	NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:text];
	NSString *symbol = [formatter stringFromNumber:number];
	
	[formatter release];
	
	if (![symbol isEqualToString:@"NaN"]) {
		validated = YES;
	}
	
	return validated;
}

- (BOOL)inputHasLength:(NSString *)text {
	if ([text length] != 0) {
		return YES;
	}
	return NO;
}

@end
