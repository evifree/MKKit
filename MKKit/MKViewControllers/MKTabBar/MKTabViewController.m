    //
//  MKTabViewController.m
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTabViewController.h"


@implementation MKTabViewController

//@synthesize tabBar=_tabBar, displayView=_displayView, viewControllers, activeView, mainViewController;

/*
#pragma mark -
#pragma mark Initalizers

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super init];
	if (self) {
		mainViewController = (UIViewController *)[rootViewController retain];
	}
	return self;
}

- (id)initWithViewControllers:(NSArray *)controllers {
    self = [super init];
	if (self) {
		viewControllers = [controllers copy];
	}
	return self;
}

- (void)setViewControllers {
	
}

#pragma mark -
#pragma mark View Life Cycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	UIView *rootView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0)];
	self.view = rootView;
	
	_tabBar = [[[MKTabBar alloc] initWithFrame:CGRectMake(0.0, 430.0, 320.0, 50.0)] retain];
	_tabBar.delegate = self;
	
	_displayView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 430.0)] retain];
	
    [rootView addSubview:_displayView];
	[rootView addSubview:_tabBar];
    
	[_tabBar release];
	[_displayView release];
	
	[_tabBar release];
	[rootView release];		
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self.mainViewController viewWillAppear:NO];
	[self.displayView addSubview:mainViewController.view];
	self.activeView = 0;
	
	MKTabBarItem *activeItem = (MKTabBarItem *)[self.tabBar.items objectAtIndex:0];
	activeItem.glow.alpha = 1.0;
}

#pragma mark -
#pragma mark Tabbar Setup

- (void)setItemTitles {
	int count = [viewControllers count];
	int i = 0;
	
	while (i < count) {
		UIViewController *viewController = (UIViewController *)[viewControllers objectAtIndex:i];
		
		MKTabBarItem *item = [self.tabBar.items objectAtIndex:i];
		item.label.text = viewController.title;	
		
		i++;
	}

}

- (void)setItemIcons:(NSArray *)icons {
	int count = [icons count];
	int i = 0;
	
	while (i < count) {
		UIImage *icon = (UIImage *)[icons objectAtIndex:i];
		[self.tabBar setIcon:icon forIndex:i];
		
		i++;
	}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 
#pragma mark -
#pragma mark Delegates

#pragma mark TabBar

- (void)touchedItemAtIndex:(NSInteger)index {
	MKTabBarItem *item = (MKTabBarItem *)[self.tabBar.items objectAtIndex:index];
	item.glow.alpha = 1.0;
	
	MKTabBarItem *activeItem = (MKTabBarItem *)[self.tabBar.items objectAtIndex:activeView];
	activeItem.glow.alpha = 0.0;
	
	UIViewController *activeViewController = (UIViewController *)[viewControllers objectAtIndex:activeView];
	UIViewController *selectedController = (UIViewController *)[viewControllers objectAtIndex:index];
	
	[selectedController viewWillAppear:NO];
	
	[self.displayView addSubview:selectedController.view];
	
	[selectedController viewDidAppear:NO];
	[activeViewController viewDidDisappear:NO];
	
	if (activeViewController != selectedController) {
		[activeViewController.view removeFromSuperview];
	}
	
	self.activeView = index;
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];

	[mainViewController release];
	[viewControllers release];
}
*/

@end
