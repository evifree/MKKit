//
//  MKViewLoading.m
//  MKKit
//
//  Created by Matthew King on 7/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKLoadingView.h"

@implementation MKLoadingView

@synthesize statusLabel=_statusLabel;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		self.alpha = 0.0;
		
		UIView *background = [[UIView alloc] initWithFrame:self.bounds];
		background.backgroundColor = [UIColor grayColor];
		background.alpha = 0.50;
		
		[self addSubview:background];
		
		UIView *dark = [[UIView alloc] initWithFrame:CGRectMake(20.0, 183.0, 280.0, 97.0)];
		dark.backgroundColor = [UIColor grayColor];
		
		[self addSubview:dark];
				
		UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(124.0, 18.0, 37.0, 37.0)];
		activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		[activityIndicator startAnimating];
		
		_statusLabel= [[UILabel alloc] initWithFrame:CGRectMake(20.0, 63.0, 245.0, 22.0)];
		_statusLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:17.0];
		_statusLabel.textColor = [UIColor whiteColor];
		_statusLabel.backgroundColor = [UIColor clearColor];
		_statusLabel.textAlignment = UITextAlignmentCenter;
		
		[dark addSubview:activityIndicator];
		[dark addSubview:_statusLabel];
		
		[activityIndicator release];
		[_statusLabel release];
		
		[dark release];
		[background release];
    }
    return self;
}

- (void)show {
	[[[UIApplication sharedApplication] keyWindow] addSubview:self];
	
	[UIView animateWithDuration:0.25 
					 animations: ^ { self.alpha = 1.0; }
					 completion: ^ (BOOL finished) { [self completedAnimation]; }];
}

- (void)removeLoadingView {
	[UIView animateWithDuration:0.25 
					 animations: ^ { self.alpha = 0.0; }
					 completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
}

- (void)completedAnimation {
	if ([self.delegate respondsToSelector:@selector(MKViewDidAppear:)]) {
		[self.delegate MKViewDidAppear:self];
	}
}

- (void)dealloc {
    [super dealloc];
}


@end
