//
//  MKTabBarItem.h
//  MKKit
//
//  Created by Matthew King on 7/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKMacros.h>

MK_DEPRECATED_0_9 @interface MKTabBarItem : UIView {
	UIImageView *_icon;
	UIImageView *_glow;
	UILabel *_label;
}
/*
@property (nonatomic, retain) UIImageView *icon;
@property (nonatomic, retain) UIImageView *glow;
@property (nonatomic, retain) UILabel *label;
*/
@end
