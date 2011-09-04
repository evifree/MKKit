//
//  MKButton.m
//  MKKit
//
//  Created by Matthew King on 5/28/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKButton.h"

@interface MKButton ()

- (void)labelWithText:(NSString *)text;

@end

@implementation MKButton

@synthesize type=mType, buttonText=mButtonText, tintColor, fontSize;

void drawHelpButton(CGContextRef context, CGRect rect);
void drawDiscloserButton(CGContextRef context, CGRect rect);
void drawDropDownIndicatorButton(CGContextRef context, CGRect rect, CGColorRef tint, bool highlighted);
void drawIAPButton(CGContextRef context, CGRect rect, bool working, bool highlighted);
void drawPlasticButton(CGContextRef context, CGRect rect, CGColorRef tint, bool highlighted);
void drawRoundRectButton(CGContextRef context, CGRect rect, CGColorRef tint, bool highlighted);

bool mHighlighted = NO;

#pragma mark - Initalizer

- (id)initWithType:(MKButtonType)type {
    self = [super init];
    if (self) {
        self = [self initWithType:type title:nil tint:nil];
    }
    return self;
}

- (id)initWithType:(MKButtonType)type title:(NSString *)title {
    self = [super init];
    if (self) {
        self = [self initWithType:type title:title tint:nil];
    }
    return self;
}

- (id)initWithType:(MKButtonType)type title:(NSString *)title tint:(UIColor *)tint {
    self = [super init];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = type;
        MKButtonFlags.isWorking = NO;
        MKButtonFlags.isHighlighted = NO;
        
        if  (mType == MKButtonTypeHelp) {
            MKButtonFlags.fontSize = kHelpButtonFontSize;
            [self labelWithText:@"?"];
        }
        
        if (mType == MKButtonTypeDisclosure) {
            self.frame = CGRectMake(0.0, 0.0, 25.0, 25.0);
        }
        
        if (mType == MKButtonTypeDropDownIndicator) {
            self.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            if (tint) {
                MKButtonFlags.tintColor = tint.CGColor;
            }
            else {
                MKButtonFlags.tintColor = LIGHT_GRAY.CGColor;
            }

        }
        
        if (mType == MKButtonTypeIAP) {
            self.frame = CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, SYSTEM_BOLD(kIAPButtonFontSize)) + (kHorizPadding * 2)) ,30.0);
            MKButtonFlags.fontSize = kIAPButtonFontSize;
            [self labelWithText:title];
        }
        
        if (mType == MKButtonTypePlastic) {
            self.frame = CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, VERDANA_BOLD(kPlasticButtonFontSize)) + (kHorizPadding * 2)) ,30.0);
            MKButtonFlags.fontSize = kPlasticButtonFontSize;
            
            if (tint) {
                MKButtonFlags.tintColor = tint.CGColor;
            }
            else {
                MKButtonFlags.tintColor = BLACK.CGColor;
            }
            
            [self labelWithText:title];
        }
        
        if (mType == MKButtonTypeRoundedRect) {
            self.frame = CGRectMake(0.0, 0.0, (MK_TEXT_WIDTH(title, SYSTEM_BOLD(kRoundRectButtonFontSize)) + (kHorizPadding * 2)) ,30.0);
            MKButtonFlags.fontSize = kRoundRectButtonFontSize;
            
            if (tint) {
                MKButtonFlags.tintColor = tint.CGColor;
            }
            else {
                MKButtonFlags.tintColor = BLUE.CGColor;
            }
            
            [self labelWithText:title];
        }
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mType == MKButtonTypeHelp) {
        drawHelpButton(context, rect);
    }
    else if (mType == MKButtonTypeDisclosure) {
        drawDiscloserButton(context, rect);
    }
    else if (mType == MKButtonTypeDropDownIndicator) {
        drawDropDownIndicatorButton(context, rect, MKButtonFlags.tintColor, MKButtonFlags.isHighlighted);
    }
    else if (mType == MKButtonTypeIAP) {
        drawIAPButton(context, rect, MKButtonFlags.isWorking, MKButtonFlags.isHighlighted);
    }
    else if (mType == MKButtonTypePlastic) {
        drawPlasticButton(context, rect, MKButtonFlags.tintColor, MKButtonFlags.isHighlighted);
        mButtonLabel.frame = rect;
    }
    else if (mType == MKButtonTypeRoundedRect) {
        drawRoundRectButton(context, rect, MKButtonFlags.tintColor, MKButtonFlags.isHighlighted);
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

#pragma mark Drop Down Indicator Button

void drawDropDownIndicatorButton(CGContextRef context, CGRect rect, CGColorRef tint, bool highlighted) {
    CGFloat outerMargin = 1.0;
    CGFloat buttonMargin = 1.0;
    CGFloat arrowMargin = 10.0;
    
    CGRect innerRect = CGRectInset(rect, outerMargin, outerMargin);
    CGRect buttonRect = CGRectInset(innerRect, buttonMargin, buttonMargin);
    CGRect startArrowRect = CGRectInset(innerRect, arrowMargin, arrowMargin);
    CGRect arrowRect = CGRectMake(startArrowRect.origin.x, (startArrowRect.origin.y + 3.0), startArrowRect.size.width, (startArrowRect.size.height -2.0));
    
    CGMutablePathRef buttonPath = createRoundedRectForRect(buttonRect, 7.0);
    CGMutablePathRef outlinePath = createRoundedRectForRect(innerRect, 7.0);
    CGMutablePathRef arrowPath = createPathForDownPointer(arrowRect);
    
    CGColorRef shadowColor = MK_COLOR_HSB(345.0, 2.0, 56.0, 1.0).CGColor;
    
    drawOutlinePath(context, outlinePath, 0.5, BLACK.CGColor);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, -1.0), 1.0, BLACK.CGColor);
    CGContextSetFillColorWithColor(context, tint);
    CGContextAddPath(context, buttonPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, shadowColor);
    CGContextAddPath(context, buttonPath);
    CGContextClip(context);
    drawLinearGloss(context, buttonRect);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, WHITE.CGColor);
    CGContextSetFillColorWithColor(context, DARK_GRAY.CGColor);
    CGContextAddPath(context, arrowPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    if (highlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, BLACK.CGColor);
        CGContextAddPath(context, buttonPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CFRelease(buttonPath);
    CFRelease(outlinePath);
    CFRelease(arrowPath);
}

#pragma mark IAP Button

void drawIAPButton(CGContextRef context, CGRect rect, bool working, bool highlighted) {
    CGFloat outerMargin = 2.0;
    CGRect outerRect = CGRectInset(rect, outerMargin, outerMargin);
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 6.0);
        
    CGColorRef innerTop;
    CGColorRef innerBottom;
        
    CGColorRef blackColor = BLACK.CGColor;
    
    if (!working) {
        innerTop = MK_COLOR_HSB(224.0, 57.0, 70.0, 1.0).CGColor;
        innerBottom = MK_COLOR_HSB(224.0, 57.0, 67.0, 1.0).CGColor;
    }
    else if (working) {
        innerTop = MK_COLOR_HSB(127.0, 84.0, 70.0, 1.0).CGColor;
        innerBottom = MK_COLOR_HSB(127.0, 84.0, 67.0, 1.0).CGColor;
    }

    if (!highlighted) {
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

#pragma mark Plastic Button

void drawPlasticButton(CGContextRef context, CGRect rect, CGColorRef tint, bool highlighted) {
    CGFloat outerMargin = 1.0;
    CGFloat buttonMargin = 1.0;
    
    CGRect innerRect = CGRectInset(rect, outerMargin, outerMargin);
    CGRect buttonRect = CGRectInset(innerRect, buttonMargin, buttonMargin);
    
    CGMutablePathRef buttonPath = createRoundedRectForRect(buttonRect, 7.0);
    CGMutablePathRef outlinePath = createRoundedRectForRect(innerRect, 7.0);
    
    CGColorRef shadowColor = MK_COLOR_HSB(345.0, 2.0, 56.0, 1.0).CGColor;
    
    drawOutlinePath(context, outlinePath, 0.5, BLACK.CGColor);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, -1.0), 1.0, BLACK.CGColor);
    CGContextSetFillColorWithColor(context, WHITE.CGColor);
    CGContextAddPath(context, buttonPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, shadowColor);
    CGContextSetFillColorWithColor(context, tint);
    CGContextAddPath(context, buttonPath);
    CGContextFillPath(context);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextAddPath(context, buttonPath);
    CGContextClip(context);
    drawCurvedGloss(context, buttonRect, 40.0);
    CGContextRestoreGState(context);
    
    if (highlighted) {
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, BLACK.CGColor);
        CGContextAddPath(context, buttonPath);
        CGContextFillPath(context);
        CGContextRestoreGState(context);
    }
    
    CFRelease(buttonPath);
    CFRelease(outlinePath);
}

#pragma mark Rounded Rect Button

void drawRoundRectButton(CGContextRef context, CGRect rect, CGColorRef tint,  bool highlighted) {
    CGFloat margin = 2.0;
    CGRect buttonRect = CGRectInset(rect, margin, margin);
    
    CGMutablePathRef rrectPath = createRoundedRectForRect(buttonRect, 10.0);
    
    const CGFloat* components = CGColorGetComponents(tint);
    
    CGFloat red = components[0];
    CGFloat green = components[1];
    CGFloat blue = components[2];
    CGFloat alpha = CGColorGetAlpha(tint);
    
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
    drawGlossAndLinearGradient(context, buttonRect, topColor, tint);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, BLACK.CGColor);
    CGContextAddPath(context, rrectPath);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    if (highlighted) {
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
    MKButtonFlags.isHighlighted = highlighted;
    
    [self setNeedsDisplay];
}

- (void)setButtonText:(NSString *)buttonText {
    mButtonText = [buttonText copy];
    
    CGFloat maxX = CGRectGetMaxX(self.frame);
    CGFloat minY = CGRectGetMinY(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
        
    CGFloat x = (maxX - (MK_TEXT_WIDTH(buttonText, SYSTEM_BOLD(MKButtonFlags.fontSize)) + (kHorizPadding * 2)));
    CGFloat width = (MK_TEXT_WIDTH(buttonText, SYSTEM_BOLD(MKButtonFlags.fontSize)) + (kHorizPadding * 2));
        
    self.frame = CGRectMake(x, minY, width, height);
        
    mButtonLabel.frame = CGRectMake(20.0, 4.5, MK_TEXT_WIDTH(buttonText, SYSTEM_BOLD(MKButtonFlags.fontSize)), 21.0);
    mButtonLabel.text = mButtonText;
    
    [self setNeedsDisplayInRect:CGRectMake(x, minY, width, height)];
    
    [mButtonText release];
}

- (void)setWorking:(BOOL)isWorking {
    [super setWorking:isWorking];
    MKButtonFlags.isWorking = isWorking;
    
    [self setNeedsDisplay];
}

- (void)setTintColor:(UIColor *)color {
    MKButtonFlags.tintColor = color.CGColor;
    [self setNeedsDisplay];
}

- (void)setFontSize:(CGFloat)size {
    MKButtonFlags.fontSize = size;
    mButtonLabel.font = SYSTEM_BOLD(size);
}

#pragma mark - Elements

- (void)labelWithText:(NSString *)text {
    mButtonLabel = [[UILabel alloc] init];
    mButtonLabel.backgroundColor = CLEAR;
    mButtonLabel.textAlignment = UITextAlignmentCenter;
    mButtonLabel.shadowColor = BLACK;
    mButtonLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    mButtonLabel.text = text;
    
    if (mType == MKButtonTypeHelp) {
        mButtonLabel.frame = CGRectMake(1.0, 2.0, 19.0, 18.0);
        mButtonLabel.font = VERDANA_BOLD(MKButtonFlags.fontSize);
        mButtonLabel.textColor = GRAY;
    }
    if  (mType == MKButtonTypeIAP) {
        mButtonLabel.frame = CGRectMake(20.0, 4.5, MK_TEXT_WIDTH(text, SYSTEM_BOLD(MKButtonFlags.fontSize)), 21.0);
        mButtonLabel.textColor = WHITE;
        mButtonLabel.font = SYSTEM_BOLD(MKButtonFlags.fontSize);
        mButtonLabel.text = text;
    }
    if (mType == MKButtonTypeRoundedRect || mType == MKButtonTypePlastic) {
        mButtonLabel.textColor = WHITE;
        mButtonLabel.font = SYSTEM_BOLD(MKButtonFlags.fontSize);
        mButtonLabel.text = text;
        mButtonLabel.shadowColor = [UIColor colorWithCGColor:MKButtonFlags.tintColor];
        
        if (mType == MKButtonTypePlastic) {
            mButtonLabel.font = VERDANA_BOLD(MKButtonFlags.fontSize);
        }
    }
    
    [self addSubview:mButtonLabel];
    [mButtonLabel release];
}

/*
#pragma mark - Sizing

- (float)widthForTitle:(NSString *)title {
    CGSize size = [title sizeWithFont:SYSTEM_BOLD(mFontSize)];
    
    return size.width;
}
*/

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
