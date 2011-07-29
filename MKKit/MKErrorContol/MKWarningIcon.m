//
//  MKWarningIcon.m
//  MKKit
//
//  Created by Matthew King on 1/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKWarningIcon.h"


#pragma mark -
#pragma mark MKWarningIcon

@implementation MKWarningIcon

@synthesize error=_error;

#pragma mark Initalizer

- (id)initWithTextField:(MKTextField *)textField {
	self = [super init];
	if (self) {
		_textField = [textField retain];
		_error = [textField.error retain];
		
		self.userInteractionEnabled = YES;
        self.backgroundColor = CLEAR;
        self.opaque = NO;
		
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 5.0, 30.0, 25.0)];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = CLEAR;
        label.textColor = WHITE;
        label.shadowColor = RED;
        label.shadowOffset = CGSizeMake(0.0, -1.0);
        label.font = SYSTEM_BOLD(24.0);
        label.text = @"!";
        
        [self addSubview:label];
        [label release];
    }
	return self;
}

- (id)initWithError:(NSError *)anError {
	self = [super init];
	if (self) {
		_error = [anError retain];
        
		self.userInteractionEnabled = YES;
        self.backgroundColor = CLEAR;
        self.opaque = NO;
		
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 5.0, 30.0, 25.0)];
        label.textAlignment = UITextAlignmentCenter;
        label.backgroundColor = CLEAR;
        label.textColor = WHITE;
        label.shadowColor = RED;
        label.shadowOffset = CGSizeMake(0.0, -1.0);
        label.font = SYSTEM_BOLD(24.0);
        label.text = @"!";
        
        [self addSubview:label];
        [label release];

	}
	return self;
}

#pragma mark Drawing Methods

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGColorRef redColor = RED.CGColor;
    
    CGPoint p1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, redColor);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, redColor, redColor);
    CGContextSaveGState(context);
    
    CFRelease(path);
}

- (void)fitToRect:(CGRect)rect {
	self.frame = rect;
}

- (void)drawToRight {
	self.frame = CGRectMake(0.0, 0.0, _textField.frame.size.height, _textField.frame.size.height);
}

#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
	
	if (taps == 1) {
		MKErrorHandeling *handeler = [[MKErrorHandeling alloc] init];
		[handeler applicationDidError:_error];
		[handeler release];
	}
}

#pragma mark Memory Managment

- (void)dealloc {
	[_textField release];
	[_error release];
	
	[super dealloc];
}

@end
