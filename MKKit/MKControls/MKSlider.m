//
//  MKSlider.m
//  MKKit
//
//  Created by Matthew King on 9/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKSlider.h"


@implementation MKSlider

@synthesize delegate, puck=_puck, descriptionLabel=_descriptionLabel, puckView=_puckView;

#pragma mark -
#pragma mark Initalization

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		CGRect shadowRect = CGRectMake(0.0, 0.0, 228.0, 40.0);
		CGRect puckRect = CGRectMake(3.0, 3.0, 48.0, 34.0);
		CGRect descriptionRect = CGRectMake(57.0, 4.0, 151.0, 33.0);
		
		self.backgroundColor = [UIColor clearColor];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"sliderShadow" ofType:@"png"];
		UIImage *shadowImage = [[UIImage alloc] initWithContentsOfFile:path];
		
		UIImageView *bg = [[UIImageView alloc] initWithFrame:shadowRect];
		bg.image = shadowImage;
		
		[self addSubview:bg];
		[bg release];
		[shadowImage release];
		
		_descriptionLabel = [[UILabel alloc] initWithFrame:descriptionRect];
		_descriptionLabel.textAlignment = UITextAlignmentCenter;
		_descriptionLabel.backgroundColor = [UIColor clearColor];
		_descriptionLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:22.0];
		_descriptionLabel.textColor = [UIColor lightGrayColor];
		
		[self addSubview:_descriptionLabel];
		[_descriptionLabel release];
	
		_puckView = [[UIImageView alloc] initWithFrame:puckRect];
		_puckView.userInteractionEnabled = YES;
		
		[self addSubview:_puckView];
		[_puckView release];		
	}
	return self;
}

#pragma mark -
#pragma mark Accessor Methods

- (void)setPuck:(UIImage *)image {
	_puck = [image retain];
	self.puckView.image = _puck;
	
	[_puck release];
}

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];

	if ([touch view] == self.puckView) {
		
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	
	if ([touch view] == self.puckView) {
		CGPoint touchPoint = [touch locationInView:self];
		CGPoint newCenter = CGPointMake(touchPoint.x, 20);
		if (newCenter.x > 26.0 && newCenter.x < 205) {
			self.puckView.center = newCenter;
		}
		float percentage = (1 - (touchPoint.x / 114.0));
		self.descriptionLabel.alpha = percentage;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	
	if ([touch view] == self.puckView) {
		CGPoint puckLocation = self.puckView.center;
		if (puckLocation.x > 180) {
			[[UIDevice currentDevice] playInputClick];
			if ([delegate respondsToSelector:@selector(didCompleteAction:)]) {
				[delegate didCompleteAction:self];
			}
		}
		else {
			[UIView animateWithDuration:0.2 
							 animations:^ { self.puckView.center = CGPointMake(24.0, 20.0); }
							 completion:^ (BOOL finished) { self.descriptionLabel.alpha = 1.0; }];
			
		}
	}
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
	[super dealloc];
}

@end
