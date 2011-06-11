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
	NSInteger start = 0;
	NSDecimalNumber *total = [NSDecimalNumber zero];
	
	for (start; start < count; start++) {
		NSDecimalNumber *next = [anArray objectAtIndex:start];
		total = [total decimalNumberByAdding:next];
	}
	
	return total;
}

- (NSDecimalNumber *)averageOfArray:(NSArray *)anArray {
	NSInteger count = [anArray count];
	NSInteger start = 0;
	NSDecimalNumber *sum = [NSDecimalNumber zero];
	
	for (start; start < count; start++) {
		NSDecimalNumber *next = [anArray objectAtIndex:start];
		sum = [sum decimalNumberByAdding:next];
	}
	
	NSDecimalNumber *divideBy = [[NSDecimalNumber alloc] initWithInteger:count];
	NSDecimalNumber *returnValue = [sum decimalNumberByDividingBy:divideBy];
	
	[divideBy release];
	
	return returnValue;
}

@end
