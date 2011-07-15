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

@synthesize delegate, type, theLabel=mTheLabel, smallLabel=_smallLabel, theImageView=mTheImageView, key,
			accessoryViewType, validationType=_validationType, validating=_validating, validator, icon=mIcon,
            iconMask=mIconMask, validatorTestStringLength=mValidatorTestStringLength, accessoryIcon=mAccessoryIcon;

#pragma mark - Initalizer

- (id)initWithType:(MKTableCellType)cellType reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.type = cellType;
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeLabel                                                      ///
		
		if (type == MKTableCellTypeLabel) {
			CGRect labelRect = CGRectMake(10.0, 11.0, 230.0, 21.0);
			
			mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
			mTheLabel.font = [UIFont fontWithName:@"Verdana-Bold" size:16.0];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = NO;
            
            [self.contentView addSubview:mTheLabel];
            [mTheLabel release];
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeDescription                                                ///
		
		if (type == MKTableCellTypeDescription) {
			CGRect smallFrame = CGRectMake(207.0, 9.0, 83.0, 21.0);
			CGRect labelRect = CGRectMake(10.0, 11.0, 190.0, 21.0);
			
			mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			
            [self.contentView addSubview:mTheLabel];
            [mTheLabel release];
            
			_smallLabel = [[UILabel alloc] initWithFrame:smallFrame];
			_smallLabel.textAlignment = UITextAlignmentRight;
			_smallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			_smallLabel.adjustsFontSizeToFitWidth = YES;
			_smallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			[self.contentView addSubview:_smallLabel];
			[_smallLabel release];
		}
				
		/////////////////////////////////////////////////////////////////////////////////////////////////
		///                 MKTableCellTypeScore                                                      ///
		
		if (type == MKTableCellTypeScore) {
			CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
			CGRect labelRect = CGRectMake(18.0, 11.0, 90.0, 21.0);
			CGRect smallFrame = CGRectMake(162.0, 11.0, 98.0, 21.0);
			
			mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
			mTheLabel.textAlignment = UITextAlignmentLeft;
            
            [self.contentView addSubview:mTheLabel];
            [mTheLabel release];
			
			_smallLabel = [[UILabel alloc] initWithFrame:smallFrame];
			_smallLabel.textAlignment = UITextAlignmentRight;
			_smallLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			_smallLabel.adjustsFontSizeToFitWidth = YES;
			_smallLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			
			mTheImageView = [[[UIImageView alloc] initWithFrame:iconRect] retain];
			
			[self.contentView addSubview:mTheImageView];
			[self.contentView addSubview:_smallLabel];
			
			self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			[mTheImageView release];
			[_smallLabel release];
		}
		
		if (type == MKTableCellTypeAction) {
			CGRect labelRect = CGRectMake(58.0, 11.0, 183.0, 21.0);
			
			mTheLabel = [[UILabel alloc] initWithFrame:labelRect];
			mTheLabel.textAlignment = UITextAlignmentLeft;
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			mTheLabel.backgroundColor = [UIColor clearColor];
			
            [self.contentView addSubview:mTheLabel];
            [mTheLabel release];
		}
		
		if (type == MKTableCellTypeButton) {
			mTheImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
			mTheImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
			[self.contentView addSubview:mTheImageView];
			[mTheImageView release];
			
			mTheLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 44.0)];
			mTheLabel.textAlignment = UITextAlignmentCenter;
			mTheLabel.backgroundColor = [UIColor clearColor];
			mTheLabel.adjustsFontSizeToFitWidth = YES;
			mTheLabel.font = [UIFont boldSystemFontOfSize:17.0];
            
            [self.contentView addSubview:mTheLabel];
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
        MKAccessoryView *iconImage = [[MKAccessoryView alloc] initWithType:MKTableCellAccessoryWarningIcon];
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

- (void)setAccessoryIcon:(UIImage *)icon {
    MKAccessoryView *iconView = [[MKAccessoryView alloc] initWithImage:icon];
    [iconView completedAction: ^ (MKAction action) {
        if (action == MKActionTouchDown) {
            [self accessoryButton:iconView];
        }
    }];
    self.accessoryView = iconView;
    [iconView release];
}

- (void)setValidationType:(MKValidationType)valType {
	_validationType = valType;
	
	if (valType == MKValidationNone) {
		_validating = NO;
		validator = nil;
	}
	else {
		_validating = YES;
		validator = [[MKValidator alloc] init];
		//[validator retain];
	}
}

- (void)setValidatorTestStringLength:(NSInteger)length {
    mValidatorTestStringLength = length;
    
    if (_validating) {
        ((MKValidator *)validator).stringLength = length;
    }
}

- (void)setIcon:(UIImage *)anImage {
	mIcon = [anImage retain];

    CGRect iconRect = CGRectMake(10.0, 7.0, 30.0, 30.0);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:iconRect];
    imageView.image = mIcon;
    
    [self.contentView addSubview:imageView];
    [imageView release];
    
    [mIcon release];
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
    if (_validating) {
        [validator release];
    }
    
    [super dealloc];
	
}

@end



@implementation MKAccessoryView

void drawWarningIcon(CGContextRef context, CGRect rect);

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

#pragma mark - Warning Icon

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

