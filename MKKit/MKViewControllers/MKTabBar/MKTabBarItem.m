//
//  MKTabBarItem.m
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKTabBarItem.h"


@implementation MKTabBarItem

@synthesize icon=_icon, label=_label, glow=_glow;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		_icon = [[[UIImageView alloc] initWithFrame:CGRectMake(20.0, 11.0, 25.0, 25.0)] retain];
		
		_label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 35.0, 64.0, 15.0)] retain];
		_label.textAlignment = UITextAlignmentCenter;
		_label.minimumFontSize = 6.0;
		_label.font = [UIFont fontWithName:@"Verdana-Bold" size:10.0];
		_label.textColor = [UIColor whiteColor];
		_label.backgroundColor = [UIColor clearColor];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"tabBarGlow" ofType:@"png"];
		UIImage *glowImage = [[UIImage alloc] initWithContentsOfFile:path];
		
		_glow = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 64.0, 50.0)];
		_glow.image = glowImage;
		_glow.alpha = 0.0;
        
        [glowImage release];
		
		[self addSubview:_glow];
		[self addSubview:_icon];
		[self addSubview:_label];
		
		[_icon release];
		[_label release];
		[_glow release];
	}
    return self;
}

- (void)dealloc {
    [super dealloc];
	
}

@end
