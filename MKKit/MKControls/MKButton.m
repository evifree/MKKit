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

@synthesize type=mType, buttonText=mButtonText, tintColor, fontSize;

void drawHelpButton(CGContextRef context, CGRect rect);
void drawDiscloserButton(CGContextRef context, CGRect rect);
void drawIAPButton(CGContextRef context, CGRect rect);
void drawRoundRectButton(CGContextRef context, CGRect rect);

static CGColorRef mTintColor = nil; 
static CGFloat mFontSize = 14.0;

bool mHighlighted = NO;
bool lWorking = NO;

#pragma mark - Initalizer

- (id)initWithType:(MKButtonType)type {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 20.0, 20.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = type;
        self.fontSize = 14.0;
        
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
        else if (mType == MKButtonTypeDisclosure) {
            self.frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
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
        
        if (mType == MKButtonTypeRoundedRect) {
            mTintColor = [UIColor blueColor].CGColor;
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
        self.fontSize = 14.0;
    
        mType = type;
        
        if (mType == MKButtonTypeHelp) {
            NSException *exception = [NSException exceptionWithName:@"Unsuable Type" reason:@"MKButtonTypeHelp cannot be used with the method use initWithType: instead" userInfo:nil];
            [exception raise];
        }
        if (mType == MKButtonTypeRoundedRect) {
            mTintColor = [UIColor blueColor].CGColor;
        }
        
        mButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 4.5, [self widthForTitle:title], 21.0)];
        mButtonLabel.backgroundColor = CLEAR;
        mButtonLabel.font = SYSTEM_BOLD(14.0);
        mButtonLabel.textColor = WHITE;
        mButtonLabel.textAlignment = UITextAlignmentCenter;
        mButtonLabel.adjustsFontSizeToFitWidth = YES;
        mButtonLabel.shadowColor = BLACK;
        mButtonLabel.shadowOffset = CGSizeMake(0.0, -1.0);
        mButtonLabel.text = title;
        
        [self addSubview:mButtonLabel];
        [mButtonLabel release];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mType == MKButtonTypeIAP) {
        drawIAPButton(context, rect);
    }
    else if (mType == MKButtonTypeDisclosure) {
        drawDiscloserButton(context, rect);
    }
    else if (mType == MKButtonTypeHelp) {
        drawHelpButton(context, self.bounds);
    }
    else if (mType == MKButtonTypeRoundedRect) {
        drawRoundRectButton(context, rect);
        mButtonLabel.shadowColor = [UIColor colorWithCGColor:mTintColor];
        mButtonLabel.frame = rect;
    }
}

#pragma mark Help Button

void drawHelpButton(CGContextRef context, CGRect rect) {
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextAddEllipseInRect(context, rect);
    CGContextFillEllipseInRect(context, rect);
}

#pragma mark Discloser Button

void drawDiscloserButton(CGContextRef context, CGRect rect) {
    CGRect innerRect = CGRectInset(rect, kDiscloserOutlinePadding, kDiscloserOutlinePadding);
    
    CGColorRef borderColor = WHITE.CGColor;
    CGColorRef innerColor = MK_COLOR_RGB(0.0, 0.0, 255.0, 1.0).CGColor;
    
    CGMutablePathRef outerPath = createCircularPathForRect(rect);
    CGMutablePathRef innerPath = createCircularPathForRect(innerRect);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, borderColor);
    CGContextAddPath(context, outerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, innerColor);
    CGContextAddPath(context, innerPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGPoint p1 = CGPointMake(10.0, 7.0);
    CGPoint p2 = CGPointMake(16.0, 12.0);
    CGPoint p3 = CGPointMake(10.0, 17.0);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, p1.x, p1.y);
    CGContextAddLineToPoint(context, p2.x, p2.y);
    CGContextAddLineToPoint(context, p3.x, p3.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawCurvedGloss(context, rect, 40.0);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
    CFRelease(innerPath);
}

#pragma mark IAP Button

void drawIAPButton(CGContextRef context, CGRect rect) {
    CGFloat outerMargin = 2.0;
    CGRect outerRect = CGRectInset(rect, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
        
    CGColorRef innerTop;
    CGColorRef innerBottom;
        
    CGColorRef blackColor = BLACK.CGColor;
    
    NSLog(@"Draw %i", lWorking);
    
    if (!lWorking) {
        innerTop = MK_COLOR_HSB(224.0, 57.0, 70.0, 1.0).CGColor;
        innerBottom = MK_COLOR_HSB(224.0, 57.0, 67.0, 1.0).CGColor;
    }
    else if (lWorking) {
        innerTop = MK_COLOR_HSB(127.0, 84.0, 70.0, 1.0).CGColor;
        innerBottom = MK_COLOR_HSB(127.0, 84.0, 67.0, 1.0).CGColor;
    }

    if (!mHighlighted) {
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

#pragma mark Rounded Rect Button

void drawRoundRectButton(CGContextRef context, CGRect rect) {
    CGFloat margin = 2.0;
    CGRect buttonRect = CGRectInset(rect, margin, margin);
    
    CGMutablePathRef rrectPath = createRoundedRectForRect(buttonRect, 10.0);
    
    const CGFloat* components = CGColorGetComponents(mTintColor);
    
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = CGColorGetAlpha(mTintColor);
    
    CGColorRef topColor = [UIColor colorWithRed:red green:green blue:blue alpha:(alpha - 0.5)].CGColor;
    
    CFRelease(components);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextAddPath(context, rrectPath);
    CGContextFillPath(context),
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, rrectPath);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, buttonRect, topColor, mTintColor);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, BLACK.CGColor);
    CGContextAddPath(context, rrectPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    if (mHighlighted) {
        CGColorRef shadowColor = MK_COLOR_RGB(51.0, 51.0, 51.0, 0.9).CGColor;
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, shadowColor);
        CGContextAddPath(context, rrectPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context); 
    }
    
    CFRelease(rrectPath);
}

#pragma mark - Accessor Methods

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    mHighlighted = highlighted;
    
    [self setNeedsDisplay];
}

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
    
    //if (mType == MKButtonTypeIAP) {
     //   if ([buttonText isEqualToString:@"Installing"]) {
     //       mWorking = YES;
     //   }
    //}
        
    [self setNeedsDisplayInRect:CGRectMake(x, minY, width, height)];
    
    [mButtonText release];
}

- (void)setWorking:(BOOL)isWorking {
    [super setWorking:isWorking];
    lWorking = isWorking;
    NSLog(@"%i", lWorking);
    
    [self setNeedsDisplay];
}

- (void)setTintColor:(UIColor *)color {
    mTintColor = color.CGColor;
    [self setNeedsDisplay];
}

- (void)setFontSize:(CGFloat)size {
    mFontSize = size;
    mButtonLabel.font = SYSTEM_BOLD(size);
}

#pragma mark - Sizing

- (float)widthForTitle:(NSString *)title {
    CGSize size = [title sizeWithFont:SYSTEM_BOLD(mFontSize)];
    
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
        self.buttonText = @"Installing";
        self.working = YES;
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
