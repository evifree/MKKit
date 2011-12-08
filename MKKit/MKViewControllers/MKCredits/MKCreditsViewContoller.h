//
//  MKCreditsViewContoller.h
//  MKKit
//
//  Created by Matthew King on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MKKit/MKKit/MKViews/MKViewHeader.h>
#import <MKKit/MKKit/MKErrorContol/MKErrorHandeling.h>

//@class MKCreditsFooterView;

/**-------------------------------------------------------------------------------------------------------------
 The MKCreditsViewController class provides a view controller for displaying credits for the app. This class
 expects a .plist file titled `CreditNames`. This file should costist of an Array of NSDictionary objects.
 MKCreditsViewController looks for for two keys, `Title` and `Credit`.
 ---------------------------------------------------------------------------------------------------------------*/

MK_DEPRECATED_0_9 @interface MKCreditsViewContoller : UITableViewController <MKViewDelegate, MFMailComposeViewControllerDelegate> {
	//MKCreditsFooterView *_footerView;
	NSString *_activeTitle;
	NSMutableArray *_creditsArray;
	
	@private
		NSInteger selectedTopic;
}

///----------------------------------------------------------
/// @name Components
///----------------------------------------------------------

/**The footer view of the controllers TableView*/
//@property (nonatomic, retain) MKCreditsFooterView *footerView;

/**The title of the credit that is currenty being displayed*/
@property (nonatomic, retain) NSString *activeTitle;

/**The array containing the credits dictionary*/
@property (nonatomic, copy) NSMutableArray *creditsArray;

/**Title displayed on the Pop View*/
@property (nonatomic, copy) NSString *popViewTitle;

///------------------------------------------------------------
/// @name Instance Methods
///------------------------------------------------------------

/** Returns an UIButton with specified Title. This method should not be called directly.
 
 @param buttonTitle the text to be displayed on the button
*/
- (UIButton *)buttonTitled:(NSString *)buttonTitle;

@end

//---------------------------------------------------------------------------------------------------------------
//MKCreditsFooterView

/**--------------------------------------------------------------------------------------------------------------
 MKCreditsFooterView provides the footerView for the MKCreditsViewContoller class. You should not need to use
 this directly.
---------------------------------------------------------------------------------------------------------------*/

MK_DEPRECATED_0_9 @interface MKCreditsFooterView : UIView {
	UILabel *_titleLabel;
	UITextView *_descriptionText;
	UIButton *_actionButton;
}

///-----------------------------------------------------------
/// @name Components
///-----------------------------------------------------------

/** The UILable object that displayes the credits title*/
@property (nonatomic, retain) UILabel *titleLabel;

/** The UITextView that displayes the description of the credit*/
@property (nonatomic, retain) UITextView *descriptionText;

/** The UIButton that used to send an email. `Optional`*/
@property (nonatomic, retain) UIButton *actionButton;

///-----------------------------------------------------------
/// @name Instance Methods
///-----------------------------------------------------------

/** Removes the UIButton if one is present*/
- (void)removeButton;

@end
