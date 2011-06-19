//
//  MKButton.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKButton.h"

@interface MKButton ()

- (float)widthForTitle:(NSString *)title;

@end

@implementation MKButton

@synthesize type=mType, buttonText=mButtonText;

static float kHorizPadding = 20.0;

#pragma mark - Initalizer

- (id)initWithType:(MKButtonType)type {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        mType = type;
        
        if  (mType == MKButtonTypeHelp) {
            UILabel *mark = [[UILabel alloc] initWithFrame:CGRectMake(1.0, 2.0, 19.0, 18.0)];
            mark.backgroundColor = CLEAR;
            mark.font = VERDANA_BOLD(18.0);
            mark.textColor = GRAY;
            mark.textAlignment = UITextAlignmentCenter;
            mark.shadowColor = BLACK;
            mark.shadowOffset = CGSizeMake(0.0, -1.0);
            mark.text = @"?";
            
            [self addSubview:mark];
            [mark release];
        }
        else {            
            mButtonLabel = [[UILabel alloc] init];
            mButtonLabel.backgroundColor = CLEAR;
            mButtonLabel.font = SYSTEM_BOLD(14.0);
            mButtonLabel.textColor = WHITE;
            mButtonLabel.textAlignment = UITextAlignmentCenter;
            mButtonLabel.shadowColor = BLACK;
            mButtonLabel.shadowOffset = CGSizeMake(0.0, -1.0);
            
            [self addSubview:mButtonLabel];
            [mButtonLabel release];
        }
    }
    return self;
}

- (id)initWithType:(MKButtonType)type title:(NSString *)title {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, ([self widthForTitle:title] + (kHorizPadding * 2)) ,30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        mType = type;
        
        if (mType == MKButtonTypeHelp) {
            NSException *exception = [NSException exceptionWithName:@"Unsuable Type" reason:@"MKButtonTypeHelp cannot be used with the method use initWithType: instead" userInfo:nil];
            [exception raise];
        }
        
        mButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 4.5, [self widthForTitle:title], 21.0)];
        mButtonLabel.backgroundColor = CLEAR;
        mButtonLabel.font = SYSTEM_BOLD(14.0);
        mButtonLabel.textColor = WHITE;
        mButtonLabel.textAlignment = UITextAlignmentCenter;
        mButtonLabel.shadowColor = BLACK;
        mButtonLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        mButtonLabel.text = title;
        
        [self addSubview:mButtonLabel];
        [mButtonLabel release];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mType != MKButtonTypeHelp) {
        CGFloat outerMargin = 2.0;
        CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);
        CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
        
        CGColorRef innerTop;
        CGColorRef innerBottom;
        
        CGColorRef blackColor = BLACK.CGColor;
        
        if (mType == MKButtonTypeIAP) {
            if (!self.working) {
                innerTop = MK_COLOR_HSB(224.0, 57.0, 70.0, 1.0).CGColor;
                innerBottom = MK_COLOR_HSB(224.0, 57.0, 67.0, 1.0).CGColor;
            }
            else if (self.working) {
                innerTop = MK_COLOR_HSB(127.0, 84.0, 70.0, 1.0).CGColor;
                innerBottom = MK_COLOR_HSB(127.0, 84.0, 67.0, 1.0).CGColor;
            }
        }
        else if (mType == MKButtonTypeDarkBlue) {
            innerTop = MK_COLOR_HSB(224.0, 57.0, 70.0, 1.0).CGColor;
            innerBottom = MK_COLOR_HSB(224.0, 57.0, 67.0, 1.0).CGColor;
        }
        else if (mType == MKButtonTypeGreen) {
            innerTop = MK_COLOR_HSB(127.0, 84.0, 70.0, 1.0).CGColor;
            innerBottom = MK_COLOR_HSB(127.0, 84.0, 67.0, 1.0).CGColor;
        }
        
        if (!self.highlighted) {
            CGContextSaveGState(context);
            CGContextSetFillColorWithColor(context, innerBottom);
            CGContextAddPath(context, outerPath);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
            
            CGContextSaveGState(context);
            CGContextAddPath(context, outerPath);
            CGContextClip(context);
            drawGlossAndLinearGradient(context, outerRect, innerTop, innerBottom);
            CGContextRestoreGState(context);
        }
        
        else {
            CGColorRef shadowColor = MK_COLOR_RGB(51.0, 51.0, 51.0, 0.9).CGColor;
            
            CGContextSaveGState(context);
            CGContextSetFillColorWithColor(context, shadowColor);
            CGContextAddPath(context, outerPath);
            CGContextFillPath(context);
            CGContextRestoreGState(context);
        }
        
        CGContextSaveGState(context);
        CGContextSetLineWidth(context, 2.0);
        CGContextSetStrokeColorWithColor(context, blackColor);
        CGContextAddPath(context, outerPath);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        
        CFRelease(outerPath);
    }
    
    else if (mType == MKButtonTypeHelp) {
        CGRect viewRect = self.bounds;
        
        CGContextSetFillColorWithColor(context, WHITE.CGColor);
        CGContextAddEllipseInRect(context, viewRect);
        CGContextFillEllipseInRect(context, viewRect);
    }
}

#pragma mark - Accessor Methods

- (void)setButtonText:(NSString *)buttonText {
    mButtonText = [buttonText copy];
    
    CGFloat maxX = CGRectGetMaxX(self.frame);
    CGFloat minY = CGRectGetMinY(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    CGFloat x = (maxX - ([self widthForTitle:mButtonText] + (kHorizPadding * 2)));
    CGFloat width = ([self widthForTitle:mButtonText] + (kHorizPadding * 2));
    
    self.frame = CGRectMake(x, minY, width, height);
    
    mButtonLabel.frame = CGRectMake(20.0, 4.5, [self widthForTitle:mButtonText], 21.0);
    mButtonLabel.text = mButtonText;
    
    [self setNeedsDisplayInRect:CGRectMake(x, minY, width, height)];
    
    [mButtonText release];
}

- (void)setWorking:(BOOL)working {
    [super setWorking:working];
    [self setNeedsDisplay];
}

#pragma mark - Sizing

- (float)widthForTitle:(NSString *)title {
    CGSize size = [title sizeWithFont:SYSTEM_BOLD(14.0)];
    
    return size.width;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.highlighted = YES;
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.highlighted = NO;
    
    if (mType == MKButtonTypeIAP) {
        self.working = YES;
        self.buttonText = @"Installing";
    }
    else {
        [self setNeedsDisplay];
    }
}

#pragma mark - Memory Managemnet

- (void)dealloc {
    [super dealloc];
}

@end
