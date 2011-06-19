//
//  MKTableCellBadge.h
//  MKKit
//
//  Created by Matthew King on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MKKit/MKKit/MKTableCells/MKTableCell.h>

/**---------------------------------------------------------------------------------
 MKTableCellBadge class creates a table cell with Lable and a badge on the right side
 of the cell. Badges are round rects that can be colored and text placed in them. 
 
 Badges will automatically size themselfs to fit the text.
----------------------------------------------------------------------------------*/

@interface MKTableCellBadge : MKTableCell {
    NSString *mBadgeText;
    UIColor *mBadgeColor;
    
@private
    UILabel *mBadgeLabel;
}

///----------------------------------------------------
/// @name Elements
///----------------------------------------------------

/** The text that will be displayed on the badge */
@property (nonatomic, copy) NSString *badgeText;

/** The color of the badge */
@property (nonatomic, retain) UIColor *badgeColor;

@end
