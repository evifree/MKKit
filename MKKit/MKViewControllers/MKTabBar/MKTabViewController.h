//
//  MKTabViewController.h
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKTabBar.h"

@class MKTabBar;

@interface MKTabViewController : UIViewController <MKTabBarDelegate> {
	MKTabBar *_tabBar;
	UIView *_displayView;
	NSArray *viewControllers;
	
	UIViewController *mainViewController;
}

@property (nonatomic, retain) MKTabBar *tabBar;
@property (nonatomic, retain) UIView *displayView;
@property (nonatomic, copy) NSArray *viewControllers;
@property (nonatomic, assign) NSInteger activeView;

@property (nonatomic, retain) UIViewController *mainViewController;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (id)initWithViewControllers:(NSArray *)controllers;

- (void)setViewControllers;
- (void)setItemTitles;
- (void)setItemIcons:(NSArray *)icons;

@end
