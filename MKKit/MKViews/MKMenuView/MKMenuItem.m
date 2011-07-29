//
//  MKMenuItem.m
//  MKKit
//
//  Created by Matthew King on 5/25/11.
//  Copyright 2011 Matt King. All rights reserved.
//

#import "MKMenuItem.h"


@implementation MKMenuItem

void drawCopyButton(CGContextRef context);
void drawDoneButton(CGContextRef context, CGRect rect);
void drawPaperForRect(CGContextRef context, CGRect rect);
void drawImageButton(CGContextRef context, CGRect rect, CGImageRef image);

CGMutablePathRef createPathForPaperSheet(CGRect rect);

@synthesize type=mType;

#pragma mark - Initalizer

- (id)initWithType:(MKMenuItemType)type title:(NSString *)name target:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 1.0;
        self.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        mType = type;
        mTarget = [target retain];
        mSelector = selector;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, 60.0, 20.0)];
        title.backgroundColor = CLEAR;
        title.font = [UIFont boldSystemFontOfSize:12.0];
        title.textColor = WHITE;
        title.textAlignment = UITextAlignmentCenter;
        title.text = name;
        
        [self addSubview:title];
        [title release];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)view target:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.alpha = 1.0;
        self.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        mTarget = [target retain];
        mSelector = selector;
        
        view.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        [self addSubview:view];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image title:(NSString *)name target:(id)target selector:(SEL)selector {
    self = [super init];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.alpha = 1.0;
        self.frame = CGRectMake(0.0, 0.0, 60.0, 80.0);
        
        mImage = [image retain];
        mTarget = [target retain];
        mSelector = selector;
        mType = MKMenuItemTypeCustomImage;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 60.0, 60.0, 20.0)];
        title.backgroundColor = CLEAR;
        title.font = [UIFont boldSystemFontOfSize:12.0];
        title.textColor = WHITE;
        title.textAlignment = UITextAlignmentCenter;
        title.text = name;
        
        [self addSubview:title];
        [title release];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    CGFloat outerMargin = 2.0;
    CGRect iconRect = CGRectMake(0.0, 0.0, 60.0, 60.0);
    CGRect innerRect = CGRectInset(iconRect, outerMargin, outerMargin);
    
    CGMutablePathRef outerPath = createCircularPathForRect(innerRect); 
    
    CGColorRef outlineColor = MK_COLOR_HSB(345.0, 3.0, 80.0, 1.0).CGColor;
    CGColorRef lowerColor = MK_COLOR_HSB(345.0, 3.0, 7.0, 1.0).CGColor;
    
    if (mType == MKMenuItemTypeDelete) {
        lowerColor = MK_COLOR_HSB(345.0, 96.0, 66.0, 1.0).CGColor;
    }
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, lowerColor);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    CGContextFillRect(context, innerRect);
    CGContextRestoreGState(context);
    
    drawOutlinePath(context, outerPath, 2.0, outlineColor);
    
    if (mType == MKMenuItemTypeCopy) {
        drawCopyButton(context);
    }
    if (mType == MKMenuItemTypeCancel || mType == MKMenuItemTypeDelete) {
        drawDoneButton(context, innerRect);
    }
    if (mType == MKMenuItemTypeCustomImage) {
        CGFloat imageMargin = 10.0;
        CGRect imageRect = CGRectInset(innerRect, imageMargin, imageMargin);
        drawImageButton(context, imageRect, mImage.CGImage);
        [mImage release];
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawCurvedGloss(context, innerRect, 50.0);
    CGContextRestoreGState(context);
    
    CFRelease(outerPath);
}

#pragma mark Copy Button

void drawCopyButton(CGContextRef context) {
    CGRect pageOne = CGRectMake(17.0, 12.0, 17.0, 25.0);
    CGRect pageTwo = CGRectMake(27.0, 20.0, 17.0, 25.0);
    
    drawPaperForRect(context, pageOne);
    drawPaperForRect(context, pageTwo);
}

void drawPaperForRect(CGContextRef context, CGRect rect) {
    CGRect foldRect = CGRectMake((CGRectGetMaxX(rect) - 5.0), CGRectGetMinY(rect), 5.0, 5.0);
    CGMutablePathRef paperPath = createPathForPaperSheet(rect);
    
    CGColorRef shadowColor = MK_COLOR_RGB(51.0, 51.0, 51.0, 0.5).CGColor;
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1.0), 1.0, GRAY.CGColor);
    CGContextSetFillColorWithColor(context, LIGHT_GRAY.CGColor);
    CGContextAddPath(context, paperPath);
    CGContextClip(context);
    CGContextAddRect(context, rect);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0, 2.0), 3.0, shadowColor);
    CGContextSetFillColorWithColor(context, BLACK.CGColor);
    CGContextAddPath(context, paperPath);
    CGContextClip(context);
    CGContextAddRect(context, foldRect);
    CGContextStrokeRect(context, foldRect);
    CGContextRestoreGState(context);
    
    CFRelease(paperPath);
    
    for (int i = 0; i < 3; i ++) {
        CGPoint start = CGPointMake((CGRectGetMinX(rect) + 2.0), (CGRectGetMinY(rect) + (7.0 + (7.0 * i))));
        CGPoint end = CGPointMake((CGRectGetMaxX(rect) - 2.0), (CGRectGetMinY(rect) + (7.0 + (7.0 * i))));
        
        CGMutablePathRef line = CGPathCreateMutable();
        CGPathMoveToPoint(line, NULL, start.x, start.y);
        CGPathAddLineToPoint(line, NULL, end.x, end.y);
        
        CGContextSaveGState(context);
        CGContextSetFillColorWithColor(context, shadowColor);
        CGContextAddPath(context, line);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
        
        CFRelease(line);
    }
}

CGMutablePathRef createPathForPaperSheet(CGRect rect) {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPoint p1 = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake((CGRectGetMaxX(rect) - 5.0), CGRectGetMinY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMaxX(rect), (CGRectGetMinY(rect) + 5.0));
    CGPoint p4 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    CGPoint p5 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p4.x, p4.y);
    CGPathAddLineToPoint(path, NULL, p5.x, p5.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark Done/Delete Button

void drawDoneButton(CGContextRef context, CGRect rect) {
    CGRect viewRect = CGRectMake(15.0, 2.0, 45.0, 45.0);
    
    NSString *x = [NSString stringWithFormat:@"X"];
    
    CGContextSaveGState(context);
    drawText(context, viewRect, (CFStringRef)x, LIGHT_GRAY.CGColor, LIGHT_GRAY.CGColor, 40.0);
    CGContextRestoreGState(context);
}

#pragma mark - Image Button

void drawImageButton(CGContextRef context, CGRect rect,  CGImageRef image) {
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = (CGRectGetMinY(rect) - ((CGRectGetHeight(rect) / 2.0) + 5.0));
    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGRect displayRect = CGRectMake(x, y, width, height);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, LIGHT_GRAY.CGColor);
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, displayRect, image);
    CGContextClipToMask(context, displayRect, image);
    CGContextFillRect(context, displayRect);
    CGContextRestoreGState(context);
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
	UITouch *touch = [[event allTouches] anyObject];
	NSInteger taps = [touch tapCount];
    
    if (taps == 1) {
        [mTarget performSelector:mSelector withObject:self];
    }
}

#pragma mark - Memory Managment

- (void)dealloc {
    [mTarget release];
    
    [super dealloc];
}

@end
