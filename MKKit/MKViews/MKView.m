//
//  MKView.m
//  MKKit
//
//  Created by Matthew King on 10/9/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKView.h"
#import "MKPopOverView.h"

#pragma mark -
#pragma mark MKView

@implementation MKView

@synthesize x, y, width, height, controller=mController, delegate=mDelegate;

#pragma mark - Initalizer

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.autoresizesSubviews = YES;
        
        mShouldRemoveView = YES;
        
        self.x = frame.origin.x;
        self.y = frame.origin.y;
        self.width = frame.size.width;
        self.height = frame.size.height;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:MK_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
        
        MKViewFlags.isHeaderView = NO;
    }
    return self;
}

#pragma mark - Accessor methods

#pragma mark Setters

- (void)setX:(CGFloat)point {
    self.frame = CGRectMake(point, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setY:(CGFloat)point {
    self.frame = CGRectMake(self.frame.origin.x, point, self.frame.size.width, self.frame.size.height);
}

- (void)setWidth:(CGFloat)lWidth {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, lWidth, self.frame.size.height);
}

- (void)setHeight:(CGFloat)lHeight {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, lHeight);
}

#pragma mark Getters

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark - Showing the View

- (void)showWithAnimationType:(MKViewAnimationType)type; {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    mAnimationType = type;
	
    if (type == MKViewAnimationTypeNone) {
        self.alpha = 1.0;
    }
    
    if (type == MKViewAnimationTypeFadeIn) {
        self.center = WINDOW_CENTER;
        
        [UIView animateWithDuration:0.25 
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if (type == MKViewAnimationTypeMoveInFromTop) {
        CGRect moveTo = self.frame;
               
        self.frame = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), self.frame.size.width, self.frame.size.height);
        
        self.alpha = 1.0;
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.frame = moveTo; }];
    }
    
    if (type == MKViewAnimationTypeAppearAboveToolbar) {
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(320.0, self.frame.size.width), (460.0 - self.frame.size.height - TOOLBAR_HEIGHT -20.0), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if ([mDelegate respondsToSelector:@selector(MKViewDidAppear:)]) {
        [mDelegate MKViewDidAppear:self];
    }
}


- (void)showOnViewController:(UIViewController *)controller animationType:(MKViewAnimationType)type {
    [controller.view addSubview:self];
    
    CGFloat lheight = 460.0;
    CGFloat lwidth = 320.0; 
    
    if (controller.interfaceOrientation == UIInterfaceOrientationPortrait || controller.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        lheight = 460.0;
        lwidth = 320.0;
    }
    if (controller.interfaceOrientation == UIInterfaceOrientationLandscapeRight || controller.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        lheight = 300.0;
        lwidth = 480.0;
    }

    if (type == MKViewAnimationTypeNone) {
        self.alpha = 1.0;
    }
    
    if (type == MKViewAnimationTypeFadeIn) {
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(lwidth, self.frame.size.width), ((lheight / 2.0) - (self.frame.size.height / 2.0)), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25 
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if (type == MKViewAnimationTypeMoveInFromTop) {
        CGRect moveTo = self.frame;
        
        self.frame = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), lwidth, self.frame.size.height);
        
        self.alpha = 1.0;
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.frame = moveTo; }];
    }
    

    if (type == MKViewAnimationTypeAppearAboveToolbar) {
        self.frame = CGRectMake(CENTER_VIEW_HORIZONTALLY(lwidth, self.frame.size.width), (lheight - self.frame.size.height - TOOLBAR_HEIGHT -20.0), self.frame.size.width, self.frame.size.height);
        
        [UIView animateWithDuration:0.25
                         animations: ^ { self.alpha = 1.0; }];
    }
    
    if ([mDelegate respondsToSelector:@selector(MKViewDidAppear:)]) {
        [mDelegate MKViewDidAppear:self];
    }
}

#pragma mark - Removing

- (void)removeView {
    if ([mDelegate respondsToSelector:@selector(shouldRemoveView:)]) {
        mShouldRemoveView = [mDelegate shouldRemoveView:self];
    }
    
    if (mShouldRemoveView) {
        if (mAnimationType == MKViewAnimationTypeNone) {
            [self removeFromSuperview];
        }
        
        if (mAnimationType == MKViewAnimationTypeFadeIn || mAnimationType == MKViewAnimationTypeAppearAboveToolbar) {
            [UIView animateWithDuration:0.25
                             animations: ^ { self.alpha = 0.0; }
                             completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
        }
        
        if (mAnimationType == MKViewAnimationTypeMoveInFromTop) {
            CGRect moveTo = CGRectMake(self.frame.origin.x, (0.0 - self.frame.size.height), self.frame.size.width, self.frame.size.height);
            
            [UIView animateWithDuration:0.25 
                             animations: ^ { self.frame = moveTo; }
                             completion: ^ (BOOL finished) { [self removeFromSuperview]; }];
        }
    }
}

#pragma mark - Memory Management

- (void)dealloc {
    [mController release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MK_VIEW_SHOULD_REMOVE_NOTIFICATION object:nil];
    
	[super dealloc];
}

@end

@implementation MKView (MKTableHeader)

@dynamic titleLabel;

UILabel *mTitleLabel;

#pragma mark - Initalizers

- (id)initWithTitle:(NSString *)title type:(MKTableHeaderType)type {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 303.0, 40.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        
        mTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(17.0, 5.0, 303.0, 30.0)];
        mTitleLabel.backgroundColor = CLEAR;
        mTitleLabel.font = VERDANA_BOLD(16.0);
        mTitleLabel.textColor = DARK_GRAY;
        mTitleLabel.adjustsFontSizeToFitWidth = YES;
        mTitleLabel.minimumFontSize = 12.0;
        mTitleLabel.shadowColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0);
        mTitleLabel.shadowOffset = CGSizeMake(0.0, 1.0);
        mTitleLabel.text = title;
        
        [self addSubview:mTitleLabel];
        [mTitleLabel release];
        
        MKViewFlags.isHeaderView = YES;
        
        if (type == MKTableHeaderTypePlain) {
            MKViewFlags.isHeaderPlain = YES;
            mTitleLabel.textAlignment = UITextAlignmentCenter;
            mTitleLabel.frame = CGRectMake(0.0, 5.0, 315.0, 30.0);
            mTitleLabel.font = VERDANA_BOLD(20.0);
        }
    }
    return self;
}

+ (id)headerViewWithTitle:(NSString *)title type:(MKTableHeaderType)type {
    [self release];
    
    MKView *view = [[MKView alloc] initWithTitle:title type:type];
    [view autorelease];
    
    return view;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    if (MKViewFlags.isHeaderView && MKViewFlags.isHeaderPlain) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetAllowsAntialiasing(context, YES);
    
        CGColorRef topColor = MK_COLOR_HSB(345.0, 2.0, 99.0, 1.0).CGColor;
        CGColorRef bottomColor = MK_COLOR_HSB(345.0, 2.0, 86.0, 1.0).CGColor;
        
        CGContextSaveGState(context);
        drawGlossAndLinearGradient(context, rect, topColor, bottomColor);
        CGContextSaveGState(context);
    }
}

#pragma mark - Accessor Methods

#pragma mark Setters

- (void)setTitleLabel:(UILabel *)label {
    mTitleLabel = [label retain];
}

#pragma mark Getters

- (UILabel *)titleLabel {
    return mTitleLabel;
}

#pragma mark - Memory Managament

- (void)dealloc {
    [super dealloc];
}

@end
