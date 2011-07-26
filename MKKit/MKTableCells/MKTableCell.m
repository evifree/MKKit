//
//  MKTableCell.m
//  MKKit
//
//  Created by Matthew King on 3/19/10.
//  Copyright 2010 Matt King. All rights reserved.
//

#import "MKTableCell.h"

@interface MKTableCell ()

- (void)accessoryButton:(id)sender;

@end

@implementation MKTableCell

@synthesize delegate, type, theLabel=mTheLabel, smallLabel=mSmallLabel, key, accessoryViewType, 
            validationType=mValidationType, validating=mValidating, validator, icon,
            iconMask, validatorTestStringLength=mValidatorTestStringLength, accessoryIcon;

#pragma mark - Initalizer

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.type = cellType;
        
        if (type != MKTableCellTypeNone) {
            mCellView = [[MKView alloc] initWithCell:self];
            [self.contentView addSubview:mCellView];
            [mCellView release];
        }
        
        if (type == MKTableCellTypeLabel) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = NO;
            mTheLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
            
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
		}
		
		if (type == MKTableCellTypeDescription) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
            
			mSmallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mSmallLabel.textAlignment = UITextAlignmentRight;
			mSmallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mSmallLabel.adjustsFontSizeToFitWidth = YES;
			mSmallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			[mCellView addSecondaryElement:mSmallLabel];
			[mSmallLabel release];
		}
                    
		if (type == MKTableCellTypeScore) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
            
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
			
			mSmallLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mSmallLabel.textAlignment = UITextAlignmentRight;
			mSmallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mSmallLabel.adjustsFontSizeToFitWidth = YES;
			mSmallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			[mCellView addSecondaryElement:mSmallLabel];
            [mSmallLabel release];
			
			self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
		if (type == MKTableCellTypeAction) {
            mTheLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mTheLabel.backgroundColor = [UIColor clearColor];
			
            [mCellView addPrimaryElement:mTheLabel];
            [mTheLabel release];
		}
        
		[self.contentView setAutoresizesSubviews:YES];
		[self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
	return self;
}
	
#pragma mark -
#pragma mark Accessor Methods

- (void)setAccessoryViewType:(MKTableCellAccessoryViewType)aType {
	if (aType == MKTableCellAccessoryNone) {
		self.accessoryView = nil;
	}
	if (aType == MKTableCellAccessoryInfoButton) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
		[button addTarget:self action:@selector(accessoryButton:) forControlEvents:UIControlEventTouchUpInside];
		self.accessoryView = button;
	}
	if (aType == MKTableCellAccessoryWarningIcon) {
        MKControl *iconImage = [[MKControl alloc] initWithType:MKTableCellAccessoryWarningIcon];
        self.accessoryView = iconImage;
		[iconImage release];
	}
    if (aType == MKTableCellAccessoryActivity) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        [activityIndicator startAnimating];
        
        self.accessoryView = activityIndicator;
        [activityIndicator release];
    }
}

- (void)setAccessoryIcon:(UIImage *)lIcon {
    MKControl *iconView = [[MKControl alloc] initWithImage:lIcon];
    [iconView completedAction: ^ (MKAction action) {
        if (action == MKActionTouchDown) {
            [self accessoryButton:iconView];
        }
    }];
    self.accessoryView = iconView;
    [iconView release];
}

- (void)setValidationType:(MKValidationType)valType {
	mValidationType = valType;
	
	if (valType == MKValidationNone) {
		mValidating = NO;
		validator = nil;
	}
	else {
		mValidating = YES;
		validator = [[MKValidator alloc] init];
	}
}

- (void)setValidatorTestStringLength:(NSInteger)length {
    mValidatorTestStringLength = length;
    
    if (mValidating) {
        ((MKValidator *)validator).stringLength = length;
    }
}

- (void)setIcon:(UIImage *)anImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.image = anImage;
    
    [mCellView addIconElement:imageView];
    [imageView release];
}

- (void)setIconMask:(UIImage *)lIconMask {
    MKMaskIconView *iconView = [[MKMaskIconView alloc] initWithImage:lIconMask];
    [mCellView addIconElement:iconView];
    [iconView release];
}

#pragma mark -
#pragma mark Cell behavior

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        if ([delegate respondsToSelector:@selector(didSelectCell:forKey:)]) {
            [delegate didSelectCell:self forKey:self.key];
        }
    }
	
}

#pragma mark -
#pragma mark Validation Methods

- (void)validateWithType:(MKValidationType)aType {
	//Impelmented by suclasses
}

#pragma mark -
#pragma mark Actions

- (void)accessoryButton:(id)sender {
	if ([self.delegate respondsToSelector:@selector(didTapAccessoryForKey:)]) {
		[self.delegate didTapAccessoryForKey:self.key];
	}
}

#pragma mark -
#pragma mark Memory Management

- (void)dealloc {
    if (mValidating) {
        [validator release];
    }
    
    [super dealloc];
	
}

@end



@implementation MKControl (MKTableCell)

void drawWarningIcon(CGContextRef context, CGRect rect);

MKTableCellAccessoryViewType mType = MKTableCellAccessoryNone;

#pragma mark - Initalizer

- (id)initWithType:(MKTableCellAccessoryViewType)type {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = type;
        
        if (mType == MKTableCellAccessoryWarningIcon) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 5.0, 30.0, 25.0)];
            label.textAlignment = UITextAlignmentCenter;
            label.backgroundColor = CLEAR;
            label.textColor = WHITE;
            label.shadowColor = RED;
            label.shadowOffset = CGSizeMake(0.0, -1.0);
            label.font = SYSTEM_BOLD(24.0);
            label.text = @"!";
            
            [self addSubview:label];
            [label release];
        }
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0, 0.0, 30.0, 30.0);
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        
        mType = MKTableCellAccessoryNone;
        
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.frame = self.frame;
        [self addSubview:view];
        [view release];
    }
    return self;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    
    if (mType == MKTableCellAccessoryWarningIcon) {
        drawWarningIcon(context, rect);
    }
}

#pragma mark Warning Icon

void drawWarningIcon(CGContextRef context, CGRect rect) {
    CGColorRef redColor = RED.CGColor;
    
    CGPoint p1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint p2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint p3 = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path, NULL, p1.x, p1.y);
    
    CGPathCloseSubpath(path);
    
    CGContextSaveGState(context);
    CGContextSetFillColorWithColor(context, redColor);
    CGContextAddPath(context, path);
    CGContextClip(context);
    drawGlossAndLinearGradient(context, rect, redColor, redColor);
    CGContextSaveGState(context);
    
    CFRelease(path);
}

#pragma mark - Memory Managment

- (void)dealloc {
    [super dealloc];
}

@end

@implementation MKView (MKTableCell)

- (id)initWithCell:(MKTableCell *)cell {
    self = [super initWithFrame:cell.contentView.frame];
    if (self) {
        self.backgroundColor = CLEAR;
        self.opaque = NO;
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
        
        mShouldRemoveView = NO;
    }
    return self;
}

- (void)layoutCell {
    UIView *primaryElement = [self viewWithTag:1];
    UIView *secondaryElement = [self viewWithTag:2];
    UIView *iconElement = [self viewWithTag:3];
    
    if (primaryElement) {
        primaryElement.frame = CGRectMake(kCellPrimaryElementX, kCellPrimaryElementY, kCellPrimaryElementyWidth, kCellSecondaryElementHeight);
    }
    
    if (secondaryElement) {
        secondaryElement.frame = CGRectMake(kCellSecondaryElementX, kCellSecondaryElementY, kCellSecondaryElementWidth, kCellSecondaryElementHeight);
        
        if (primaryElement) {
            primaryElement.frame = CGRectMake(primaryElement.frame.origin.x, primaryElement.frame.origin.y, (primaryElement.frame.size.width - kCellSecondaryElementWidth - 5.0), primaryElement.frame.size.height);
        }
    }
    
    if (iconElement) {
        iconElement.frame = CGRectMake(kCellIconRectX, kCellIconRectY, kCellIconRectWidth, kCellIconRectHeight);
        
        if (primaryElement) {
            primaryElement.frame = CGRectMake((primaryElement.frame.origin.x + 44.0), primaryElement.frame.origin.y, (primaryElement.frame.size.width - 44.0), primaryElement.frame.size.height);
        }
    }
}

- (void)addPrimaryElement:(UIView *)element {
    element.tag = 1;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:element];
    [self layoutCell];
}

- (void)addSecondaryElement:(UIView *)element {
    element.tag = 2;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
    [self addSubview:element];
    [self layoutCell];
}

- (void)addIconElement:(UIView *)element {
    element.tag = 3;
    element.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:element];
    [self layoutCell];
}

@end

