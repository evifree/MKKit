//
//  MKRandoms.m
//  MKKit
//
//  Created by Matthew King on 1/17/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKRandoms.h"

@implementation MKRandoms

- (id)randomFromArray:(NSArray *)anArray repeat:(BOOL)repeat {
	id obj = nil;
	
	NSDate *aDate = [[NSDate alloc] init];
	srandom([aDate timeIntervalSince1970]);
	[aDate release];
	
	if (repeat == YES) {
		NSInteger count = [anArray count];
	
		NSUInteger randomView = (random() % count);
		obj = [anArray objectAtIndex:randomView];
	}
	
	return obj;	
}


- (NSArray *)randomArrayWithArray:(NSArray *)anArray {		
	NSMutableArray *returnArray = [NSMutableArray arrayWithCapacity:[anArray count]];
	
	NSDate *aDate = [[NSDate alloc] init];
	srand([aDate timeIntervalSince1970]);
	[aDate release];
	
	NSInteger count = [anArray count];
	int i = 0;
	
	while(i < count) {
		NSUInteger randomView = (random() % count);
		id obj = [anArray objectAtIndex:randomView];
		[returnArray addObject:obj];
		i++;
	}
	
	NSArray *theArray = [NSArray arrayWithArray:returnArray];
	
	return theArray;
}

- (int)randomNumberOutOf:(int)number {	
	NSDate *aDate = [[NSDate alloc] init];
	srandom([aDate timeIntervalSince1970]);
	[aDate release];
		
	int randomInt = (random() % number);
	
	return randomInt;
}

@end
