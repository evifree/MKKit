//
//  MKMath.m
//  MKKit
//
//  Created by Matthew King on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKMath.h"

@implementation MKMath

- (NSDecimalNumber *)sumOfArray:(NSArray *)anArray {
	NSInteger count = [anArray count];
	NSDecimalNumber *total = [NSDecimalNumber zero];
	
	for (int i = 0; i < count; i++) {
		NSDecimalNumber *next = [anArray objectAtIndex:i];
		total = [total decimalNumberByAdding:next];
	}
	
	return total;
}

- (NSDecimalNumber *)averageOfArray:(NSArray *)anArray {
	NSInteger count = [anArray count];
	NSDecimalNumber *sum = [NSDecimalNumber zero];
	
	for (int i = 0; i < count; i++) {
		NSDecimalNumber *next = [anArray objectAtIndex:i];
		sum = [sum decimalNumberByAdding:next];
	}
	
	NSDecimalNumber *divideBy = [[NSDecimalNumber alloc] initWithInteger:count];
	NSDecimalNumber *returnValue = [sum decimalNumberByDividingBy:divideBy];
	
	[divideBy release];
	
	return returnValue;
}

@end
