//
//  MKMenuItem.h
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKControls/MKControl.h>

#define MK_MENU_VIEW_CANCEL_BUTTON             @"MKMenuView-Resources.bundle/CloseButton.png"
#define MK_MENU_VIEW_COPY_BUTTON               @"MKMenuView-Resources.bundle/CopyButton.png"

typedef enum {
    MKMenuItemTypeCancel,
    MKMenuItemTypeCopy,
} MKMenuItemType;

/**-------------------------------------------------------------------------------------------
 MKMenuItem is a special control that works with MKMenuView. MKMenuItems are designed to be placed
 on an instance of MKMenuView. They are given to an MKMenuView by creating an array of instances
 and passing to the menu with through the initWithItems: method.
 
 @warning *Note* MKMenuItem objects will look for resources in the MKMenuView-Resources bundle. 
 Ensure this bundle is added to your project for proper function.
--------------------------------------------------------------------------------------------*/

@interface MKMenuItem : MKControl {
    MKMenuItemType mType;

@private
    SEL mSelector;
    id mTarget;
}

///--------------------------------------------------
/// @name Creating Instances
///--------------------------------------------------

/**
 Returns an intalized instance of a predefined menu item. The avialible menu items are:
 
 * `MKMenuItemTypeCancel` : A round cancel button.
 * `MKMenuItemTypeCopy` : A round copy button.
 
 @param type the type of item to use.
 
 @param name the text that will be displayed directly under the button.
 
 @param target the object that will handle actions sent by the item.
 
 @param selector the selector to preform when the item is touched.
*/
- (id)initWithType:(MKMenuItemType)type title:(NSString *)name target:(id)target selector:(SEL)selector;

/**
 Returns an intalized instance with a custom view. The view is expected to be 60.0x80.0, It will be resized
 to meet this if needed.
 
 @param view the custom view.
  
 @param target the object that will handle actions sent by the item.
 
 @param selector the selector to preform when the item is touched.
 */
- (id)initWithCustomView:(UIView *)view target:(id)target selector:(SEL)selector;

///-----------------------------------------------------
/// @name Elements
///-----------------------------------------------------

/** The type of the item */
@property (nonatomic, assign, readonly) MKMenuItemType type;

@end
