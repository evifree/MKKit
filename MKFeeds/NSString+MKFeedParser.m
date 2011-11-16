//
//  NSString+MKFeedParser_NSString.m
//  MKKit
//
//  Created by Matthew King on 11/13/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import "NSString+MKFeedParser.h"

@implementation NSString (MKFeedParser_NSString)

- (NSString *)stringByRemovingNewLinesAndWhitespace {
    
	// Pool
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	// Strange New lines:
	//	Next Line, U+0085
	//	Form Feed, U+000C
	//	Line Separator, U+2028
	//	Paragraph Separator, U+2029
    
	// Scanner
	NSScanner *scanner = [[NSScanner alloc] initWithString:self];
	[scanner setCharactersToBeSkipped:nil];
	NSMutableString *result = [[NSMutableString alloc] init];
	NSString *temp;
	NSCharacterSet *newLineAndWhitespaceCharacters = [NSCharacterSet characterSetWithCharactersInString:
													  [NSString stringWithFormat:@" \t\n\r%C%C%C%C", 0x0085, 0x000C, 0x2028, 0x2029]];
	// Scan
	while (![scanner isAtEnd]) {
        
		// Get non new line or whitespace characters
		temp = nil;
		[scanner scanUpToCharactersFromSet:newLineAndWhitespaceCharacters intoString:&temp];
		if (temp) [result appendString:temp];
        
		// Replace with a space
		if ([scanner scanCharactersFromSet:newLineAndWhitespaceCharacters intoString:NULL]) {
			if (result.length > 0 && ![scanner isAtEnd]) // Dont append space to beginning or end of result
				[result appendString:@" "];
		}
        
	}
    
	// Cleanup
	[scanner release];
    
	// Return
	NSString *retString = [[NSString stringWithString:result] retain];
	[result release];
    
	// Drain
	[pool drain];
    
	// Return
	return [retString autorelease];
    
}


@end
