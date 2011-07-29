//
//  MKValidator.m
//  MKKit
//
//  Created by Matthew King on 1/10/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKValidator.h"

@implementation MKValidator

@synthesize stringLength;

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

- (BOOL)inputIsaSetLength:(NSString *)text {
    if (stringLength == 0) {
        NSException *exception = [NSException exceptionWithName:@"Invalid stringLength property" reason:@"The stringLength property cannot be nil or zero" userInfo:nil];
        [exception raise];
    }
    
    BOOL validated = NO;
    
    if ([text length] == self.stringLength) {
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
