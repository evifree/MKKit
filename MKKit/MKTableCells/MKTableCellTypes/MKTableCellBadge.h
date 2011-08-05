//
//  MKTableCellBadge.h
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>
#import <MKKit/MKKit/MKViews/MKViewHeader.h>
#import <MKKit/MKKit/MKGraphics/MKGraphics.h>

@class MKBadgeCellView;

/**---------------------------------------------------------------------------------
 MKTableCellBadge class creates a table cell with Lable and a badge on the right side
 of the cell. Badges are round rects that can be colored and text placed in them. 
 
 Badges will automatically size themselfs to fit the text.
----------------------------------------------------------------------------------*/

@interface MKTableCellBadge : MKTableCell {
@private
    MKBadgeCellView *mBadgeCellView;
}

///----------------------------------------------------
/// @name Elements
///----------------------------------------------------

/** The text that will be displayed on the badge */
@property (nonatomic, assign) NSString *badgeText;

/** The color of the badge */
@property (nonatomic, assign) UIColor *badgeColor;

@end



@interface MKBadgeCellView : MKView {
@private
    UILabel *mBadgeLabel;
    CGColorRef mBadgeColor;
}

@property (nonatomic, copy) NSString *badgeText;

@property (nonatomic, retain) UIColor *badgeColor;

@end
