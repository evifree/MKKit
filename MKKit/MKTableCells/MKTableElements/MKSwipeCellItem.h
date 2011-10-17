//
//  MKSwipeCellItem.h
//  MKKit
//
//  Created by Matthew King on 9/10/11.
//  Copyright (c) 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKControls/MKControl.h>
#import <MKKit/MKKit/MKViews/MKView.h>

typedef enum {
    MKSwipeCellItemNone,
    MKSwipeCellItemDelete,
} MKSwipeCellItemStyle;

/**-------------------------------------------------------------
 MKSwipeCellItems provides control items for MKSwipeCellView. A
 MKSwipeCellItems has a 30x30 icon with a sigle label underneath 
 it. 
 
 MKSwipeCellItems has premade items that can be set with an image
 being provided.
 
 * `MKSwipeCellItemDelete` : A circle with an "X" on the inside.
--------------------------------------------------------------*/
@interface MKSwipeCellItem : MKControl {
@private
    MKSwipeCellItemStyle mStyle;
}

///--------------------------
/// @name Creating
///--------------------------

/**
 Returns an instance of MKSwipeCellItem.
 
 @param style the style of one of the premade items.
 
 @param title the text to be displayed under the icon.
 
 @param action the action block to perform when the item
 is touched
 
 @return MKSwipeCellItem instance
*/
- (id)initWithStyle:(MKSwipeCellItemStyle)style title:(NSString *)title action:(MKActionBlock)actionBlock;

/**
 Returns an instace of MKSwipeCellItem.
 
 @param image the image to be displayed for the icon part
 of the item.  The image provied should be a mask, only
 black and transparent colors. 
 
 @param title the text to be displayed under the icon.
 
 @param action the action block to perform when the item is touched.
*/
- (id)initWithImage:(UIImage *)image title:(NSString *)title action:(MKActionBlock)actionBlock;

@end

@interface MKSwipeCellItemMask : MKView {
@private
    UIImage *mImage;
}

- (id)initWithImage:(UIImage *)image;

@end