//
//  MKTabBar.h
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKTabBarItem.h"

@protocol MKTabBarDelegate;

@interface MKTabBar : UIView {
	id delegate;
	NSArray *items;
}

@property (nonatomic, retain) id<MKTabBarDelegate> delegate;
@property (nonatomic, retain) NSArray *items;

//** Sets the item icon on the TabBar
- (void)setIcon:(UIImage *)icon forIndex:(NSInteger)index;

- (void)highlightItem:(MKTabBarItem *)item atIndex:(NSInteger)index;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////////
///***                              MKTabBarDelegate                                             ***///

@protocol MKTabBarDelegate <NSObject>

//** REQUIRED **//

//** Called when the user touches one of the TabBar items
- (void)touchedItemAtIndex:(NSInteger)index;

@end
