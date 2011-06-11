//
//  MKTabBar.m
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MKTabBar.h"


@implementation MKTabBar

@synthesize delegate, items;

#pragma mark -
#pragma mark Start Up

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"tabBarItemBackground" ofType:@"png"];
		
		UIImage *background = [[UIImage alloc] initWithContentsOfFile:path];
		self.backgroundColor = [UIColor colorWithPatternImage:background];
		
		[background release];
		
		MKTabBarItem *item0 = [[MKTabBarItem alloc] initWithFrame:CGRectMake(0.0, 0.0, 64.0, 50.0)];
		MKTabBarItem *item1 = [[MKTabBarItem alloc] initWithFrame:CGRectMake(64.0, 0.0, 64.0, 50.0)];
		MKTabBarItem *item2 = [[MKTabBarItem alloc] initWithFrame:CGRectMake(128.0, 0.0, 64.0, 50.0)];
		MKTabBarItem *item3 = [[MKTabBarItem alloc] initWithFrame:CGRectMake(192.0, 0.0, 64.0, 50.0)];
		MKTabBarItem *item4 = [[MKTabBarItem alloc] initWithFrame:CGRectMake(256.0, 0.0, 64.0, 50.0)];
		
		[self addSubview:item0];
		[self addSubview:item1];
		[self addSubview:item2];
		[self addSubview:item3];
		[self addSubview:item4];
		
		items = [[NSArray alloc] initWithObjects:item0, item1, item2, item3, item4, nil];
		
		[item0 release];
		[item1 release];
		[item2 release];
		[item3 release];
		[item4 release];
    }
    return self;
}

#pragma mark -
#pragma mark Item SetUp

- (void)setIcon:(UIImage *)icon forIndex:(NSInteger)index {
	MKTabBarItem *item = (MKTabBarItem *)[items objectAtIndex:index];
	item.icon.image = icon;
}

- (void)highlightItem:(MKTabBarItem *)item atIndex:(NSInteger)index {
	item.label.textColor = [UIColor blueColor];
}

#pragma mark -
#pragma mark Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger index = [items indexOfObject:touch.view];
	
	[delegate touchedItemAtIndex:index];
}
 
#pragma mark -
#pragma mark Memory Managemet

- (void)dealloc {
    [super dealloc];
	
	[items release];
	[delegate release];
}


@end
