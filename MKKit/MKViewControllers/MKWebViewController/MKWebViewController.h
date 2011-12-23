//
//  MKWebViewController.h
//  MKKit
//
//  Created by Matthew King on 3/30/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKViewControllers/MKViewController.h>
#import <MKKit/MKKit/MKControls/MKContolHeaders.h>
#import <MKKit/MKKit/MKViews/MKView.h>
#import <MKKit/MKKit/MKMacros.h>

/**------------------------------------------------------------------------------------------
 MKWebViewController creates a view controller with a built in UIWebView. 
 
 MKWebViewController calls the following delegate methods:
 
 * `viewControllerIsDone:` called when the done button is tapped.
 * `viewControllerAction:` called when the action button is tapped.
-------------------------------------------------------------------------------------------*/

@interface MKWebViewController : MKViewController {
@private
    NSURLRequest *mURLRequest;
}

///-------------------------------------------------
/// @name Initalizer
///-------------------------------------------------

/** Returns an initalized instance of MKWebViewController.
 
 @param url the URL that should be displayed. Pass the complete url as a NSString object. The 
 view controller will convert it to a usable URL.
*/
- (id)initWithURLString:(NSString *)url;

@end

//---------------------------------------------------------------------------------------------
// MKWebView

@class MKWebViewLoadingBar;

/**--------------------------------------------------------------------------------------------
 The MKWebView class creates the view for an MKWebViewController. Functionality of the class is 
 limited to the needs of the MKWebViewController class. You should not need to use this class 
 directly.
 --------------------------------------------------------------------------------------------*/

@interface MKWebView : MKView <UIWebViewDelegate> {
@public
    MKWebViewLoadingBar *mLoadingBar;
    UIWebView *mWebView;
    UIToolbar *bottomBar;
    
    MKBarButtonItem *backItem;
    MKBarButtonItem *forwardItem;
    
@private 
    struct {
        int pageCount;
        int backPageCount;
    } MKWebViewFlags;
}

///-----------------------------------------------
/// @name Web View Controll
///-----------------------------------------------

/** Loads the requested URL into the web view.
 
 @param request the NSURLRequest to be loaded by the web view.
 */
- (void)loadRequest:(NSURLRequest *)request;

@end

//--------------------------------------------------------------------------------------------
//MKWebViewLoadingBar

/**-------------------------------------------------------------------------------------------
 The MKWebViewLoadingBar class creates the top bar for the MKWebViewController. This class is
 designed specificlly to work with the MKWebViewController object. You should not need to use
 this class directly.
 --------------------------------------------------------------------------------------------*/

@interface MKWebViewLoadingBar : MKView {
    UIActivityIndicatorView *mActivityView;
    UILabel *mTitleLabel;
}

///------------------------------------------------
/// @name Display Elements
///------------------------------------------------

/** The UIActivityIndicatorView located in the web Bar */
@property (nonatomic, retain) UIActivityIndicatorView *activityView;

/** The UILabel that displays the URL of the displayed site */
@property (nonatomic, retain) UILabel *titleLabel;

@end