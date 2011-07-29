//
//  MKMenuItem.h
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <MKKit/MKKit/MKControls/MKControl.h>

typedef enum {
    MKMenuItemTypeCancel,
    MKMenuItemTypeCopy,
    MKMenuItemTypeDelete,
    MKMenuItemTypeCustomImage,
} MKMenuItemType;

/**-------------------------------------------------------------------------------------------
 MKMenuItem is a special control that works with MKMenuView. MKMenuItems are designed to be placed
 on an instance of MKMenuView. They are given to an MKMenuView by creating an array of instances
 and passing to the menu with through the initWithItems: method.
 
 There are four built-in types of MKMenuItems:
 
 * `MKMenuItemTypeCancel` : A round cancel button.
 * `MKMenuItemTypeCopy` : A round copy button.
 * `MKMenuItemTypeDelete` : A round delete button, colored red.
 * `MKMenuItemTypeCustomImage` : A round button with image drawn onto it.
 
 @warning *Note* If you want to have your own image added to a button use the initWithImage:title:target:selector:
 method insteade of initWithType:title:Target:selector:.
--------------------------------------------------------------------------------------------*/

@interface MKMenuItem : MKControl {
    MKMenuItemType mType;

@private
    UIImage *mImage;
    SEL mSelector;
    id mTarget;
}

///--------------------------------------------------
/// @name Creating Instances
///--------------------------------------------------

/**
 Returns an intalized instance of a predefined menu item.
 
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

/**
 Returns an intalized intance of the standard black button with an image on it. The image needs to be a 40x40,
 and only black and transpent in color. The MKMenuItem class will handle the coloring of the image.
 
 @param image the image to be displayed on the icon.
 
 @param name the text that will be displayed directly under the button.
 
 @param target the object that will handle actions sent by the item.
 
 @param selector the selector to preform when the item is touched.
 
 @return MKMenuItem instance.
*/
- (id)initWithImage:(UIImage *)image title:(NSString *)name target:(id)target selector:(SEL)selector;

///-----------------------------------------------------
/// @name Elements
///-----------------------------------------------------

/** The type of the item */
@property (nonatomic, assign, readonly) MKMenuItemType type;

@end
