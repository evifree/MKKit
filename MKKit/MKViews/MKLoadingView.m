//
//  MKViewLoading.m
//  MKKit
//
//  Created by Matthew King on 7/12/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKLoadingView.h"

@implementation MKLoadingView

@synthesize statusText=mStatusText, type=mType, progress;

void drawProgressBar(CGContextRef context, CGRect rect);

CGFloat lProgress = 0.0;

#pragma mark - Initalizer

- (id)initWithType:(MKLoadingViewType)type status:(NSString *)status {
    self = [super initWithFrame:CGRectMake(0.0, 0.0, 150.0, 150.0)];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 0.0;
        
        mType = type;
        
        mStatusLabel= [[UILabel alloc] initWithFrame:CGRectMake(0.0, 100.0, 150.0, 22.0)];
		mStatusLabel.font = VERDANA_BOLD(17.0); 
		mStatusLabel.textColor = [UIColor whiteColor];
		mStatusLabel.backgroundColor = [UIColor clearColor];
		mStatusLabel.textAlignment = UITextAlignmentCenter;
        mStatusLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
        mStatusLabel.adjustsFontSizeToFitWidth = YES;
        mStatusLabel.text = status;
        
        [self addSubview:mStatusLabel];
        [mStatusLabel release];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        self.autoresizesSubviews = YES;
        
        if (mType == MKLoadingViewTypeIndicator) {
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(CENTER_VIEW_HORIZONTALLY(150.0, 37.0), 30.0, 37.0, 37.0)];
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
            [activityIndicator startAnimating];
            
            [self addSubview:activityIndicator];
        }
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGRect viewRect = self.bounds;
    
    CGMutablePathRef rrect = createRoundedRectForRect(viewRect, 20.0);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, BLACK.CGColor);
    CGContextAddPath(context, rrect);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, rrect);
    CGContextClip(context);
    drawCurvedGloss(context, viewRect, 150.0);
    CGContextSaveGState(context);
    
    CFRelease(rrect);
    
    if (mType == MKLoadingViewTypeProgressBar) {
        CGRect barRect = CGRectMake(10.0, 47.0, 130.0, 20.0);
        drawProgressBar(context, barRect);
    }
}

void drawProgressBar(CGContextRef context, CGRect rect) {
    CGFloat margin = 2.0;
    CGRect innerRect = CGRectInset(rect, margin, margin);
    CGFloat width = (innerRect.size.width * lProgress);
    CGRect barRect = CGRectMake(innerRect.origin.x, innerRect.origin.y, width, innerRect.size.height);
    
    CGMutablePathRef outerPath = createRoundedRectForRect(rect, 10.0);
    CGMutablePathRef innerPath = createRoundedRectForRect(barRect, 7.0);
    
    drawOutlinePath(context, outerPath, 2.0, WHITE.CGColor);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextAddPath(context, innerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
}

#pragma mark - Accessor Methods

- (void)setProgress:(CGFloat)prog {
    lProgress = prog;
    [self setNeedsDisplay];
}

- (void)setStatusText:(NSString *)text {
    mStatusLabel.text = text;
} 
 
- (void)dealloc {
    [super dealloc];
}


@end
