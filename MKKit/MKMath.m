//
//  MKMath.m
//  MKKit
//
//  Created by Matthew King on 2/7/10.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import "MKMath.h"

@implementation MKMath

#pragma mark - Sums

- (NSDecimalNumber *)sumOfArray:(NSArray *)anArray {
	NSInteger count = [anArray count];
	NSDecimalNumber *total = [NSDecimalNumber zero];
	
	for (int i = 0; i < count; i++) {
		NSDecimalNumber *next = [anArray objectAtIndex:i];
		total = [total decimalNumberByAdding:next];
	}
	
	return total;
}

+ (NSDecimalNumber *)sumFromArray:(NSArray *)array {
    MKMath *math = [[[[self class] alloc] init] autorelease];
    return [math sumOfArray:array];
}

#pragma mark - Averages

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

+ (NSDecimalNumber *)averageFromArray:(NSArray *)array {
    MKMath *math = [[[[self class] alloc] init] autorelease];
    return [math averageOfArray:array];
}

#pragma mark - Memory

- (void)dealloc {
    [super dealloc];
}

@end
