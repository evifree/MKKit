//
//  MKWebViewController.m
//  MKKit
//
//  Created by Matthew King on 3/30/11.
//  Copyright 2010-2011 Matt King. All rights reserved.
//

#import <MKKit/MKKit/MKErrorContol/MKErrorHandeling.h>
#import "MKWebViewController.h"

@implementation MKWebViewController

#pragma mark - Initalizer

- (id)initWithURLString:(NSString *)url {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSURL *aUrl = [NSURL URLWithString:url];
        
        if (![aUrl scheme]) {
            NSString *newURL = [[NSString alloc] initWithFormat:@"http://%@", url];
            mURLRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:newURL]];
            
            [newURL release];
        }
        else {
            mURLRequest = [[NSURLRequest alloc] initWithURL:aUrl];
        }
        
        self.view.autoresizesSubviews = YES;
    }
    return self;
}

#pragma mark - View Life Cycle

- (void)loadView {
    CGRect frame;
    
    if ([[UIApplication sharedApplication] isStatusBarHidden]) {
        frame = IPHONE_FRAME_WITH_STATUS_BAR;
    }
    else {
        frame = IPHONE_FRAME_WITHOUT_STATUS_BAR;
    }
    
    MKWebView *webView = [[MKWebView alloc] initWithFrame:frame];
    webView.controller = self;
    [webView loadRequest:mURLRequest];
    self.view = webView;
    
    [webView release];
    [mURLRequest release];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    MKWebView *webView = (MKWebView *)[self view];
    
    [webView->bottomBar removeFromSuperview];
    
    [self.view removeFromSuperview];
    self.view = nil;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - actions

- (void)done:(id)sender {
    [super done:self];
}

- (void)action:(id)sender {
    [super action:self];
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

//-----------------------------------------------------------------------------------------------
//MKWebView

@interface MKWebView ()

- (void)reload:(id)sender;
- (void)back:(id)sender;
- (void)forward:(id)sender;

@end

@implementation MKWebView

#pragma - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 1.0;
        self.autoresizesSubviews = YES;
        
        mWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0, 34.0, self.frame.size.width, (self.frame.size.height - (34.0 * 2)))];
        mWebView.delegate = self;
        mWebView.scalesPageToFit = YES;
        mWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:mWebView];
        [mWebView release];
        
        UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        //Top Bar
        
        mLoadingBar = [[MKWebViewLoadingBar alloc] initWithFrame:CGRectMake(0.0, 0.0, (self.frame.size.width - 20.0), 25.0)];
        
        UIBarButtonItem *loadingBarItem = [[UIBarButtonItem alloc] initWithCustomView:mLoadingBar];
        
        [mLoadingBar release];
        
        NSArray *topBarItems = [NSArray arrayWithObjects:space, loadingBarItem, space, nil];
        
        [loadingBarItem release];
        
        UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, 34.0)];
        topBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        topBar.tintColor = [UIColor grayColor];
        [topBar setItems:topBarItems];
        
        [self addSubview:topBar];
        [topBar release];
        
        backItem = [[MKBarButtonItem alloc] initWithType:MKBarButtonItemBackArrow graphicNamed:nil];
        backItem.controlState = MKControlStateDisabled;
        [backItem completedAction: ^ (MKAction action) {
            if (action == MKActionTouchUp) {
                [self back:backItem];
            }
        }];
        
        forwardItem = [[MKBarButtonItem alloc] initWithType:MKBarButtonItemForwardArrow graphicNamed:nil];
        forwardItem.controlState = MKControlStateDisabled;
        [forwardItem completedAction: ^ (MKAction action) {
            if (action == MKActionTouchUp) {
                [self forward:forwardItem];
            }
        }];
        
        //Bottom Bar
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.controller action:@selector(done:)];
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:backItem];
        UIBarButtonItem *forward = [[UIBarButtonItem alloc] initWithCustomView:forwardItem];
        UIBarButtonItem *reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
        UIBarButtonItem *action = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.controller action:@selector(action:)];
        
        [backItem release];
        [forwardItem release];
        
        NSArray *items = [NSArray arrayWithObjects:back, space, forward, space, reload, space, action, space, done, nil];
        
        [forward release];
        [back release];
        [reload release];
        [action release];
        [space release];
        [done release];
        
        bottomBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, (self.frame.size.height - 34.0), self.frame.size.width, 34.0)];
        bottomBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        bottomBar.tintColor = [UIColor grayColor];
        [bottomBar setItems:items];
        
        [self addSubview:bottomBar];
        [bottomBar release];
    }
    return self;
}

#pragma mark - Web view controller

- (void)loadRequest:(NSURLRequest *)request {
    mLoadingBar.titleLabel.text = [[request URL] absoluteString];
    
    [mWebView loadRequest:request];
}

- (void)back:(id)sender {
    [mWebView goBack];
    
    MKWebViewFlags.pageCount = (MKWebViewFlags.pageCount - 1);
    MKWebViewFlags.backPageCount = (MKWebViewFlags.backPageCount + 1);
    
    if (MKWebViewFlags.pageCount == 0) {
        backItem.controlState = MKControlStateDisabled;
    }
    if (MKWebViewFlags.backPageCount > 0) {
        forwardItem.controlState = MKControlStateNormal;
    }
}

- (void)forward:(id)sender {
    [mWebView goForward];
    
    MKWebViewFlags.pageCount = (MKWebViewFlags.pageCount + 1);
    MKWebViewFlags.backPageCount = (MKWebViewFlags.backPageCount - 1);
    
    if (MKWebViewFlags.pageCount == 0) {
        backItem.controlState = MKControlStateDisabled;
    }
    if (MKWebViewFlags.pageCount > 0) {
        backItem.controlState = MKControlStateNormal;
    }
    if (MKWebViewFlags.backPageCount > 0) {
        forwardItem.controlState = MKControlStateNormal;
    }
    if (MKWebViewFlags.backPageCount == 0) {
        forwardItem.controlState = MKControlStateDisabled;
    }
}

- (void)reload:(id)sender {
    [mWebView reload];
}

#pragma mark - Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [mLoadingBar.activityView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [mLoadingBar.activityView stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeFormSubmitted) {
        MKWebViewFlags.pageCount = (MKWebViewFlags.pageCount + 1);
    }
    
    if (MKWebViewFlags.pageCount > 0) {
        backItem.controlState = MKControlStateNormal;
    }
    
    return YES;
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

//-----------------------------------------------------------------------------------------------
//MKWebViewLoadingBar

@implementation MKWebViewLoadingBar

@synthesize activityView=mActivityView, titleLabel=mTitleLabel;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 1.0;
        self.opaque = NO;
        self.backgroundColor = CLEAR;
        self.autoresizesSubviews = YES;
        
        mActivityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(8.0, 2.5, 20.0, 20.0)];
        mActivityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        
        [self addSubview:mActivityView];
        [mActivityView release];
        
        mTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45.0, 2.5, (self.frame.size.width - 48.0), 20.0)];
        mTitleLabel.backgroundColor = [UIColor clearColor];
        mTitleLabel.font = COURIER_BOLD(14.0);
        mTitleLabel.textColor = [UIColor blackColor];
                
        [self addSubview:mTitleLabel];
        [mTitleLabel release];
        
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat outerMargin = 2.0;
    CGRect viewRect = CGRectInset(self.bounds, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(viewRect, 6.0);
    
    CGColorRef innerBottom = MK_COLOR_HSB(345.0, 1.0, 99.0, 1.0).CGColor;
    CGColorRef innerTop = MK_COLOR_HSB(345.0, 0.0, 82.0, 1.0).CGColor;
    CGColorRef lineColor = GRAY.CGColor;
    
    CGContextSaveGState(context);
	CGContextSetFillColorWithColor(context, innerBottom);
	CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, innerTop);
	CGContextAddPath(context, outerPath);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
	CGContextSetFillColorWithColor(context, innerBottom);
	CGContextSetShadowWithColor(context, CGSizeMake(0, -2), 3.0, BLACK.CGColor);
	CGContextAddPath(context, outerPath);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, innerBottom);
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, lineColor);
    CGContextAddPath(context, outerPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, viewRect, innerTop, innerBottom);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end
