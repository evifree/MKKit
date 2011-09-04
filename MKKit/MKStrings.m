//
//  MKStrings.m
//  MKKit
//
//  Created by Matthew King on 1/15/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKStrings.h"


@implementation MKStrings

#pragma mark --
#pragma mark Date Strings

- (NSString *)date:(NSDate *)date withFormat:(NSString *)format {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:format];
	
	NSString *rtn = [formatter stringFromDate:date];
	
	[formatter release];
	
	return rtn;
}

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:format];
	
	NSString *rtn = [formatter stringFromDate:date];
	
	[formatter release];
	[self autorelease];
    
	return rtn;
}

#pragma mark --
#pragma mark Number String

- (NSString *)localCurrencyFromNumber:(NSNumber *)number {
	NSString *aString = nil;
	
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:[NSLocale currentLocale]];
	aString = [numberFormatter stringFromNumber:number];
	
	[numberFormatter release];	
	
	return aString;
}

+ (NSString *)localCurrencyWithNumber:(NSNumber *)number {
    NSString *aString = nil;
	
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
	[numberFormatter setLocale:[NSLocale currentLocale]];
	aString = [numberFormatter stringFromNumber:number];
	
	[numberFormatter release];	
    [self autorelease];
	
	return aString;
}

- (NSString *)stringFromDecimalNumber:(NSDecimalNumber *)number decimalPlaces:(NSUInteger)places {
    NSString *aString = nil;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:places];
    [numberFormatter setMinimumFractionDigits:places];
    [numberFormatter setMinimumIntegerDigits:1];
    
    aString = [numberFormatter stringFromNumber:number];
    [numberFormatter release];
    
    return  aString;
}

+ (NSString *)stringWithDecimalNumber:(NSDecimalNumber *)number decimalPlaces:(NSUInteger)places {
    NSString *aString = nil;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setMaximumFractionDigits:places];
    [numberFormatter setMinimumFractionDigits:places];
    [numberFormatter setMinimumIntegerDigits:1];
    
    aString = [numberFormatter stringFromNumber:number];
    [numberFormatter release];
    
    [self autorelease];
    
    return  aString;
}

#pragma mark -
#pragma mark Path Strings

- (NSString *)documentsDirectoryPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [paths objectAtIndex:0];
}

#pragma mark -
#pragma mark Memory Managment

- (void)dealloc {
	[super dealloc];
}

@end
