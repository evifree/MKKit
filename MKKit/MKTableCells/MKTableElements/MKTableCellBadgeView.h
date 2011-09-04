
//  MKTableCellBadge.h
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKViews/MKView.h>

/**--------------------------------------------------------------
 Draws a small bagde that is added to a MKTableCell instance.
---------------------------------------------------------------*/
@interface MKTableCellBadgeView : MKView {
@private
    UILabel *mBadgeLabel;
    CGColorRef mBadgeColor;
}

///---------------------------------------
/// @name Elements
///---------------------------------------

/** The text that will be displayed on the badge */
@property (nonatomic, copy) NSString *badgeText;

/** The color of the badge, default is light gray */
@property (nonatomic, retain) UIColor *badgeColor;

@end
